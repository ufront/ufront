#!/bin/sh

# Use this script to git clone all ufront lib from github
# Useful for ufront maintainers

# Usage:
# `./clone.sh` just clone the repos
# `./clone.sh --setup-dev` set haxelib dev path to the newly cloned repos

rm -Rf lib
mkdir -p lib
cd lib

git clone https://github.com/ufront/ufront-easyauth
git clone https://github.com/ufront/ufront-mail
git clone https://github.com/ufront/ufront-mvc
git clone https://github.com/ufront/ufront-orm
git clone https://github.com/ufront/ufront-tool
git clone https://github.com/ufront/ufront-ufadmin
git clone https://github.com/ufront/ufront-uftasks

if [ $1 == "--setup-dev" ]; then

	haxelib dev ufront-easyauth ./ufront-easyauth
	haxelib dev ufront-mail ./ufront-mail
	haxelib dev ufront-mvc ./ufront-mvc
	haxelib dev ufront-orm ./ufront-orm
	# haxelib dev ufront-tool ./ufront-tool
	haxelib dev ufront-ufadmin ./ufront-ufadmin
	haxelib dev ufront-uftasks ./ufront-uftasks

fi