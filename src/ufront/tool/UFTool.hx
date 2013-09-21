package ufront.tool;

import haxe.ds.StringMap;
import haxe.io.Path;
import mcli.CommandLine;
import mcli.Dispatch;
import sys.FileSystem;
import sys.io.File;
import sys.io.Process;
import sys.net.Host;
import Sys.*;
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
	//	exit(0);
	//}

	///**
	//	Configure the current project's settings
	//	@alias c
	//**/
	//public function configure() {
	//	println("configure settings");
	//	exit(0);
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
	}

	/**
		Show the help message.
	**/
	public function help() {
		println(this.showUsage());
		exit(0);
	}

	/**
		Setup shortcuts so you can type `ufront` instead of `haxelib run ufront`.  May need to run with "sudo"
	**/
	public function setup() {
		switch Sys.systemName() {
			case "Windows":
				println( "Sadly we haven't implemented this for windows yet.  If you would like to help please get in contact on Github" );
				exit(1);
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
		exit(0);
	}

	public static function main() {
		var args = args();
		var calledFrom = new Path( executablePath() );
		var ufrontDir = getCwd();
		if ( calledFrom.file=="haxelib" || calledFrom.file=="ufront" ) {
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
		exit(0);
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
		if ( target!=null && target.endsWith(".hxml") ) target = target.substr(0,-5);
		var buildFiles = [ for ( f in FileSystem.readDirectory(getCwd()) ) if (f.endsWith(".hxml")) f ];

		var exitCode = 0;
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

		for ( hxml in buildFiles ) {
			if ( target!=null && hxml!='$target.hxml' ) continue;

			foundBuilds++;
			println ('Build $hxml');
			
			args.push( hxml );
			if ( Sys.command("haxe", args) != 0 ) {
				println ('Build failed\n');
				exitCode = 1;
			}
			args.pop();
		}

		if ( target!=null && foundBuilds==0 ) { 
			println('Build $target.hxml not found');
			exitCode = 1;
		}
		exit(exitCode);
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
			println("    haxelib git ihx https://github.com/jasononeil/ihx.git");
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