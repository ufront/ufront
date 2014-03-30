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
				