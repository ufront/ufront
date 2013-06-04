package thx.sys.io;

#if neko
typedef Process = neko.io.Process;
#elseif php
typedef Process = php.io.Process;
#elseif cpp
typedef Process = cpp.io.Process;
#end