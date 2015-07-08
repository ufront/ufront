ufront
======

[![Join the chat at https://gitter.im/ufront/ufront](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/ufront/ufront?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

Ufront is a powerful MVC web framework for Haxe. It gives you quick development, shared code on the client and server, powerful extensibility, easy testing, and targets PHP or Neko on the server, and mostly JS (though anything is possible) on the client.  A NodeJS target would be very feasible, and may be included in the future.

This is the mothership repo - most of the actual code is contained in the other ufront repos, such as ufront-mvc.

Installing
----------

Installing from haxelib:

    haxelib install ufront
    sudo haxelib run ufront --setup

Using the latest git version:

    haxelib git ufront git@github.com:ufront/ufront.git <specific branch or tag, if not master>
    cd <haxelib path>ufront/git
    ./setupDev.sh
    sudo haxelib run ufront --setup

Dependencies
------------

The `ufront` haxelib includes dependencies to:

 - [ufront-mvc](https://github.com/ufront/ufront-mvc)
 - [ufront-orm](https://github.com/ufront/ufront-orm)
 - [ufront-easyauth](https://github.com/ufront/ufront-easyauth)
 - [ufront-clientds](https://github.com/ufront/ufront-clientds)
 - [ufront-ufadmin](https://github.com/ufront/ufront-ufadmin)
 - [ufront-uftasks](https://github.com/ufront/ufront-uftasks)
 - [mcli](https://github.com/waneck/mcli)
 - [compiletime](https://github.com/jasononeil/compiletime)

as well as other libraries which these are dependent on, such as [thx](https://github.com/fponticelli/thx) and [hxevents](https://github.com/ufront/hxevents).

Using the ufront tool
---------------------

    haxelib run ufront

Or, if you ran the `--setup` command:

    ufront

You then have this usage:

	b, build               Build the current project 
	s, server              Run a development server using "nekotools server" on 
	                       localhost:2987  
	i, shell               Run an interactive shell (ihx) and import your key 
	                       project libraries and files  
	t, task                Run one of the tasks defined in your project
	u, unittests           Run the unit tests for your app
	-h, --help             Show help message

In future, I would like to add:

	n, create              Create a new ufront project, controller, model, API 
	                       or view based on simple templates
	c, configure           Configure the current project's settings 
	d, documentation       Regenerate the documentation for your project
	w, watch               Watch your project using `livehaxe` and compile when 
	                       changes are found

Feel free to contribute!
