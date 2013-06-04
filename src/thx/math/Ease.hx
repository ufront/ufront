package thx.math;

import thx.math.EaseMode;

class Ease
{
	public static function mode(?easemode : EaseMode, ?f : Float -> Float)
	{
		if (null == f)
			f = Equations.cubic;
		if (null == easemode)
			easemode = EaseIn;
		switch(easemode)
		{
			case EaseIn:
				return f;
			case EaseOut:
				return function(t : Float) return 1 - f(1 - t);
			case EaseInEaseOut:
				return function(t) return .5 * (t < .5 ? f(2 * t) : (2 - f(2 - 2 * t)));
			case EaseOutEaseIn:
				return mode(EaseInEaseOut,mode(EaseOut, f));
		}
	}
}