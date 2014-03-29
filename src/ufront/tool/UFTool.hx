package ufront.tool;

import haxe.ds.StringMap;
import haxe.Json;
import mcli.CommandLine;
import mcli.Dispatch;
import sys.FileSystem;
import sys.io.File;
import sys.io.Process;
import sys.net.Host;
import Sys.*;
using haxe.io.Path;
using StringTools;

/**
	-------------------------------------------------------------------
	Ufront Tool:
	A command line tool to help you manage your ufront project.  
	-------------------------------------------------------------------

	Usage:
**/
class UFTool extends CommandLine {

	var ufrontDir:String;
	
	public function new( ufrontDir:String ) {
		this.ufrontDir = ufrontDir;
		super();
	}

	///**
	//	Create a new ufront project, controller, model, API or view based on a simple template.
	//	@alias n
	//**/
	//public function new() {
	//	println("setup a new project");
	//	configure();
	//}

	///**
	//	Configure the current project's settings
	//	@alias c
	//**/
	//public function configure() {
	//	println("configure settings");
	//}

	/**
		Build the current project
		@alias b
	**/
	public function build( d:Dispatch ) {
		d.dispatch(new BuildCommand());
	}
	
	/**
		Run a development server using "nekotools server" on localhost:2987
		@alias s
	**/
	public function server( d:Dispatch ) {
		d.dispatch(new ServerCommand());
	}
	
	/**
		Run an interactive shell (ihx) and import your key project files
		@alias i
	**/
	public function shell( d:Dispatch ) {
		d.dispatch(new ShellCommand());
	}
	
	/**
		Run one of the tasks defined in your project.
		@alias t
	**/
	public function task( d:Dispatch ) {
		d.dispatch(new TaskCommand());
	}
	
	/**
		Run the unit tests for your app.
		@alias u
	**/
	public function unittest( d:Dispatch ) {
		d.dispatch(new UnitTestCommand());
	}
	
	/**
		Deploy the current build of your app.
		@alias d
	**/
	public function deploy( d:Dispatch ) {
		d.dispatch( new DeployCommand(getCwd()) );
	}
	
	///**
	//	Watch your project using `livehaxe` and compile when changes are found.
	//	@alias w
	//**/
	//public function watch() {
	//	println("Watch and compile");
	//	exit(0);
	//}

	public function runDefault() {
		help();
		exit( 0 );
	}

	/**
		Show the help message.
	**/
	public function help() {
		println(this.showUsage());
	}

	/**
		Setup shortcuts so you can type `ufront` instead of `haxelib run ufront`.  May need to run with "sudo"
	**/
	public function setup() {
		switch Sys.systemName() {
			case "Windows":
				var content = "@haxelib run ufront %*";
				try {
					var path = Sys.getEnv("HAXEPATH");
					if (path == null || path.length == 0) {
						throw "HAXEPATH environment variable not found.";
					}
					sys.io.File.saveContent( '$path/ufront.bat', content );
					println( 'Saved script to $path/ufront.bat\n`ufront` is now redirected to `haxelib run ufront`');
				}
				catch ( e:Dynamic ) {
					println( 'Error: $e' );
					println( "Failed to save to `%HAXEPATH%/ufront.bat`." );
					println( "You can manually add ufront.bat to any folder in your PATH" );
					println( '  contents of the file: $content' );
					exit(1);
				}
			default:
				var content = "#!/bin/sh\n\nhaxelib run ufront $@";
				try {
					sys.io.File.saveContent( "/usr/bin/ufront", content );
					var exitCode = Sys.command( "chmod", "+x /usr/bin/ufront".split(" ") );
					println( "Saved script to /usr/bin/ufront to redirect to `haxelib run ufront` ");
					exit( exitCode );
				}
				catch ( e:Dynamic ) {
					println( "Failed to save to `/usr/bin/ufront`.  Perhaps you need to run with `sudo`?" );
					exit(1);
				}
		}
		exit( 0 );
	}

	public static function main() {
		var args = args();
		var calledFrom = new Path( executablePath() );
		var ufrontDir = getCwd();
		if ( calledFrom.file=="haxelib" || calledFrom.file=="ufront" || Sys.systemName()=="Windows" ) {
			setCwd( args.pop() );
		} else {
			// Give a message to help understand haxelib's confusing behaviour.  
			// If running "sudo haxelib run ufront --setup", don't complain.
			if ( !(args.length>0 && args[0]=="--setup") ) {
				println("We are making the assumption that you are running `neko run.n` from the ufront haxelib folder. Use `haxelib run ufront` to be sure.");
			}
		}
		new mcli.Dispatch( args ).dispatch( new UFTool(ufrontDir) );
	}
}

class UfrontCommand extends CommandLine
{
	/**
		print this message
		@command
		@alias h
	**/
	public function help()
	{
		Sys.println(this.toString());
		exit( 0 );
	}
}

/**
	-------------------------------------------------------------------
	Ufront Tool:
	  ufront build
	
	Builds one or all of your project hxml files.  
	-------------------------------------------------------------------

	Usage:
**/
class BuildCommand extends UfrontCommand
{
	/**
		be verbose
		@alias v
	**/
	public var verbose:Bool;

	/**
		Flag to compile in debug mode
		@alias d
	**/
	public var debug:Bool;

	/**
		A comma separated list of -D defines to pass to the compiler
		@alias D
	**/
	public var define:String;

	/**
		Change the dead code elimination level (full,std,no)
	**/
	public var dce:DCELevel;

	public function runDefault( ?target:String )
	{
		doBuild( target );
		exit( 0 );
	}

	public function doBuild( ?target:String )
	{
		if ( target!=null && target.endsWith(".hxml") ) target = target.substr(0,-5);
		var buildFiles = [ for ( f in FileSystem.readDirectory(getCwd()) ) if (f.endsWith(".hxml")) f ];

		var foundBuilds = 0;

		var args = [];
		if ( define!=null ) for ( arg in define.split(",") ) {
			args.push( "-D" );
			args.push( arg );
		}
		if ( dce!=null ) { 
			args.push( "-dce" );
			args.push( Std.string(dce) );
		}
		if ( debug ) args.push("-debug");
		if ( verbose ) args.push("-v");
		
		if ( args.length>0 ) 
			println( 'Arguments: '+args.join(" ") );

		var buildFailures = [];
		for ( hxml in buildFiles ) {
			if ( target!=null && hxml!='$target.hxml' ) continue;

			foundBuilds++;
			println ('Build $hxml');
			
			args.push( hxml );

			if ( Sys.command("haxe", args) != 0 ) {
				buildFailures.push( hxml );
			}

			args.pop();
		}

		if ( buildFailures.length>0 ) {
			println ('Failed to build ${buildFailures.join(", ")}\n');
			exit( 1 );
		}

		if ( target!=null && foundBuilds==0 ) { 
			println('Build $target.hxml not found');
			exit( 1 );
		}
	}
}

enum DCELevel {
	no;
	std;
	full;
}

/**
	-------------------------------------------------------------------
	Ufront Tool:
	  ufront shell
	
	Run an interactive shell (ihx), loading in all our source files and
	required libraries.
	-------------------------------------------------------------------

	Usage:
**/
class ShellCommand extends UfrontCommand
{
	public function runDefault()
	{
		if ( 0 != new sys.io.Process("haxelib", ["path", "ihx"]).exitCode() ) {
			println("ihx not installed, you can install it with:");
			println("    haxelib install ihx");
			exit(1);
		}

		var args = ["run", "ihx"];
		var libs = [];
		var classPaths = [];
		var defines = [];
		var debug = false;
		
		var buildFiles = [ for ( f in FileSystem.readDirectory(getCwd()) ) if (f.endsWith(".hxml")) f ];
		for ( hxml in buildFiles ) {
			
			var lines = File.getContent( hxml ).split( "\n" );

			var isServerBuild = true;
			for ( line in lines ) 
				if ( line.startsWith("-D client") )
					isServerBuild = false;

			if ( isServerBuild )
				for ( line in lines ) {
					if ( line.startsWith("-cp ") ) 
						classPaths.push( line.split(" ")[1] );
					else if ( line.startsWith("-lib ") ) 
						libs.push( line.split(" ")[1] );
					else if ( line.startsWith("-D ") ) 
						defines.push( line.split(" ")[1] );
					else if ( line.startsWith("-debug ") ) 
						debug = true;
				}

		}

		for ( c in classPaths ) args.push('-cp $c'); 
		for ( l in libs ) args.push('-lib $l'); 
		for ( d in defines ) args.push('-D $d'); 
		if ( debug ) args.push("-debug");
		
		Sys.command("haxelib", args);
		exit(0);
	}
}


/**
	-------------------------------------------------------------------
	Ufront Tool:
	  ufront server
	
	Run a local development server (using `nekotools server`).
	-------------------------------------------------------------------

	Usage:
**/
class ServerCommand extends UfrontCommand
{
	/** 
		The port to run the server on.  `2987` by default.
	**/
	public var port:Int = 2987;
	
	/** 
		The directory to launch the server in.  "Out" by default.
	**/
	public var dir:String = "out";
	
	/** 
		Server name to listen on.  Can be an IP address.  Will be the value of `Host.localhost().toString()` by default.
	**/
	public var host:String = null;
	
	/** 
		Flag to disable URL rewriting on server  (URL rewriting is enabled by default)
	**/
	public var norewrite:Bool = false;

	public function runDefault()
	{
		if ( host==null ) host = Host.localhost().toString();

		if ( sys.FileSystem.exists(dir) ) {
			println('Switching directory to `$dir`');
			var originalCwd = getCwd();
			setCwd(dir);

			var args = ["server"];
			args.push( "-h" );
			args.push( host );
			args.push( "-p" );
			args.push( ''+port );
			if ( !norewrite ) args.push( "-rewrite" );

			Sys.command("nekotools", args);
			
			setCwd(originalCwd);
			exit(0);
		}
		else {
			println('Failed to change into directory $dir');
			exit(1);
		}
	}
}

/**
	-------------------------------------------------------------------
	Ufront Tool:
	  ufront task
	
	Run a task.  This is a shortcut for `cd out; neko tasks.n`
	-------------------------------------------------------------------

	Usage:
**/
class TaskCommand extends UfrontCommand
{
	/** 
		The directory to launch the server in.  "Out" by default.
	**/
	public var dir:String = "out";
	
	/** 
		Name of the task file to run
	**/
	public var file:String = "tasks.n";

	public function runDefault( d:Dispatch )
	{
		var args = d.args.copy();
		args.reverse();
		if ( sys.FileSystem.exists(dir) ) {
			var originalCwd = getCwd();
			setCwd( dir );

			var nekoArgs = [file];
			for ( arg in args ) nekoArgs.push( arg );
			var exitCode = Sys.command( "neko", nekoArgs );
			
			setCwd( originalCwd );
			exit( exitCode );
		}
		else {
			println('Failed to change into directory $dir');
			exit(1);
		}
	}
}

/**
	-------------------------------------------------------------------
	Ufront Tool:
	  ufront unittest
	
	Run the unit tests for this project, using the `munit` test library.

	This is a shortcut for `haxelib run munit t`
	-------------------------------------------------------------------

	Usage:
**/
class UnitTestCommand extends UfrontCommand
{
	public function runDefault()
	{
		if ( sys.FileSystem.exists(".munit") ) {
			var args = "run munit t".split(" ");
			var exitCode = Sys.command( "haxelib", args );
			exit( exitCode );
		}
		else {
			println('No `.munit` file found.  Please run `haxelib run munit config` to set up test suite.');
			exit(1);
		}
	}
}

/**
	-------------------------------------------------------------------
	Ufront Tool:
	  ufront deploy
	
	TODO: document what this is and how it works, probably with a link

	Currently this is only tested on:

	- Ubuntu servers
	- A ubuntu development machine

	-------------------------------------------------------------------

	Usage:
**/
class DeployCommand extends UfrontCommand
{
	var projectDir:String;
	var currentStep:String;

	public function new( projectDir:String ) {
		super();
		this.projectDir = projectDir.removeTrailingSlashes();
	}

	function step( s:String ) {
		println( '$s:' );
		currentStep = s;
	}

	public function runDefault( ?target:String )
	{
		setCwd( projectDir );
		var deployConfig:DeployConfig = Json.parse( File.getContent('deploy.json') );
		var deployTargets:Array<DeployTarget> = deployConfig.targets;

		
		for ( target in deployTargets ) {
			println( 'Deploying ${target.name}' );
			try {
				step( "Check if deployment directory already exists" );
				var parentDir = '$projectDir/deploy';
				var deployDir = '$parentDir/${target.name}';
				if ( !FileSystem.exists(deployDir) ) {
					step( "Clone deploy directory from git repo" );
					SysUtil.mkdir( parentDir );
					setCwd( parentDir );
					var exitCode = Sys.command( 'git', ['clone',target.gitRepo,target.name] );
					if ( exitCode!=0 ) 
						throw 'Failed to clone repo ${target.gitRepo}.';
					setCwd( projectDir );
				}

				// Build
				runCommands( deployConfig.hooks.beforeBuild, "beforeBuild" );
				for ( hxml in target.hxmls ) {
					step( 'Build $hxml' );
					var buildCmd = new BuildCommand();
					buildCmd.define = target.defines.join(",");
					buildCmd.debug = target.debug;
					buildCmd.doBuild( hxml );
				}
				runCommands( deployConfig.hooks.afterBuild, "afterBuild" );
				
				// Copy
				runCommands( deployConfig.hooks.beforeCopy, "beforeCopy" );
				step( 'Copy files to deployment directory' );
				for ( targetDir in Reflect.fields(deployConfig.files) ) {
					var filesToCopy:Array<String> = Reflect.field( deployConfig.files, targetDir );

					if (targetDir.startsWith("/")==false) targetDir = '/$targetDir';
					var deployTarget = targetDir.startsWith("/") ? deployDir+targetDir : deployDir+"/"+targetDir;
					deployTarget.addTrailingSlash();

					for ( file in filesToCopy ) {
						if ( file.startsWith("/") ) file.substr(1);

						if ( FileSystem.isDirectory(file) ) {
							// If it ends with a slash, copy the files inside to the target directory
							SysUtil.recursiveCopy( file, deployTarget );
						}
						else {
							// If it is a file, copy this to the target directory
							var filename = file.withoutDirectory();
							SysUtil.recursiveCopy( file, deployTarget+filename );
						}
					}
				}
				runCommands( deployConfig.hooks.afterCopy, "afterCopy" );

				// Push
				runCommands( deployConfig.hooks.beforePush, "beforePush" );
				step( 'Push to deployment repository' );
				var args = ["log",'--pretty=format:%h %ad | %s%d [%an]',"--graph","--date=short","-1"];
				var currentcommit = SysUtil.getCommandOutput( 'git', args );
				setCwd( deployDir );
				SysUtil.getCommandOutput( 'git', ["add","."] );
				SysUtil.getCommandOutput( 'git', ["commit","-am",'Deploy for ${target.name} from commit ${currentcommit}'] );
				SysUtil.getCommandOutput( 'git', ["push","origin","master"] );
				setCwd( projectDir );
				runCommands( deployConfig.hooks.afterPush, "afterPush" );

				try {
					// Check server dir exists, and is a git repo
					var step = 'Check if deployment directory exists on server';
					runRemoteCommands( target.servers, ['ls .git'], step, true );
				}
				catch ( e:Dynamic ) {
					// The repo does not exist, create the parent directory, and clone into it.
					step( 'Create directory on deployment server' );
					for ( server in target.servers ) {
						var remoteDir = server.remoteDir.removeTrailingSlashes();
						var parentDir = server.remoteDir.directory();
						var repoFolderName = server.remoteDir.withoutDirectory();
						runRemoteCommand( server, 'mkdir -p $parentDir', false );
						runRemoteCommand( server, 'cd $parentDir && git clone ${target.gitRepo} $repoFolderName', false );
					}
				}
				
				// Pull
				runRemoteCommands( target.servers, deployConfig.hooks.beforePull, "beforePull", true );
				var step = "Update deployment servers from repo";
				runRemoteCommands( target.servers, ["git pull"], step, true );
				runRemoteCommands( target.servers, deployConfig.hooks.afterPull, "afterPull", true );

				// Complete
				runCommands( deployConfig.hooks.afterComplete, "afterComplete" );
			}
			catch ( e:Dynamic ) {
				println( 'Deploy failed on target ${target.name}, during step "$currentStep":' );
				println( '$e' );
				exit( 1 );
			}
		}
	}

	function runCommands( commands:Array<String>, title:String ) {
		if ( commands!=null && commands.length>0 ) {
			step( 'Running $title hooks' );
			for ( cmdString in commands ) {
				setCwd( projectDir );
				println( 'Run: $cmdString' );
				var args = cmdString.split(" ");
				var cmd = args.shift();
				var result = Sys.command( cmd, args );
				if ( result!=0 )
					throw 'Command `$cmdString` during $title failed';
			}
		}
	}

	function runRemoteCommands( servers:Array<DeployServer>, commands:Array<String>, title:String, cdFirst:Bool ) {
		if ( servers!=null ) for ( server in servers ) {
			step( 'Running $title hooks for remote server ${server.name}' );
			if ( commands!=null && commands.length>0 ) {
				for ( cmd in commands ) {
					runRemoteCommand( server, cmd, cdFirst );
				}
			}
		}
	}

	function runRemoteCommand( server:DeployServer, cmd:String, cdFirst:Bool ) {
		println( 'Run on ${server.host}: $cmd' );
		var executable = "ssh";
		var args = [];

		if ( server.user!=null )
			args.push( '${server.user}@${server.host}' );
		else
			args.push( '${server.host}' );

		if ( server.port!=null ) {
			args.push( '-p' );
			args.push( '${server.port}' );
		}

		if ( cdFirst )
			args.push( 'cd ${server.remoteDir} && $cmd' );
		else
			args.push( cmd );

		return SysUtil.getCommandOutput( executable, args );
	}
}

typedef DeployConfig = {
	/** Files to include in the deployment **/
	files: Dynamic<Array<String>>,

	/** Build targets and  **/
	targets:Array<DeployTarget>,

	hooks: {
		/** Commands to run before building **/
		?beforeBuild:Array<String>,

		/** Commands to run after building **/
		?afterBuild:Array<String>,

		/** Commands to run before copying files **/
		?beforeCopy:Array<String>,
		
		/** Commands to run after copying files **/
		?afterCopy:Array<String>,
		
		/** Commands to run before committing and pushing the repo to our git server **/
		?beforePush:Array<String>,

		/** Commands to run after committing and pushing the repo to our git server **/
		?afterPush:Array<String>,
		
		/** Commands to run ON THE REMOTE SERVER before pulling the new repo **/
		?beforePull:Array<String>,
		
		/** Commands to run ON THE REMOTE SERVER after pulling the new repo **/
		?afterPull:Array<String>,
		
		/** Commands to run after the deployment for this target has completed **/
		?afterComplete:Array<String>,
	},
}

typedef DeployTarget = {
	/** The name of the deploy target **/
	name:String,

	/** The remote git repo to store this deployment option **/
	gitRepo:String,

	/** The defines to add to this build **/
	defines:Array<String>,

	/** The defines to add to this build **/
	?hxmls:Array<String>,

	/** Whether or not to use debug for this build **/
	debug:Bool,

	/** The servers to deploy this build to **/
	servers:Array<DeployServer>
}

typedef DeployServer = {

	/** A name for this server (in case you want to deploy only to this server) **/
	name:String,

	/** The SSH username to connect with.  Please note you cannot specify a password - please use SSH certificates. **/
	?user:String,

	/** The hostname of the target server **/
	host:String,

	/** The SSH port on the target server **/
	?port:Int,

	/** The folder on the remote server where the app will be served from **/
	remoteDir:String,
}

class SysUtil {
	/**
		Create a directory if it doesn't exist.

		This also creates any parent directories that are required, similar to the `mkdir -p` command.
	**/
	public static function mkdir( dir:String ) {
		dir = dir.removeTrailingSlashes();
		if ( !FileSystem.exists(dir) ) {
			var parentDir = dir.directory();
			mkdir( parentDir );
			FileSystem.createDirectory( dir );
		}
	}

	/**
		Recursively copy a file or directory from one location to another.

		If `inFile` does not exist, it will throw an error.
		If the parent directory of `outFile` does not exist, it will create it.
		If `inFile` is a file, the contents will be copied to `outFile`.
		If `inFile` is a directory, a directory with the same name will be created at `outFile`, and all child files copied from the `inFile` to `outFile` recursively.
	**/
	public static function recursiveCopy( inFile:String, outFile:String ) {
		inFile = inFile.removeTrailingSlashes();
		outFile = outFile.removeTrailingSlashes();
		if ( !FileSystem.exists(inFile) ) {
			throw 'File $inFile is part of your deploy script, but does not exist';
		}
		var outDir = outFile.directory();
		if ( !FileSystem.exists(outDir) ) {
			mkdir( outDir );
		}
		if ( FileSystem.isDirectory(inFile) ) {
			mkdir( outFile );
			for ( child in FileSystem.readDirectory(inFile) ) {
				recursiveCopy( '$inFile/$child', '$outFile/$child' );
			}
		}
		else {
			File.saveBytes( outFile, File.getBytes(inFile) );
		}
	}

	/**
		Run a command and get the command output.

		If the command returns an exit code other than 0, it will throw the console output.
	**/
	public static function getCommandOutput( cmd:String, args:Array<String> ):String {
		var p = new Process( cmd, args );
		var code = p.exitCode();
		var stdout = p.stdout.readAll().toString();
		var stderr = p.stderr.readAll().toString();
		return switch code {
			case 0: 
				return stdout;
			default: 
				return throw 'Command `$cmd ${args.join(" ")}` failed. \nExit code: $code\nStdout: $stdout\nStderr: $stderr';
		}
	}
}
				