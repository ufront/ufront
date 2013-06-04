/**
 * ...
 * @author Franco Ponticelli
 */

import thx.culture.Culture;
import thx.culture.FormatParams;

class Bools
{
	public static function format(v : Bool, ?param : String, ?params : Array<String>, ?culture : Culture)
	{
		return formatf(param, params, culture)(v);
	}

	public static function formatf(?param : String, ?params : Array<String>, ?culture : Culture)
	{
		params = FormatParams.params(param, params, 'B');
		var format = params.shift();
		switch(format)
		{
			case 'B':
				return function(v) return v ? 'true' : 'false';
			case 'N':
				return function(v) return  v ? '1' : '0';
			case 'R':
				if (params.length != 2)
					throw "bool format R requires 2 parameters";
				return function(v) return v ? params[0] : params[1];
			default:
				throw "Unsupported bool format: " + format;
		}
	}

	public static function interpolate(v : Float, a : Bool, b : Bool, ?equation : Float -> Float)
	{
		return interpolatef(a, b, equation)(v);
	}

	public static function interpolatef(a : Bool, b : Bool, ?equation : Float -> Float)
	{
		if (a == b)
			return function(_) return a;
		else
		{
			var f = Floats.interpolatef(0, 1, equation);
			return function(v) return f(v) < 0.5 ? a : b;
		}
	}

	public static function canParse(s : String)
	{
		s = s.toLowerCase();
		return s == 'true' || s == 'false';
	}

	public static function parse(s : String)
	{
		return s.toLowerCase() == 'true';
	}

	inline public static function compare(a : Bool, b : Bool)
	{
		return a == b ? 0 : (a ? -1 : 1);
	}
}