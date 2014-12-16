package uftool;

import haxe.Json;
import sys.FileSystem;
import sys.io.File;
import sys.io.Process;
import Sys.*;
using StringTools;

/**
	-------------------------------------------------------------------
	Ufront Tool:
	- ufront interactive
	
	Run an interactive shell (ihx), loading in all our source files and
	required libraries.
	-------------------------------------------------------------------

	Usage:
**/
class InteractiveCommand extends UfrontCommand
{
	public function runDefault()
	{
		if ( 0 != new Process("haxelib", ["path", "ihx"]).exitCode() ) {
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

		for ( c in classPaths ) { args.push( '-cp' ); args.push( c ); }
		for ( l in libs ) { args.push( '-lib' ); args.push( l ); }
		for ( d in defines ) { args.push( '-D' ); args.push( d ); }
		if ( debug ) args.push("-debug");
		
		Sys.command("haxelib", args);
		exit(0);
	}
}