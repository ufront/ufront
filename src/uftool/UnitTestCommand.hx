package uftool;

import sys.FileSystem;
import Sys.*;

/**
	-------------------------------------------------------------------
	Ufront Tool:
	- ufront unittest
	
	Run the unit tests for this project, using the `munit` test library.

	This is a shortcut for `haxelib run munit t`
	-------------------------------------------------------------------

	Usage:
**/
class UnitTestCommand extends UfrontCommand
{
	public function runDefault()
	{
		if ( FileSystem.exists(".munit") ) {
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