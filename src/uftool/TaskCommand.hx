package uftool;

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
class TaskCommand
{
	public static function run( args:Array<String> ) {
		if ( FileSystem.exists("www") ) {
			var originalCwd = getCwd();
			setCwd( "www" );

			var nekoArgs = ["tasks.n"];
			for ( arg in args ) nekoArgs.push( arg );
			var exitCode = Sys.command( "neko", nekoArgs );
			
			setCwd( originalCwd );
			exit( exitCode );
		}
		else {
			println('Failed to change into directory "www"');
			exit(1);
		}
	}
}