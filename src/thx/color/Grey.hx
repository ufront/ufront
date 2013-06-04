/**
 * ...
 * @author Franco Ponticelli
 */

package thx.color;

import Floats;
using Floats;
using thx.math.Equations;

class Grey extends Rgb
{
	public var grey(default, null) : Float;

	public function new( value : Float )
	{
		grey = value.normalize();
		var c = Ints.interpolate(grey, 0, 255);
		super(c, c, c);
	}

	public static function toGrey(rgb : Rgb, ?luminance : PerceivedLuminance)
	{
		if (null == luminance)
			luminance = Perceived;
		switch(luminance)
		{
			case Standard:
				return new Grey(rgb.red / 255 * .2126 + rgb.green / 255 * .7152 + rgb.blue / 255 * .0722);
			case Perceived:
				return new Grey(rgb.red / 255 * .299 + rgb.green / 255 * .587 + rgb.blue / 255 * .114);
			case PerceivedAccurate:
				return new Grey(Math.sqrt(
					  0.241 * Math.pow(rgb.red / 255, 2)
					+ 0.691 * Math.pow(rgb.green / 255, 2)
					+ 0.068 * Math.pow(rgb.blue / 255, 2)
				));
		}
	}

	public static function equals(a : Grey, b : Grey)
	{
		return a.grey == b.grey;
	}

	public static function darker(color : Grey, t : Float, ?equation : Float -> Float) : Grey
	{
		return new Grey(Floats.interpolate(t, color.grey, 0, equation));
	}

	public static function lighter(color : Grey, t : Float, ?equation : Float -> Float) : Grey
	{
		return new Grey(Floats.interpolate(t, color.grey, 1, equation));
	}

	public static function interpolate(a : Grey, b : Grey, t : Float, ?equation : Float -> Float)
	{
		return new Grey(Floats.interpolate(t, a.grey, b.grey, equation));
	}
}

enum PerceivedLuminance
{
	Standard;
	Perceived;
	PerceivedAccurate;
}