ufront
======

[![Build Status](https://travis-ci.org/ufront/ufront.svg?branch=master)](https://travis-ci.org/ufront/ufront) [![Join the chat at https://gitter.im/ufront/ufront](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/ufront/ufront?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

Ufront is a client/server MVC web framework for Haxe.
It allows you to share models, views and controllers between both server-side and client-side code.
Client side, your app will run as a fast single-page-app.
But everything can still work server-side - which makes for fast first page loads, great SEO, and a good fallback for old browsers.

Platform Support
----------------

* __Neko__ (Server side)
* __PHP__ (Server side)
* __NodeJS__ (Server side, experimental)
* __JS__ (Client side)

It would be possible to also support Python, Java, C# and C++ with a little work.

Installing
----------

Installing from haxelib (please note, the versions on haxelib are not up-to-date currently):

    haxelib install ufront
    sudo haxelib run ufront --setup

Using the latest git version:

    git clone --recursive https://github.com/ufront/ufront.git
    cd ufront
    ./setupDev
    sudo haxelib run ufront --setup

A "hello world" example is included in `submodules/hello/` to give you an example of how to get started.
This example includes builds for Neko, PHP and NodeJS in `server.hxml`, and for Client JS in `client.hxml`.

Repos
-----

The `ufront` and `ufront-client` libraries are the "motherships" that hold together each of the ufront modules:

 - [ufront](https://github.com/ufront/ufront) - All the ufront modules required on the server-side.
 - [ufront-client](https://github.com/ufront/ufront-client) - All the ufront modules required on teh client-side.

These ufront libs are part of the core, used in both `ufront` and `ufront-client`:

 - [ufront-mvc](https://github.com/ufront/ufront-mvc) - The MVC framework. Provides routing, controllers, views, APIs, remoting, dependency injection and more.
 - [ufront-orm](https://github.com/ufront/ufront-orm) - An ORM that makes it easy to have models with validation, serialization, automatic relationships and more.
 - [ufront-easyauth](https://github.com/ufront/ufront-easyauth) - An auth system that gives you users, groups and permissions. Fairly simplistic but flexible. Easy to replace if you have different needs.

Then there are other libs, which you can install and use, but are not included by default:

 - [ufront-ufadmin](https://github.com/ufront/ufront-ufadmin) - An admin area for your web-app.
 - [ufront-uftasks](https://github.com/ufront/ufront-uftasks) - Easy command line tasks that integrate with your models and APIs.
 - [ufront-mail](https://github.com/ufront/ufront-mail) - Easily send emails with Ufront.

Using the ufront tool
---------------------

Ufront comes with a helper tool in haxelib. To run it:

    haxelib run ufront

Or, if you ran the `haxelib run ufront --setup` command:

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
