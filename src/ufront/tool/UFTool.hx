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
	//public function create() {
	//	println("setup a new project");
	//	configure();
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
		var args = Sys.args();

		var firstArg = args.pop();
		var ufrontDir:String;
		if ( firstArg!=null && FileSystem.exists(firstArg.addTrailingSlash()+"run.n") ) {
			// Haxelib is weird.  
			// If this is called via "haxelib run ufront" (or "ufront" which as an alias for "haxelib run ufront"), then Haxe will:
			//  - Change the cwd to the ufront haxelib folder
			//  - Pass the users working directory as the first argument.
			// So if the '${args[0]}/run.n' exists, we assume haxelib is in this weird state, and undo it's behaviour.
			// We change the cwd back to the user's original directory, and take it out of the args.
			// We hold on to the ufrontDir just in case.
			ufrontDir = getCwd();
			setCwd( firstArg );
		}
		else {
			// Probably not weird haxelib behaviour.  Get ufrontDir by using 'haxelib path', reading the first line, and trimming the '/src/' from the end.
			if ( firstArg!=null ) args.unshift( firstArg );

			var pathInfo = SysUtil.getCommandOutput( "haxelib", ["path","ufront"] );
			ufrontDir = pathInfo.split("\n")[0];

			if ( ufrontDir.endsWith("/src/") ) {
				ufrontDir = ufrontDir.substr( 0, ufrontDir.length-4 );
			}
		}
		trace( 'Ufrontdir: $ufrontDir' );
		new mcli.Dispatch( args ).dispatch( new UFTool(ufrontDir) );
	}
}
				