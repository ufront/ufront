package uftool;

import haxe.io.Bytes;
#if sys
	import sys.FileSystem;
	import sys.io.Process;
	import Sys.*;
	import sys.io.File;
#end
using haxe.io.Path;

class SysUtil {
	#if sys
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
				var copy = true;
				if ( FileSystem.exists(outFile) ) {

					if ( areFilesDifferent(inFile, outFile)==false ) {
						copy = false;
					}
				}
				if (copy) {
					println( 'Copying asset $inFile' );
					File.saveBytes( outFile, File.getBytes(inFile) );
				}
			}
		}

		/**
			Delete a directory and all of it's contents.
		**/
		public static function recursiveDelete( dir:String ):Void {
			if ( FileSystem.exists(dir) ) {
				for ( file in FileSystem.readDirectory(dir) ) {
					var filePath = dir.addTrailingSlash()+file;
					if ( FileSystem.isDirectory( filePath ) ) {
						recursiveDelete( filePath );
					}
					else {
						FileSystem.deleteFile( filePath );
					}
				}
				FileSystem.deleteDirectory( dir );
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

		/**
			Check if 2 files are different.

			Assumes both files exist.

			Will compare file sizes, and if they are identical, will compare the bytes of the files to see if they are different.
		**/
		public static function areFilesDifferent( file1:String, file2:String ):Bool {

			var file1Stat = FileSystem.stat( file1 );
			var file2Stat = FileSystem.stat( file2 );

			if ( file1Stat.size!=file2Stat.size ) {
				return true;
			}
			else {
				// Copy only if the file is different.  We'll use Adler32 to compare them.
				var input1 = File.read(file1);
				var input2 = File.read(file2);

				var fileSize = file1Stat.size; // Same for both files.
				var chunkSize = 1024;
				var amountRead = 0;
				var differenceFound = false;

				while ( amountRead < file1Stat.size ) {
					var amount = file1Stat.size - amountRead;
					if ( amount>chunkSize ) amount = chunkSize;

					amountRead += amount;
					var bytes1 = input1.read( amount );
					var bytes2 = input2.read( amount );

					if ( bytes1.compare(bytes2)!=0 ) {
						differenceFound = true;
					}
				}

				input1.close();
				input2.close();
				return differenceFound;
			}

		}
	#end
}
