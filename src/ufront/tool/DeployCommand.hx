package ufront.tool;

import sys.FileSystem;
import sys.io.File;
import sys.io.Process;
import Sys.*;
import haxe.Json;
using haxe.io.Path;
using StringTools;

/**
	-------------------------------------------------------------------
	Ufront Tool:
	- ufront deploy
	- ufront {target}
	- ufront {target} {server}
	
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