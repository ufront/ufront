package thx.math;

/**
 * ...
 * @author Franco Ponticelli
 */

class Equations
{
	public static function linear(v : Float) : Float
	{
		return v;
	}

	public static function polynomial(t : Float, e : Float) : Float
	{
		return Math.pow(t, e);
	}

	public static function quadratic(t : Float) : Float
	{
		return polynomial(t, 2);
	}

	public static function cubic(t : Float) : Float
	{
		return polynomial(t, 3);
	}

	public static function sin(t : Float) : Float
	{
		return 1 - Math.cos(t * Math.PI / 2);
	}

	public static function exponential(t : Float) : Float
	{
		return t != 0 ? Math.pow(2, 10 * (t - 1)) - 1e-3 : 0;
	}

	public static function circle(t : Float) : Float
	{
		return 1 - Math.sqrt(1 - t * t);
	}

	public static function elastic(t : Float, ?a : Float, ?p : Float) : Float
	{
		var s;
		if (null == p)
			p = 0.45;
		if (null == a)
		{
			a = 1;
			s = p / 4;
		} else
			s = p / (2 * Math.PI) / Math.asin(1 / a);
		return 1 + a * Math.pow(2, 10 * -t) * Math.sin((t - s) * 2 * Math.PI / p);
	}

	public static function elasticf(?a : Float, ?p : Float) : Float -> Float
	{
		var s;
		if (null == p)
			p = 0.45;
		if (null == a)
		{
			a = 1;
			s = p / 4;
		} else
			s = p / (2 * Math.PI) / Math.asin(1 / a);
		return function(t : Float) return 1 + a * Math.pow(2, 10 * -t) * Math.sin((t - s) * 2 * Math.PI / p);
	}


	public static function back(t : Float, ?s : Float) : Float
	{
		if (null == s) s = 1.70158;
		return t * t * ((s + 1) * t - s);
	}

	public static function backf(?s : Float) : Float -> Float
	{
		if (null == s) s = 1.70158;
		return function(t : Float) return t * t * ((s + 1) * t - s);
	}

	public static function bounce(t : Float) : Float
	{
		return t < 1 / 2.75 ? 7.5625 * t * t
			  : t < 2 / 2.75 ? 7.5625 * (t -= 1.5 / 2.75) * t + .75
			  : t < 2.5 / 2.75 ? 7.5625 * (t -= 2.25 / 2.75) * t + .9375
			  : 7.5625 * (t -= 2.625 / 2.75) * t + .984375;
	}

	public static function polynomialf(e : Float)
	{
		return function(t) polynomial(t, e);
	}
}