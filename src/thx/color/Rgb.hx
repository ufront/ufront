/**
 * ...
 * @author Franco Ponticelli
 */

package thx.color;

using Ints;
import Floats;
import thx.error.Error;
using thx.math.Equations;
using StringTools;

class Rgb
{
	public var blue(default, null) : Int;
	public var green(default, null) : Int;
	public var red(default, null) : Int;

	/**
	 *
	 * @param r	an Int value between 0 and 255 for the red channel
	 * @param g	an Int value between 0 and 255 for the green channel
	 * @param b	an Int value between 0 and 255 for the blue channel
	 */
	public function new(r : Int, g : Int, b : Int)
	{
		red   = r.clamp(0, 255);
		green = g.clamp(0, 255);
		blue  = b.clamp(0, 255);
	}

	public function int()
	{
		return ( ( red & 0xFF ) << 16 ) | ( ( green & 0xFF ) << 8 ) | ( ( blue & 0xFF ) << 0 );
	}

	public function hex(?prefix = "")
	{
		return prefix + red.hex(2) + green.hex(2) + blue.hex(2);
	}

	inline public function toCss() return hex('#');

	public function toRgbString()
	{
		return "rgb(" + red + "," + green + "," + blue + ")";
	}

	public function toString()
	{
		return toRgbString();
	}

	public static function fromFloats(r : Float, g : Float, b : Float)
	{
		return new Rgb(
			r.interpolate(0, 255),
			g.interpolate(0, 255),
			b.interpolate(0, 255));
	}

	public static function fromInt( v: Int ): Rgb
	{
		return new Rgb((v >> 16) & 0xFF, (v >> 8) & 0xFF, (v >> 0 ) & 0xFF);
	}

	public static function equals(a : Rgb, b : Rgb)
	{
		return a.red == b.red && a.green == b.green && a.blue == b.blue;
	}

	public static function darker(color : Rgb, t : Float, ?equation : Float -> Float) : Rgb
	{
		return new Rgb(
			t.interpolate(color.red,   0, equation),
			t.interpolate(color.green, 0, equation),
			t.interpolate(color.blue,  0, equation)
		);
	}

	public static function lighter(color : Rgb, t : Float, ?equation : Float -> Float) : Rgb
	{
		return new Rgb(
			t.interpolate(color.red,   255, equation),
			t.interpolate(color.green, 255, equation),
			t.interpolate(color.blue,  255, equation)
		);
	}

	public static function interpolate(a : Rgb, b : Rgb, t : Float, ?equation : Float -> Float)
	{
		return new Rgb(
			t.interpolate(a.red, b.red, equation),
			t.interpolate(a.green, b.green, equation),
			t.interpolate(a.blue, b.blue, equation)
		);
	}

	public static function interpolatef(a : Rgb, b : Rgb, ?equation : Float -> Float)
	{
		var r = Ints.interpolatef(a.red, b.red, equation),
			g = Ints.interpolatef(a.green, b.green, equation),
			b = Ints.interpolatef(a.blue, b.blue, equation);
		return function(t) return new Rgb(r(t), g(t), b(t));
	}

	public static function contrast(c : Rgb)
	{
		var nc = Hsl.toHsl(c);
		if (nc.lightness < .5)
			return new Hsl(nc.hue, nc.saturation, nc.lightness + 0.5);
		else
			return new Hsl(nc.hue, nc.saturation, nc.lightness - 0.5);
	}

	public static function contrastBW(c : Rgb)
	{
		var g = Grey.toGrey(c);
		var nc = Hsl.toHsl(c);
		if (g.grey < .5)
			return new Hsl(nc.hue, nc.saturation, 1.0);
		else
			return new Hsl(nc.hue, nc.saturation, 0);
	}

	public static function interpolateBrightness(t : Float, ?equation : Float -> Float) return interpolateBrightnessf(equation)(t);
	public static function interpolateBrightnessf(?equation : Float -> Float)
	{
		var i = Ints.interpolatef(0, 255, equation);
		return function(t)
		{
			var g = i(t);
			return new Rgb(g, g, g);
		};
	}


	public static function interpolateHeat(t : Float, ?middle, ?equation : Float -> Float) return interpolateHeatf(middle, equation)(t);
	public static function interpolateHeatf(?middle : Rgb, ?equation : Float -> Float)
	{
		return interpolateStepsf([
			new Rgb(0, 0, 0),
			null != middle ? middle : new Rgb(255, 127, 0),
			new Rgb(255, 255, 255),
		], equation);
	}

	public static function interpolateRainbow(t : Float, ?equation : Float -> Float) return interpolateRainbowf(equation)(t);
	public static function interpolateRainbowf(?equation : Float -> Float)
	{
		return interpolateStepsf([
			new Rgb(0,   0,   255),
			new Rgb(0,   255, 255),
			new Rgb(0,   255, 0),
			new Rgb(255, 255, 0),
			new Rgb(255, 0,   0),
		], equation);
	}

	public static function interpolateStepsf(steps : Array<Rgb>, ?equation : Float -> Float)
	{
		if (steps.length <= 0)
			return throw new Error("invalid number of steps");
		else if (steps.length == 1)
			return function(t) return steps[0];
		else if (steps.length == 2)
			return interpolatef(steps[0], steps[1], equation);

		var len = steps.length - 1,
			step = 1 / len,
			f = [];
		for (i in 0...len)
			f[i] = interpolatef(steps[i], steps[i+1]);

		return function(t : Float)
		{
			if (t < 0)
				t = 0;
			else if(t > 1)
				t = 1;
			var pos = t == 1 ? (len - 1) : Math.floor(t / step);
			return f[pos](len * (t - (pos * step)));
		};
	}
}