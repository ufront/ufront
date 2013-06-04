package thx.csv;
import thx.data.IDataHandler;
import thx.error.Error;
import thx.text.ERegs;
import thx.culture.FormatDate;

/**
 * ...
 * @author Franco Ponticelli
 */

class CsvEncoder implements IDataHandler
{
	public var delimiter(default, null) : String;
	public var nulltoempty(default, null) : Bool;
	public var newline(default, null) : String;
	public var encodedString(default, null) : String;

	var re : EReg;
	var buf : StringBuf;

	var lineContext : Bool;
	var valueContext : Bool;
	var firstLine : Bool;
	var firstValue : Bool;

	public function new(delimiter = ",", nulltoempty = true, newline = "\n")
	{
		this.delimiter = delimiter;
		this.nulltoempty = nulltoempty;
		this.newline = newline;
		re = new EReg('(' + ERegs.escapeERegChars(delimiter) + '|\n\r|\n|\r|")', "");
	}

	public function start()
	{
		buf = new StringBuf();
		firstLine = true;
		lineContext = true;
	}
	public function end()
	{
		encodedString = buf.toString();
	}

	public function objectStart()
	{
		throw new Error("objects cannot be encoded to CSV");
	}
	public function objectFieldStart(name : String) : Void {}
	public function objectFieldEnd() : Void {}
	public function objectEnd() : Void {}

	public function arrayStart()
	{

	}
	public function arrayItemStart()
	{
		if (lineContext)
		{
			lineContext = false;
			firstValue = true;
			if (firstLine)
				firstLine = false;
			else
				buf.add(newline);
		} else {
			if (firstValue)
				firstValue = false;
			else
				buf.add(delimiter);
		}
	}
	public function arrayItemEnd()
	{

	}
	public function arrayEnd()
	{
		if (!lineContext)
			lineContext = true;
	}

	public function valueDate(d : Date)
	{
		if (d.getSeconds() == 0 && d.getMinutes() == 0 && d.getHours() == 0)
			buf.add(Dates.format(d, "C", ["%Y-%m-%d"]));
		else
			buf.add(Dates.format(d, "C", ["%Y-%m-%d %H:%M:%S"]));
	}
	public function valueString(s : String)
	{
		if (re.match(s))
		{
			buf.add('"' + StringTools.replace(s, '"', '""') + '"');
		} else {
			buf.add(s);
		}
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
		if (!nulltoempty)
			buf.add("null");
	}

	public function valueBool(b : Bool)
	{
		buf.add(b ? "true" : "false");
	}

	public function comment(s : String)
	{
		// CSV does not support comments
	}
}