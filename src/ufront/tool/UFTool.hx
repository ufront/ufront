package ufront.tool;

import haxe.io.Path;
import sys.FileSystem;
import sys.net.Host;
import Sys.*;
using StringTools;

/**
    -------
    UFTool:
    A command line tool to help you manage your ufront project.  Usage:
    -------
**/
class UFTool extends mcli.CommandLine {

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
    public function build(?target:String) {
        if ( target!=null && target.endsWith(".hxml") ) target = target.substr(0,-5);
        var buildFiles = [ for ( f in FileSystem.readDirectory(getCwd()) ) if (f.endsWith(".hxml")) f ];

        var exitCode = 0;
        var numBuilds = 0;
        for ( hxml in buildFiles ) {
            if ( target!=null && hxml!='$target.hxml' ) continue;

            println ('Build $hxml');
            
            if ( Sys.command("haxe", [hxml]) == 0 ) 
                numBuilds++;
            else {
                println ('Build failed\n');
                exitCode = 1;
            }
        }

        if ( target!=null && numBuilds==0 ) { 
            println('Build $target.hxml not found');
            exitCode = 1;
        }
        exit(exitCode);
    }
    
    /**
        Run a development server using "nekotools server" on localhost:2987
        @alias s
    **/
    public function server() {
        var serverName = Host.localhost().toString();
        var port = 2987;
        var webDir = "out";

        if ( sys.FileSystem.exists(webDir) ) {
            println('Switching directory to `$webDir`');
            var originalCwd = getCwd();
            setCwd(webDir);
            
            Sys.command("nekotools", ["server", "-rewrite", "-h", serverName, "-p", ""+port]);
            
            setCwd(originalCwd);
            exit(0);
        }
        else {
            println('Failed to change into directory $webDir');
            exit(1);
        }
    }
    
    /**
        Run an interactive shell (ihx) and import your key project files
        @alias i
    **/
    public function shell() {
        Sys.command("haxelib", ["run", "ihx"]);
        println("Run an interactive shell");
        exit(0);
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
        if ( calledFrom.file=="haxelib" ) {
            setCwd( args.pop() );
        } else {
            println("We are making the assumption that you are running `neko run.n` from the ufront haxelib folder. Use `haxelib run ufront` to be sure.");
        }
        new mcli.Dispatch( args ).dispatch( new UFTool(ufrontDir) );
    }
}