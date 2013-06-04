package thx.sys.io;

#if haxe3
typedef File = sys.io.File;
#elseif neko
typedef File = neko.io.File;
#elseif php
typedef File = php.io.File;
#elseif cpp
typedef File = cpp.io.File;
#end