package thx.json;
import thx.data.IDataHandler;
import thx.error.Error;

import haxe.Utf8;

/**
 * ...
 * @author Franco Ponticelli
 */

class JsonDecoder
{
	var col : Int;
	var line : Int;
	var tabsize : Int;
	var src : String;
	var char : String;
	var pos : Int;

	var handler : IDataHandler;

	public function new(handler : IDataHandler, tabsize = 4)
	{
		this.handler = handler;
		this.tabsize = tabsize;
	}

	public function decode(s : String) : Void
	{
		col = 0;
		line = 0;
		src = s;
		char = null;
		pos = 0;
		ignoreWhiteSpace();

		handler.start();
		try
		{
			parse();
		} catch (e : StreamError)
		{
			error("unexpected end of stream");
		}
		ignoreWhiteSpace();
		if (pos < src.length)
			error("the stream contains unrecognized characters at its end");
		handler.end();
	}

	function ignoreWhiteSpace()
	{
		while (pos < src.length)
		{
			var c = readChar();
			switch(c)
			{
				case " ":
					col++;
				case "\n":
					col = 0;
					line++;
				case "\r":
				case "\t":
					col += tabsize;
				default:
					char = c;
					return;
			}
		}
	}

	function parse()
	{
		var c = readChar();
		switch(c)
		{
			case "{":
				col++;
				ignoreWhiteSpace();
				parseObject();
			case "[":
				col++;
				ignoreWhiteSpace();
				parseArray();
			case '"':
				char = c;
				parseString();
			default: // value or error
				char = c;
				parseValue();
		}
	}

	function readChar()
	{
		if (null == char)
		{
			if (pos == src.length)
				throw StreamError.Eof;
			return src.charAt(pos++);
		} else {
			var c = char;
			char = null;
			return c;
		}
	}

	function expect(word : String)
	{
		var test = null == char ? src.substr(pos, word.length) : char + src.substr(pos, word.length - 1);
		if (test == word)
		{
			if (null == char)
			{
				pos += word.length;
			} else {
				pos += word.length - 1;
				char = null;
			}
			return true;
		} else {
			return false;
		}
	}

	function parseObject()
	{
		var first = true;
		handler.objectStart();
		while (true)
		{
			ignoreWhiteSpace();
			if (expect("}"))
				break;
			else if (first)
				first = false;
			else if (expect(","))
				ignoreWhiteSpace();
			else
				error("expected ','");

			var k = _parseString();
			ignoreWhiteSpace();
			if (!expect(":"))
				error("expected ':'");
			ignoreWhiteSpace();
			handler.objectFieldStart(k);
			parse();
			handler.objectFieldEnd();
		}
		handler.objectEnd();
	}

	function parseArray()
	{
		ignoreWhiteSpace();
		var first = true;
		handler.arrayStart();
		while (true)
		{
			ignoreWhiteSpace();
			if (expect("]"))
				break;
			else if (first)
				first = false;
			else if (expect(","))
				ignoreWhiteSpace();
			else
				error("expected ','");
			handler.arrayItemStart();
			parse();
			handler.arrayItemEnd();
		}
		handler.arrayEnd();
	}

	function parseValue()
	{
		if (expect("true"))
			handler.valueBool(true);
		else if (expect("false"))
			handler.valueBool(false);
		else if (expect("null"))
			handler.valueNull();
		else
			parseFloat();
	}

	function parseString()
	{
		handler.valueString(_parseString());
	}

	function _parseString()
	{
		if (!expect('"'))
			error('expected double quote');
		var buf = "";
		var esc = false;
		while (true)
		{
			var c = readChar();
			col++;
			if (esc)
			{
				switch(c)
				{
					case '"':
						buf += '"';
					case "\\":
						buf += "\\";
					case "/":
						buf += "/";
					case "b":
						buf += String.fromCharCode(8);
					case "f":
						buf += String.fromCharCode(12);
					case "n":
						buf += "\n";
					case "r":
						buf += "\r";
					case "t":
						buf += "\t";
					case "u":
						#if (neko || php)
						var utf = new Utf8();
						utf.addChar(parseHexa());
						buf += utf.toString();
						#else
						buf += String.fromCharCode(parseHexa());
						#end
					default:
						error("unexpected char " + c);
				}
				esc = false;
			} else {
				switch(c)
				{
					case "\\":
						esc = true;
					case '"':
						break;
					default:
						buf += c;
				}
			}
		}
		return buf;
	}

	function parseHexa()
	{
		var v = [];
		for (i in 0...4)
		{
			var c = readChar();
			var i = c.toLowerCase().charCodeAt(0);
			if (!((i >= 48 && i <= 57) || (i >= 97 && i <= 102)))
				error("invalid hexadecimal value " + c);
			v.push(c);
		}
		handler.valueInt(Std.parseInt("0x" + v.join("")));
		return Std.parseInt("0x" + v.join(""));
	}

	function parseFloat()
	{
		var v = "";
		if (expect("-"))
			v = "-";
		if (expect("0"))
			v += "0";
		else
		{
			var c = readChar();
			var i = c.charCodeAt(0);
			if (i < 49 || i > 57)
				error("expected digit between 1 and 9");
			v += c;
			col++;
		}

		try
		{
			v += parseDigits();
		} catch (e : StreamError) {
			handler.valueInt(Std.parseInt(v));
			return;
		}

		try
		{
			if (expect("."))
			{
				v += "." + parseDigits(1);
			} else {
				handler.valueInt(Std.parseInt(v));
				return;
			}

			if (expect("e") || expect("E"))
			{
				v += "e";
				if (expect("+"))
				{

				} else if (expect("-")) {
					v += "-";
				}
				v += parseDigits(1);
			}
		} catch (e : StreamError)
		{
			handler.valueFloat(Std.parseFloat(v)); // TODO remove
			return; // TODO remove
		}
		handler.valueFloat(Std.parseFloat(v));
	}

	function parseDigits(atleast = 0)
	{
		var buf = "";
		while (true)
		{
			var c = null;
			try
			{
				c = readChar();
			} catch (e : StreamError) {
				if (buf.length < atleast)
					error("expected digit");
				return buf;
			}
			var i = c.charCodeAt(0);
			if (i < 48 || i > 57)
			{
				if (buf.length < atleast)
					error("expected digit");
				col += buf.length;
				char = c;
				return buf;
			} else
				buf += c;
		}
		return null; // should nver reach this point
	}

	function error(msg : String)
	{
		var context = pos == src.length ? "" : "\nrest: " + (null != char ? char : "") + src.substr(pos) + "...";
		throw new Error("error at L {0} C {1}: {2}{3}", [line, col, msg,  context]);
	}
}

private enum StreamError {
	Eof;
}