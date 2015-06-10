#!/bin/sh

libname='ufront'
rm -f "${libname}.zip"
zip -r "${libname}.zip" haxelib.json src uftool run.n LICENSE.txt README.md
echo "Saved as ${libname}.zip"
