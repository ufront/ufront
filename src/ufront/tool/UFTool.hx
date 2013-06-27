package ufront.tool;

import haxe.ds.StringMap;
import haxe.io.Path;
import mcli.CommandLine;
import mcli.Dispatch;
import sys.FileSystem;
import sys.io.File;
import sys.net.Host;
import Sys.*;
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

    /**
        Create a new ufront project, controller, model, API or view based on a simple template.
        @alias n
    **/
    public function create() {
        println("setup a new project");
        configure();
        exit(0);
    }

    /**
        Configure the current project's settings
        @alias c
    **/
    public function configure() {
        println("configure settings");
        exit(0);
    }

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
    public function runtask() {
        println("Run a task");
        exit(0);
    }
    
    /**
        Run the unit tests for your app.
        @alias u
    **/
    public function rununittests() {
        println("Run the unit tests for your app");
        exit(0);
    }
    
    /**
        Watch your project using `livehaxe` and compile when changes are found.
        @alias w
    **/
    public function watch() {
        println("Watch and compile");
        exit(0);
    }

    public function runDefault() {
        help();
    }

    /**
        Show this message.
        @alias h
    **/
    public function help() {
        println(this.showUsage());
        exit(0);
    }

    public static function main() {
        var args = args();
        var calledFrom = new Path( executablePath() );
        var ufrontDir = getCwd();
        if ( calledFrom.file=="haxelib" || calledFrom.file=="ufront" ) {
            setCwd( args.pop() );
        } else {
            println("We are making the assumption that you are running `neko run.n` from the ufront haxelib folder. Use `haxelib run ufront` to be sure.");
        }
        new mcli.Dispatch( args ).dispatch( new UFTool(ufrontDir) );
    }
}

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
        exit(0);
    }
}

/**
    -------------------------------------------------------------------
    Ufront Tool:
      ufront build
    
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
        if ( target!=null && target.endsWith(".hxml") ) target = target.substr(0,-5);
        var buildFiles = [ for ( f in FileSystem.readDirectory(getCwd()) ) if (f.endsWith(".hxml")) f ];

        var exitCode = 0;
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

        for ( hxml in buildFiles ) {
            if ( target!=null && hxml!='$target.hxml' ) continue;

            foundBuilds++;
            println ('Build $hxml');
            
            args.push( hxml );
            if ( Sys.command("haxe", args) != 0 ) {
                println ('Build failed\n');
                exitCode = 1;
            }
            args.pop();
        }

        if ( target!=null && foundBuilds==0 ) { 
            println('Build $target.hxml not found');
            exitCode = 1;
        }
        exit(exitCode);
    }
}

enum DCELevel {
    no;
    std;
    full;
}

/**
    -------------------------------------------------------------------
    Ufront Tool:
      ufront shell
    
    Run an interactive shell (ihx), loading in all our source files and
    required libraries.
    -------------------------------------------------------------------

    Usage:
**/
class ShellCommand extends UfrontCommand
{
    public function runDefault()
    {
        if ( 0 != new sys.io.Process("haxelib", ["path", "ihx"]).exitCode() ) {
            println("ihx not installed, you can install it with:");
            println("    haxelib git ihx https://github.com/jasononeil/ihx.git");
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

        for ( c in classPaths ) args.push('-cp $c'); 
        for ( l in libs ) args.push('-lib $l'); 
        for ( d in defines ) args.push('-D $d'); 
        if ( debug ) args.push("-debug");
        
        Sys.command("haxelib", args);
        exit(0);
    }
}


/**
    -------------------------------------------------------------------
    Ufront Tool:
      ufront server
    
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
        The directory to launch the server in.  "Out" by default.
    **/
    public var dir:String = "out";
    
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

        if ( sys.FileSystem.exists(dir) ) {
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