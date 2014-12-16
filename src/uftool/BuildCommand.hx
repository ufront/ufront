package uftool;

import sys.FileSystem;
import Sys.*;
using haxe.io.Path;
using StringTools;

/**
	-------------------------------------------------------------------
	Ufront Tool:
	- ufront build
	- ufront build {target hxml}
	
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