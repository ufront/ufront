/**
 * ...
 * @author Franco Ponticelli
 */

package thx.ini;

import thx.data.ValueEncoder;
import thx.data.ValueHandler;

class Ini
{
	public static function encode(value : {})
	{
		var handler = new IniEncoder();
		new ValueEncoder(handler).encode(value);
		return handler.encodedString;
	}

	public static function decode(value : String) : Dynamic
	{
		var handler = new ValueHandler();
		var r = new IniDecoder(handler);
		r.decode(value);
		return handler.value;
	}
}