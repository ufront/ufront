package thx.sys.io;

#if neko
typedef Path = neko.io.Path;
#elseif php
typedef Path = php.io.Path;
#elseif cpp
typedef Path = cpp.io.Path;
#end