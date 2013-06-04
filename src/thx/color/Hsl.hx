package thx.color;

/**
 * ...
 * @author Franco Ponticelli
 */

using Floats;
using thx.math.Equations;

class Hsl extends Rgb
{
	public var hue(default, null): Float;
	public var saturation(default, null): Float;
	public var lightness(default, null): Float;

	public function new(h : Float, s : Float, l : Float)
	{
		hue = h = h.circularWrap(360);
		saturation = s = s.normalize();
		lightness = l = l.normalize();
		super(
			Ints.interpolate(_c(h + 120, s, l), 0, 255),
			Ints.interpolate(_c(h, s, l), 0, 255),
			Ints.interpolate(_c(h - 120, s, l), 0, 255));
	}

	// Based on D3.js by Michael Bostock
	static function _c(d : Float, s : Float, l : Float) {
		var m2 = l <= 0.5 ? l * (1 + s) : l + s - l * s;
		var m1 = 2 * l - m2;

		d = d.circularWrap(360);
		if (d < 60)
			return m1 + (m2 - m1) * d / 60;
		else if (d < 180)
			return m2;
		else if (d < 240)
			return m1 + (m2 - m1) * (240 - d) / 60;
		else
			return m1;
	}

	public function toHslString()
	{
		return "hsl(" + hue + "," + (saturation*100) + "%," + (lightness*100) + "%)";
	}

	public static function toHsl(c : Rgb)
	{
		var	r : Float = c.red / 255.0;
		var	g = c.green / 255.0,
			b = c.blue / 255.0,
			min = r.min(g).min(b),
			max = r.max(g).max(b),
			delta = max - min,
			h,
			s,
			l = (max + min) / 2;
		if (delta == 0.0)
			s = h = 0.0;
		else {
			s = l < 0.5 ? delta / (max + min) : delta / (2 - max - min);
			if (r == max)
				h = (g - b) / delta + (g < b ? 6 : 0);
			else if (g == max)
				h = (b - r) / delta + 2;
			else
				h = (r - g) / delta + 4;
			h *= 60;
		}
		return new Hsl(h, s, l);
	}

	public static function equals(a : Hsl, b : Hsl)
	{
		return a.hue == b.hue && a.saturation == b.saturation && a.lightness == b.lightness;
	}

	public static function darker(color : Hsl, t : Float, ?equation : Float -> Float) : Hsl
	{
		return new Hsl(
			color.hue,
			color.saturation,
			t.interpolate(color.lightness, 0, equation)
		);
	}

	public static function lighter(color : Hsl, t : Float, ?equation : Float -> Float) : Hsl
	{
		return new Hsl(
			color.hue,
			color.saturation,
			t.interpolate(color.lightness, 1, equation)
		);
	}

	public static function interpolate(a : Hsl, b : Hsl, t : Float, ?equation : Float -> Float) : Hsl
	{
		return new Hsl(
			t.interpolate(a.hue,		b.hue,			equation),
			t.interpolate(a.saturation,	b.saturation,	equation),
			t.interpolate(a.lightness,	b.lightness,	equation)
		);
	}

	public static function interpolatef(a : Hsl, b : Hsl, ?equation : Float -> Float) : Float -> Hsl
	{
		return function(t : Float) return new Hsl(
			t.interpolate(a.hue,		b.hue,			equation),
			t.interpolate(a.saturation,	b.saturation,	equation),
			t.interpolate(a.lightness,	b.lightness,	equation)
		);
	}
}