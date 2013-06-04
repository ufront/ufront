/**
 * ...
 * @author Franco Ponticelli
 */

package thx.color;

using Floats;
using thx.math.Equations;

class Cmyk extends Rgb
{
	public var black(default, null): Float;
	public var cyan(default, null): Float;
	public var magenta(default, null): Float;
	public var yellow(default, null): Float;

	/**
	 * Construct a Cmyk Color.
	 * @param cyan		Float bewteen 0 and 1
	 * @param magenta	Float bewteen 0 and 1
	 * @param yellow	Float bewteen 0 and 1
	 * @param black		Float bewteen 0 and 1
	 */
	public function new( cyan: Float, magenta: Float, yellow: Float, black: Float )
	{
		super(
			Ints.interpolate(( 1 - cyan    - black ).normalize(), 0, 255),
			Ints.interpolate(( 1 - magenta - black ).normalize(), 0, 255),
			Ints.interpolate(( 1 - yellow  - black ).normalize(), 0, 255)
		);
		this.cyan    = cyan.normalize();
		this.magenta = magenta.normalize();
		this.yellow  = yellow.normalize();
		this.black   = black.normalize();
	}

	public function toCmykString()
	{
		return "cmyk(" + cyan + "," + magenta + "," + yellow + "," + black + ")";
	}

	public static function toCmyk(rgb : Rgb)
	{
		var c = 0.0, y = 0.0, m = 0.0, k;
		if (rgb.red + rgb.blue + rgb.green == 0)
		{
			k = 1.0;
		} else {
			c = 1 - (rgb.red / 255);
			m = 1 - (rgb.green / 255);
			y = 1 - (rgb.blue / 255);
			k = c.min(m).min(y);
			c = (c - k) / (1 - k);
			m = (m - k) / (1 - k);
			y = (y - k) / (1 - k);
		}
		return new Cmyk(c, m, y, k);
	}

	public static function equals(a : Cmyk, b : Cmyk)
	{
		return a.black == b.black && a.cyan == b.cyan && a.magenta == b.magenta && a.yellow == b.yellow;
	}

	public static function darker(color : Cmyk, t : Float, ?equation : Float -> Float) : Cmyk
	{
		return new Cmyk(
			color.cyan,
			color.magenta,
			color.yellow,
			Floats.interpolate(t, color.black, 0, equation)
		);
	}

	public static function lighter(color : Cmyk, t : Float, ?equation : Float -> Float) : Cmyk
	{
		return new Cmyk(
			color.cyan,
			color.magenta,
			color.yellow,
			Floats.interpolate(t, color.black, 1, equation)
		);
	}

	public static function interpolate(a : Cmyk, b : Cmyk, t : Float, ?equation : Float -> Float) : Cmyk
	{
		return new Cmyk(
			t.interpolate(a.cyan,    b.cyan, equation),
			t.interpolate(a.magenta, b.magenta, equation),
			t.interpolate(a.yellow,  b.yellow, equation),
			t.interpolate(a.black,   b.black, equation)
		);
	}
}