import thx.error.Error;
import thx.math.Equations;
import thx.culture.FormatNumber;
/**
 * ...
 * @author Franco Ponticelli
 */
import thx.culture.Culture;
import thx.culture.FormatParams;

class Floats
{
	public static function normalize(v : Float) : Float
	{
		if (v < 0.0)
			return 0.0;
		else if (v > 1.0)
			return 1.0;
		else
			return v;
	}

	public static function clamp(v : Float, min : Float, max : Float) : Float
	{
		if (v < min)
			return min;
		else if (v > max)
			return max;
		else
			return v;
	}

	public static function clampSym(v : Float, max : Float) : Float
	{
		if (v < -max)
			return -max;
		else if (v > max)
			return max;
		else
			return v;
	}

	public static function range(start : Float, ?stop : Float, step = 1.0, inclusive = false) : Array<Float>
	{
		if (null == stop)
		{
			stop = start;
			start = 0.0;
		}
		if ((stop - start) / step == Math.POSITIVE_INFINITY) throw new Error("infinite range");
		var range = [], i = -1.0, j;
		if(inclusive) {
			if (step < 0)
				while ((j = start + step * ++i) >= stop) range.push(j);
			else
				while ((j = start + step * ++i) <= stop) range.push(j);
		} else {
			if (step < 0)
				while ((j = start + step * ++i) > stop) range.push(j);
			else
				while ((j = start + step * ++i) < stop) range.push(j);
		}
		return range;
	}

	inline public static function sign(v : Float)
	{
		return v < 0 ? -1 : 1;
	}

	inline public static function abs(a : Float)
	{
		return a < 0 ? -a : a;
	}

	inline public static function min(a : Float, b : Float)
	{
		return a < b ? a : b;
	}

	inline public static function max(a : Float, b : Float)
	{
		return a > b ? a : b;
	}

	public static function wrap(v : Float, min : Float, max : Float) : Float
	{
		var range = max - min + 1;
		if (v < min) v += range * ((min - v) / range + 1);
		return min + (v - min) % range;
	}

	public static function circularWrap(v : Float, max : Float) : Float
	{
		v = v % max;
		if (v < 0)
			v += max;
		return v;
	}

	public static function interpolate(f : Float, a = 0.0, b = 1.0, ?equation : Float -> Float)
	{
		if (null == equation)
			equation = Equations.linear;
		return a + equation(f) * (b - a);
	}

	public static function interpolatef(a = 0.0, b = 1.0, ?equation : Float -> Float)
	{
		if (null == equation)
			equation = Equations.linear;
		var d = b - a;
		return function(f) return a + equation(f) * d;
	}


	public static function interpolateClampf(min : Float, max : Float, ?equation : Float -> Float)
	{
		if (null == equation)
			equation = Equations.linear;
		return function(a : Float, b : Float)
		{
			var d = b - a;
			return function(f) return a + equation(clamp(f, min, max)) * d;
		}
	}

	public static function format(v : Float, ?param : String, ?params : Array<String>, ?culture : Culture)
	{
		return formatf(param, params, culture)(v);
	}

	public static function formatf(?param : String, ?params : Array<String>, ?culture : Culture)
	{
		params = FormatParams.params(param, params, 'D');
		var format = params.shift();
		var decimals : Null<Int> = params.length > 0 ? Std.parseInt(params[0]) : null;
		switch(format)
		{
			case 'D':
				return function(v) return FormatNumber.decimal(v, decimals, culture);
			case 'I':
				return function(v) return FormatNumber.int(v, culture);
			case 'C':
				var s = params.length > 1 ? params[1] : null;
				return function(v) return FormatNumber.currency(v, s, decimals, culture);
			case 'P':
				return function(v) return FormatNumber.percent(v, decimals, culture);
			case 'M':
				return function(v) return FormatNumber.permille(v, decimals, culture);
			default:
				return throw new Error("Unsupported number format: {0}", format);
		}
	}

	static var _reparse = ~/^[+\-]?(?:0|[1-9]\d*)(?:\.\d*)?(?:[eE][+\-]?\d+)?/;
	static var _reparseStrict = ~/^[+\-]?(?:0|[1-9]\d*)(?:\.\d*)?(?:[eE][+\-]?\d+)?$/;
	public static function canParse(s : String, strict = false)
	{
		if(strict)
			return _reparseStrict.match(s);
		else
			return _reparse.match(s);
	}

	public static function parse(s : String)
	{
		if (s.substr(0, 1) == "+")
			s = s.substr(1);
		return Std.parseFloat(s);
	}

	inline public static function compare(a : Float, b : Float)
	{
		return a < b ? -1 : (a > b ? 1 : 0);
	}

	inline public static function isNumeric(v : Dynamic)
	{
		return Std.is(v, Float) || Std.is(v, Int);
	}

	public static function equals(a : Float, b : Float, ?approx : Float = 1e-5)
	{
		if (Math.isNaN(a))
			return Math.isNaN(b);
		else if (Math.isNaN(b))
			return false;
		else if (!Math.isFinite(a) && !Math.isFinite(b))
			return (a > 0) == (b > 0);
		return Math.abs(b-a) < approx;
	}

	public static function uninterpolatef(a : Float, b : Float)
	{
		b = 1 / (b - a);
		return function(x : Float) return (x - a) * b;
	}

	public static function uninterpolateClampf(a : Float, b : Float)
	{
		b = 1 / (b - a);
		return function(x : Float) return clamp((x - a) * b, 0.0, 1.0);
	}

	public static function round( number : Float, precision = 2): Float {
		number *= Math.pow(10, precision);
		return Math.round( number ) / Math.pow(10, precision);
	}


}