/**
 * ...
 * @author Franco Ponticelli
 */

package thx.math.scale;

import thx.color.Hsl;
import thx.color.Rgb;
import thx.color.Colors;

class Linears 
{
	static var _default_color = new Hsl(0, 0, 0);
	public static function forString()
	{
		return new LinearT<String>().interpolatef(Strings.interpolatef);
	}
	
	public static function forHsl()
	{
		return new LinearT<Hsl>().interpolatef(Hsl.interpolatef);
	}
	
	public static function forHslString()
	{
		return new LinearT<String>()
			.interpolatef(function(a : String, b : String, f : Float -> Float) : Float -> String {
				if (Strings.empty(a) || Strings.empty(b))
					return function(_) return "";
				var ca = Hsl.toHsl(Colors.parse(a)),
					cb = Hsl.toHsl(Colors.parse(b)),
					i = Hsl.interpolatef(ca, cb, f);
				return function(t) return i(t).toHslString();
			});
	}
	
	public static function forRgb()
	{
		return new LinearT<Rgb>().interpolatef(Rgb.interpolatef);
	}
	
	public static function forRgbString()
	{
		return new LinearT<String>()
			.interpolatef(function(a : String, b : String, f : Float -> Float) : Float -> String {
				if (Strings.empty(a) || Strings.empty(b))
					return function(_) return "";
				var ca = Colors.parse(a),
					cb = Colors.parse(b),
					i = Rgb.interpolatef(ca, cb, f);
				return function(t) return i(t).toRgbString();
			});
	}
}