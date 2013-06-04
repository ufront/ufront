package thx.json;

import thx.data.IDataHandler;
import thx.error.Error;

using Lambda;

class JsonEncoder implements IDataHandler
{
	public var encodedString(default, null) : String;

	var buf : StringBuf;
	var lvl : Int;
	var count : Array<Int>;

	public function new()
	{
	}

	public function start()
	{
		lvl = 0;
		buf = new StringBuf();
		encodedString = null;
		count = [];
	}
	public function end()
	{
		encodedString = buf.toString();
		buf = null;
	}

	public function objectStart()
	{
		buf.add("{");
		count.push(0);
	}
	public function objectFieldStart(name : String)
	{
		if (count[count.length - 1]++ > 0)
			buf.add(",");
		buf.add(quote(name) + ":");
	}
	public function objectFieldEnd(){}

	public function objectEnd()
	{
		buf.add("}");
		count.pop();
	}

	public function arrayStart()
	{
		buf.add("[");
		count.push(0);
	}
	public function arrayItemStart()
	{
		if (count[count.length - 1]++ > 0)
			buf.add(",");
	}
	public function arrayItemEnd(){}
	public function arrayEnd()
	{
		buf.add("]");
		count.pop();
	}

	public function valueDate(d : Date)
	{
		buf.add(d.getTime());
	}
	public function valueString(s : String)
	{
		buf.add(quote(s));
	}
	public function valueInt(i : Int)
	{
		buf.add(i);
	}
	public function valueFloat(f : Float)
	{
		buf.add(f);
	}
	public function valueNull()
	{
		buf.add("null");
	}
	public function valueBool(b : Bool)
	{
		buf.add(b ? "true" : "false");
	}
	public function comment(s : String)
	{
		// Json does not support comments
	}

	function quote(s)
	{
		return '"' + ~/./.map (~/(\n)/g.replace (~/("|\\)/g.replace (s, "\\$1"), "\\n"), function (r) {
			var c = r.matched (0).charCodeAt (0);
			return c >= 32 && c <= 127 ? String.fromCharCode (c) : "\\u" + StringTools.hex (c, 4);
		}) + '"';
	}
}