/**
 * ...
 * @author Franco Ponticelli
 */

package thx.ini;
import thx.collection.Set;
import thx.data.IDataHandler;
import thx.error.Error;

class IniEncoder implements IDataHandler
{
	public var ignorecomments(default, null) : Bool;
	public var newline(default, null) : String;
	var buf : StringBuf;

	public var encodedString(default, null) : String;

	public function new(newline = "\n", ignorecomments = true)
	{
		this.newline = newline;
		this.ignorecomments = ignorecomments;
	}

	var inarray : Int;
	var cache : Map<String, Array<String>>;
	var value : String;
	var stack : Array<String>;

	public function start()
	{
		inarray = 0;
		stack = [];
		cache = new Map ();
	}

	public function end()
	{
		var keys = Iterators.order(cache.keys());
		var lines = [];

		for (key in keys)
		{
			if ("" != key)
			{
				lines.push("");
				lines.push("[" + key + "]");
			}
			lines = lines.concat(cache.get(key));
		}
		encodedString = StringTools.trim(lines.join(newline));
	}


	public function objectStart()
	{
		if (inarray > 0)
			throw new Error("arrays must contain only primitive values");
	}

	public function objectFieldStart(name : String)
	{
		stack.push(enc(name));
		value = "";
	}

	public function objectFieldEnd() : Void
	{
		if (null == value)
			return;
		var key = stack.pop();
		var name = stack.join(".");
		var section = getSection(name);
		section.push(key + "=" + value);
		value = null;
	}

	function getSection(name : String)
	{
		var section = cache.get(name);
		if (null == section)
		{
			section = [];
			cache.set(name, section);
		}
		return section;
	}

	public function objectEnd()
	{
		stack.pop();
	}

	public function arrayStart()
	{
		if (inarray > 0)
			throw new Error("nested arrays are not supported in the .ini format");
		inarray = 1;
		value = "";
	}

	public function arrayItemStart()
	{
		if (inarray == 1)
			inarray = 2;
		else
			value += ", ";
	}

	public function arrayItemEnd()
	{

	}

	public function arrayEnd()
	{
		inarray = 0;
	}

	public function valueDate(d : Date)
	{
		if (d.getSeconds() == 0 && d.getMinutes() == 0 && d.getHours() == 0)
			value += Dates.format(d, "C", ["%Y-%m-%d"]);
		else
			value += Dates.format(d, "C", ["%Y-%m-%d %H:%M:%S"]);
	}
	public function valueString(s : String)
	{
		if (StringTools.trim(s) == s) // no trailing spaces
			value += enc(s);
		else
			value += quote(s);
	}

	public static var decoded = ['\\', String.fromCharCode(0), String.fromCharCode(7), String.fromCharCode(8), '\t', '\r', '\n', ';', '#', '=', ':'];
	public static var encoded = ['\\\\', '\\0', '\\a', '\\b', '\\t', '\\r', '\\n', '\\;', '\\#', '\\=', '\\:'];

	function enc(s)
	{
		for (i in 0...decoded.length)
			s = StringTools.replace(s, decoded[i], encoded[i]);
		return s;
	}

	function quote(s)
	{
		return '"' + StringTools.replace(enc(s), '"', '\\"') + '"';
	}

	public function valueInt(i : Int)
	{
		value += i;
	}
	public function valueFloat(f : Float)
	{
		value += f;
	}
	public function valueNull()
	{
		value += "";
	}
	public function comment(s : String)
	{
		if(!ignorecomments)
			value += "#" + s;
	}

	public function valueBool(b : Bool)
	{
		value += b ? "ON" : "OFF";
	}
}