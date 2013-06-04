package thx.color;

using Strings;
using StringTools;
using Arrays;

/**
 * ...
 * @author Franco Ponticelli
 */

class Colors
{
	public static function interpolatef(a : String, b : String, ?equation : Float -> Float)
	{
		var ca = parse(a);
		var cb = parse(b);
		var f = Rgb.interpolatef(ca, cb, equation);
		return function(v) return f(v).toString();
	}

	public static function interpolate(v : Float, a : String, b : String, ?equation : Float -> Float)
	{
		return interpolatef(a, b, equation)(v);
	}

	static var _reParse = ~/^(?:(hsl|rgb|rgba|cmyk)\(([^)]+)\))|(?:(?:0x|#)([a-f0-9]{3,6}))$/i;

	// hsl(h,s,l)
	// rgb(r,g,b)
	// rgba(r,g,b,a)
	// hex 3
	// hex 6
	// named
	public static function parse(s : String)
	{
		if (!_reParse.match(s = StringTools.trim(s.toLowerCase())))
		{
			var v = NamedColors.byName.get(s);
			if (null == v)
				if ("transparent" == s)
					return Rgb.fromInt(0xFFFFFF);
				else
					return null;
			else
				return v;
		}
		var type = _reParse.matched(1);
		if (!type.empty())
		{
			var values = _reParse.matched(2).split(",");
			switch(type)
			{
				case "rgb", "rgba":
					return new Rgb(_c(values[0]), _c(values[1]), _c(values[2]));
				case "hsl":
					return new Hsl(_d(values[0]), _p(values[1]), _p(values[2]));
				case "cmyk":
					return new Cmyk(_p(values[0]), _p(values[1]), _p(values[2]), _p(values[3]));
			}
		}
		var color = _reParse.matched(3);
		if (color.length == 3)
			color = color.split("").map(function(d) return d + d).join("");
		else if (color.length != 6)
			return null;
		return Rgb.fromInt(Std.parseInt("0x" + color));
	}

	static function _c(s : String) : Int
	{
		return Std.parseInt(s.trim());
	}

	static function _d(s : String) : Float
	{
		var s = s.trim();
		if (s.substr( -3) == 'deg')
			s = s.substr(0, -3);
		else if (s.substr( -1) == 'º')
			s = s.substr(0, -1);
		return Std.parseFloat(s);
	}

	static function _p(s : String) : Float
	{
		var s = s.trim();
		if (s.substr( -1) == "%")
			return Std.parseFloat(s.substr(0, -1)) / 100;
		else
			return Std.parseFloat(s);
	}
}