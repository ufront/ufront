package uftool;

import sys.FileSystem;
import sys.net.Host;
import Sys.*;
using haxe.io.Path;
using StringTools;

/**
	-------------------------------------------------------------------
	Ufront Tool:
	- ufront server
	
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
		The directory to launch the server in.  "www" by default.
	**/
	public var dir:String = "www";
	
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

		if ( FileSystem.exists(dir) ) {
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

