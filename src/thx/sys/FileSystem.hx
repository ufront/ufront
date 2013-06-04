/**
 * ...
 * @author Franco Ponticelli
 */

package thx.sys;

#if haxe3
typedef FileSystem = sys.FileSystem;
#elseif neko
typedef FileSystem = neko.FileSystem;
#elseif php
typedef FileSystem = php.FileSystem;
#elseif cpp
typedef FileSystem = cpp.FileSystem;
#end