package ufront.tool;

import sys.FileSystem;
import sys.io.Process;
import Sys.*;
import sys.io.File;
using haxe.io.Path;

class SysUtil {
	/**
		Create a directory if it doesn't exist.

		This also creates any parent directories that are required, similar to the `mkdir -p` command.
	**/
	public static function mkdir( dir:String ) {
		dir = dir.removeTrailingSlashes();
		if ( !FileSystem.exists(dir) ) {
			var parentDir = dir.directory();
			mkdir( parentDir );
			FileSystem.createDirectory( dir );
		}
	}

	/**
		Recursively copy a file or directory from one location to another.

		If `inFile` does not exist, it will throw an error.
		If the parent directory of `outFile` does not exist, it will create it.
		If `inFile` is a file, the contents will be copied to `outFile`.
		If `inFile` is a directory, a directory with the same name will be created at `outFile`, and all child files copied from the `inFile` to `outFile` recursively.
	**/
	public static function recursiveCopy( inFile:String, outFile:String ) {
		inFile = inFile.removeTrailingSlashes();
		outFile = outFile.removeTrailingSlashes();
		if ( !FileSystem.exists(inFile) ) {
			throw 'File $inFile is part of your deploy script, but does not exist';
		}
		var outDir = outFile.directory();
		if ( !FileSystem.exists(outDir) ) {
			mkdir( outDir );
		}
		if ( FileSystem.isDirectory(inFile) ) {
			mkdir( outFile );
			for ( child in FileSystem.readDirectory(inFile) ) {
				recursiveCopy( '$inFile/$child', '$outFile/$child' );
			}
		}
		else {
			File.saveBytes( outFile, File.getBytes(inFile) );
		}
	}

	/**
		Run a command and get the command output.

		If the command returns an exit code other than 0, it will throw the console output.
	**/
	public static function getCommandOutput( cmd:String, args:Array<String> ):String {
		var p = new Process( cmd, args );
		var code = p.exitCode();
		var stdout = p.stdout.readAll().toString();
		var stderr = p.stderr.readAll().toString();
		return switch code {
			case 0: 
				return stdout;
			default: 
				return throw 'Command `$cmd ${args.join(" ")}` failed. \nExit code: $code\nStdout: $stdout\nStderr: $stderr';
		}
	}
}