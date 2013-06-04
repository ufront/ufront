package thx.ini;
import thx.data.IDataHandler;
import thx.data.ValueEncoder;
import thx.data.ValueHandler;
import thx.error.Error;

/**
 * ...
 * @author Franco Ponticelli
 */

// TODO line continuations

class IniDecoder
{
	static var linesplitter = ~/[^\\](#|;)/;

	public var emptytonull(default, null) : Bool;
	public var explodesections(default, null) : Bool;
	var handler : IDataHandler;
	var other : IDataHandler;
	var value : ValueHandler;
	var insection : Bool;

	public function new(handler : IDataHandler, explodesections = true, emptytonull = true)
	{
		this.explodesections = explodesections;
		if (explodesections)
		{
			this.handler = value = new ValueHandler();
			this.other = handler;
		} else {
			this.handler = handler;
		}
		this.emptytonull = emptytonull;
	}

	public function decode(s : String)
	{
		handler.start();
		handler.objectStart();

		insection = false;
		decodeLines(s);
		if (insection)
		{
			handler.objectEnd();
			handler.objectFieldEnd();
		}
		handler.objectEnd();
		handler.end();

		if (explodesections)
		{
			new ValueEncoder(other).encode(explodeSections(value.value));
		}
	}

	static function explodeSections(o : { } )
	{
		for (field in Reflect.fields(o))
		{
			var parts = field.split(".");
			if (parts.length == 1)
				continue;
			var ref = o;
			for (i in 0...parts.length-1)
			{
				var name = parts[i];
				if (!Reflect.hasField(ref, name))
					Reflect.setField(ref, name, { } );
				ref = Reflect.field(ref, name);
			}
			var last = parts[parts.length - 1];
			var v = Reflect.field(o, field);
			Reflect.deleteField(o, field);
			Reflect.setField(ref, last, v);
		}
		return o;
	}

	function decodeLines(s)
	{
		var lines = (~/(\n\r|\n|\r)/g).split(s);
		for (line in lines)
			decodeLine(line);
	}

	function decodeLine(line : String)
	{
		if (StringTools.trim(line) == '')
			return;
		line = StringTools.ltrim(line);
		var c = line.substr(0, 1);
		switch(c)
		{
			case "[": // section
				if (insection)
				{
					handler.objectEnd();
					handler.objectFieldEnd();
				} else
					insection = true;
				handler.objectFieldStart(line.substr(1, line.indexOf("]")-1));
				handler.objectStart();
				return;
			case "#", ";": // comment
				handler.comment(line.substr(1));
				return;
		}

		var pos = 0;
		do
		{
			pos = line.indexOf("=", pos);
		} while (pos > 0 && line.substr(pos - 1, 1) == '\\');
		if (pos <= 0)
			throw new Error("invalid key pair (missing '=' symbol?): {0}", line);

		var key = StringTools.trim(dec(line.substr(0, pos)));
		var value = line.substr(pos + 1);
		var parts = linesplitter.split(value);
		handler.objectFieldStart(key);
		decodeValue(parts[0]);
		if (parts.length > 1)
			handler.comment(parts[1]);
		handler.objectFieldEnd();
	}

	function dec(s : String)
	{
		for (i in 0...IniEncoder.encoded.length)
			s = StringTools.replace(s, IniEncoder.encoded[i], IniEncoder.decoded[i]);
		return s;
	}

	function decodeValue(s : String)
	{
		s = StringTools.trim(s);
		// check quotes
		var c = s.substr(0, 1);
		if (c == '"' || c == "'" && s.substr(-1) == c)
		{
			handler.valueString(dec(s.substr(1, s.length-2)));
			return;
		}

		if (Ints.canParse(s))
			handler.valueInt(Ints.parse(s));
		else if (Floats.canParse(s, true))
			handler.valueFloat(Floats.parse(s));
		else if (Dates.canParse(s))
			handler.valueDate(Dates.parse(s));
		else if (emptytonull && "" == s)
			handler.valueNull();
		else
		{
			switch(s.toLowerCase())
			{
				case 'yes', 'true', 'on':
					handler.valueBool(true);
				case 'no', 'false', 'off':
					handler.valueBool(false);
				default:
					var parts = s.split(", ");
					if (parts.length > 1)
					{
						handler.arrayStart();
						for (part in parts)
						{
							handler.arrayItemStart();
							decodeValue(part);
							handler.arrayItemEnd();
						}
						handler.arrayEnd();
					} else {
						s = dec(s);
						handler.valueString(s);
					}
			}
		}
	}
}