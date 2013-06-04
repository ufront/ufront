/**
 * ...
 * @author Franco Ponticelli
 */

package thx.sys;

#if neko
typedef Lib = neko.Lib;
#elseif php
typedef Lib = php.Lib;
#elseif cpp
typedef Lib = cpp.Lib;
#end