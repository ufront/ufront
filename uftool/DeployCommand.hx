package uftool;

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
	var deployConfig:DeployConfig;
	var deployTargets:Array<DeployTarget>;

	public function new( projectDir:String ) {
		super();
		this.projectDir = projectDir.removeTrailingSlashes();
	}

	public function runDefault( ?targetName:String, ?serverName:String )
	{
		setCwd( projectDir );
		deployConfig = Json.parse( File.getContent('deploy.json') );
		deployTargets = deployConfig.targets;

		var foundTarget = false;
		for ( target in deployTargets ) {
			if ( targetName==null || target.name==targetName ) {
				foundTarget = true;
				prepareTarget( target );

				var foundServer = false;
				for ( server in target.servers ) {
					if ( serverName==null || server.name==serverName ) {
						foundServer = true;
						deployToServer( target, server );
					}
				}

				if ( serverName!=null && foundServer==false ) {
					println( 'Failed to find server $serverName in deploy.json' );
					exit( 1 );
				}

				// Complete
				runCommands( deployConfig.hooks.afterComplete, "afterComplete" );
			}
		}

		if ( targetName!=null && foundTarget==false ) {
			println( 'Failed to find target $targetName in deploy.json' );
			exit( 1 );
		}

		exit( 0 );
	}

	function step( s:String ) {
		println( '$s:' );
		currentStep = s;
	}

	function prepareTarget( target:DeployTarget ) {
		println( '' );
		println( 'Deploying ${target.name}' );
		println( '' );
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
			else {
				step( "Pull latest git repo" );
				setCwd( '$deployDir/' );
				var exitCode = Sys.command( 'git', ['remote','set-url','origin',target.gitRepo] );
				if ( exitCode!=0 )
					throw 'Failed to set git remote "origin" to ${target.gitRepo}.';

				var exitCode = Sys.command( 'git', ['reset','--','hard'] );
				if ( exitCode!=0 )
					throw 'Failed to run `git reset --hard` before pulling the latest deployment repo.';

				var exitCode = Sys.command( 'git', ['pull'] );
				if ( exitCode!=0 )
					throw 'Failed to pull the latest deployment repo.';

				setCwd( projectDir );
			}

			// Build
			runCommands( deployConfig.hooks.beforeBuild, "beforeBuild" );
			for ( hxml in target.hxmls ) {
				step( 'Build $hxml' );
				var buildCmd = new BuildCommand();
				if ( target.defines!=null && target.defines.length>0 )
					buildCmd.define = target.defines.join(",");
				if ( target.debug!=null )
					buildCmd.debug = target.debug;
				buildCmd.doBuild( hxml );
			}
			runCommands( deployConfig.hooks.afterBuild, "afterBuild" );

			// Copy
			runCommands( deployConfig.hooks.beforeCopy, "beforeCopy" );
			step( 'Copy files to deployment directory' );
			for ( file in deployConfig.files ) {
				if ( file.startsWith("/") )
					file = file.substr(1);

				var filePath = '$projectDir/www/$file';
				var deployFilePath = '$deployDir/$file';

				SysUtil.recursiveCopy( filePath, deployFilePath );
			}
			runCommands( deployConfig.hooks.afterCopy, "afterCopy" );

			// Push
			runCommands( deployConfig.hooks.beforePush, "beforePush" );
			step( 'Push to deployment git repository' );
			var args = ["log",'--pretty=format:%h %ad | %s%d [%an]',"--graph","--date=short","-1"];
			var currentcommit = SysUtil.getCommandOutput( 'git', args );
			setCwd( deployDir );
			Sys.command( 'git', ["add","."] );
			Sys.command( 'git', ["commit","-am",'Deploy for ${target.name} from commit ${currentcommit}'] );
			if ( 0!=Sys.command('git', ["push","origin","master"]) )
				throw "Failed to push to remote git repo.";
			setCwd( projectDir );
			runCommands( deployConfig.hooks.afterPush, "afterPush" );
		}
		catch ( e:Dynamic ) {
			println( 'Deploy failed on target ${target.name}, during step "$currentStep":' );
			println( '$e' );
			exit( 1 );
		}
	}

	function deployToServer( target:DeployTarget, server:DeployServer ) {
		println( 'Pushing to server ${target.name} ${server.name}' );
		try {

			// Check server dir exists, and is a git repo
			try {
				step( 'Check if deployment directory exists on server' );
				runRemoteCommand( server, 'ls .git', true );
			}
			catch ( e:Dynamic ) {
				// The repo does not exist, create the parent directory, and clone into it.
				step( 'Create directory on deployment server' );
				var remoteDir = server.remoteDir.removeTrailingSlashes();
				var parentDir = remoteDir.directory();
				var repoFolderName = remoteDir.withoutDirectory();
				runRemoteCommand( server, 'mkdir -p $parentDir', false );
				runRemoteCommand( server, 'cd $parentDir && git clone ${target.gitRepo} $repoFolderName', false );
			}

			// Pull
			runRemoteCommands( server, deployConfig.hooks.beforePull, "beforePull", true );
			var step = "Update deployment servers from repo";
			runRemoteCommands( server, ["git pull"], step, true );
			runRemoteCommands( server, deployConfig.hooks.afterPull, "afterPull", true );

			// Complete
			runCommands( deployConfig.hooks.afterComplete, "afterComplete" );
		}
		catch ( e:Dynamic ) {
			println( 'Deploy failed on target ${target.name}, during step "$currentStep":' );
			println( '$e' );
			exit( 1 );
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

	function runRemoteCommands( server:DeployServer, commands:Array<String>, title:String, cdFirst:Bool ) {
		step( 'Running $title hooks for remote server ${server.name}' );
		if ( commands!=null && commands.length>0 ) {
			for ( cmd in commands ) {
				runRemoteCommand( server, cmd, cdFirst );
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
	/**
		Files to include in the deployment.

		They will be copied from `www/*` to the deployment directory.

		If one of the files is a directory, it will be copied recursively.

		If it is null or empty, the entire contents of "www" will be copied.
	**/
	files: Array<String>,

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
