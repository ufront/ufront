package thx.sys.io;

#if haxe3
typedef FileInput = sys.io.FileInput;
#if neko
typedef FileInput = neko.io.FileInput;
#elseif php
typedef FileInput = php.io.FileInput;
#elseif cpp
typedef FileInput = cpp.io.FileInput;
#end