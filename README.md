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

Installing from haxelib:

```bash
haxelib install ufront-mvc
haxelib install ufront-tool
sudo haxelib run ufront-tool --setup
```

Using the latest git version:

```bash
haxelib git ufront-mvc https://github.com/ufront/ufront-mvc
# Similar for other libs
```

To update that git repository to a newer version:

```bash
haxelib update ufront-mvc
```

Getting started
---------------

A "hello world" can be found in the [ufront/hello](https://github.com/ufront/ufront) repo to give you an example of how to get started.
This example includes builds for Neko, PHP and NodeJS in `server.hxml`, and for Client JS in `client.hxml`.

You can also visit the [ufront-nodejs-guide](https://github.com/kevinresol/ufront-nodejs-guide) for a more comprensive guide.

Repos
-----

Core:

 - [ufront](https://github.com/ufront/ufront) - This is not a library itself but just to hold some codes for generating the documentations
 - [ufront-mvc](https://github.com/ufront/ufront-mvc) - The MVC framework. Provides routing, controllers, views, APIs, remoting, dependency injection and more.
 
Plugins and other optional libraries:

 - [ufront-tool](https://github.com/ufront/ufront-tool) - The helper tool for ufront.
 - [ufront-orm](https://github.com/ufront/ufront-orm) - An ORM that makes it easy to have models with validation, serialization, automatic relationships and more.
 - [ufront-easyauth](https://github.com/ufront/ufront-easyauth) - An auth system that gives you users, groups and permissions. Fairly simplistic but flexible. Easy to replace if you have different needs.
 - [ufront-ufadmin](https://github.com/ufront/ufront-ufadmin) - An admin area for your web-app.
 - [ufront-uftasks](https://github.com/ufront/ufront-uftasks) - Easy command line tasks that integrate with your models and APIs.
 - [ufront-mail](https://github.com/ufront/ufront-mail) - Easily send emails with Ufront.

Feel free to contribute!
