ufront
======

Ufront is a powerful MVC web framework for Haxe. It gives you quick development, shared code on the client and server, powerful extensibility, easy testing, and targets PHP or Neko on the server, and mostly JS (though anything is possible) on the client.  A NodeJS target would be very feasible, and may be included in the future.

This is the mothership repo - most of the actual code is contained in the other ufront repos, such as ufront-mvc.

Installing
----------

Installing from haxelib:

    haxelib install ufront

Using the latest git version:

    haxelib git ufront git@github.com:ufront/ufront.git <specific branch or tag, if not master>

Using the ufront tool
---------------------

    haxelib run ufront

On Mac/Linux, you can make life easier by aliasing "haxelib run ufront" to simple "ufront", by create a shell script like this, and saving it to `/usr/bin/ufront/`:

	#!/bin/sh
	haxelib run ufront $@

You then have this usage:

	b, build               Build the current project 
	s, server              Run a development server using "nekotools server" on 
	                       localhost:2987  
	i, shell               Run an interactive shell (ihx) and import your key 
	                       project libraries and files  
	-h, --help             Show help message

In future, I would like to add:

	n, create              Create a new ufront project, controller, model, API 
	                       or view based on simple templates
	c, configure           Configure the current project's settings 
	t, runtask             Run one of the tasks defined in your project
	d, documentation       Regenerate the documentation for your project
	u, rununittests        Run the unit tests for your app
	w, watch               Watch your project using `livehaxe` and compile when 
	                       changes are found

Feel free to contribute!