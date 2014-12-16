package uftool;

import mcli.CommandLine;

/**
	Base class for other ufront tool commands.
**/
class UfrontCommand extends CommandLine
{
	/**
		print this message
		@command
		@alias h
	**/
	public function help()
	{
		Sys.println(this.toString());
		Sys.exit( 0 );
	}
}