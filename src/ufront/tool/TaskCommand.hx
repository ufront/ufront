package ufront.tool;

import mcli.Dispatch;
import sys.FileSystem;
import Sys.*;

/**
	-------------------------------------------------------------------
	Ufront Tool:
	- ufront task
	
	Run a task.  This is a shortcut for `cd www; neko tasks.n`
	-------------------------------------------------------------------

	Usage:
**/
class TaskCommand extends UfrontCommand
{
	/**
		Leftover args to be parsed in here...
	**/
	var args:Array<String>;

	/** 
		The directory to launch the server in.  "www" by default.
	**/
	var dir:String = "www";
	
	/** 
		Name of the task file to run
	**/
	var file:String = "tasks.n";

	public function new( args:Array<String> ) {
		super();
		this.args = args;
	}

	public function runDefault( d:Dispatch ) {
		var args = d.args.copy();
		args.reverse();

		if ( FileSystem.exists(dir) ) {
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