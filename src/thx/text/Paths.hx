/**
 * ...
 * @author Franco Ponticelli
 */

package thx.text;

class Paths
{
	public static function base(path : String, ?suffix : String) : String
	{
#if php
		return untyped __call__("basename", path, suffix); // check this is the same as not passing suffix when null
#else
		var pos = Ints.max(path.lastIndexOf('/'), path.lastIndexOf('\\'));
		if (pos >= 0)
			path = path.substr(pos + 1);
		if (null != suffix && path.substr(path.length - suffix.length) == suffix)
			path = path.substr(0, path.length - suffix.length);
		return path;
#end
	}


	// TODO test me
	// TODO check that the php version works the same as others
	public static function dir(path : String) : String
	{
#if php
		return untyped __call__("dirname", path);
#else
		var pos = Std.int(Math.max(path.lastIndexOf('/'), path.lastIndexOf('\\')));
		if (pos < 0)
			return '.'; // no parent dir
		var p = path.substr(0, pos);
		if (p == '/')
			return p;
		var p = Strings.rtrim(p, '/\\');
		return (~/(\\\/)+/).replace(p, '/');
#end
	}

	public static function ext(path : String)
	{
		return path.split(".").pop();
	}

	public static function removeExt(filename : String)
	{
		var t = filename.split(".");
		if(t.length > 1)
			t.pop();
		return t.join(".");
	}
}