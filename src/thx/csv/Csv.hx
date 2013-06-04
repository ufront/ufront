/**
 * ...
 * @author Franco Ponticelli
 */

package thx.csv;

import thx.culture.Culture;
import thx.data.ValueEncoder;
import thx.data.ValueHandler;

using Arrays;

class Csv
{
	public static function encode(value : Array<Array<Dynamic>>, ?delimiter : String, ?nulltoempty : Bool, ?newline : String)
	{
		var handler = new CsvEncoder(delimiter, nulltoempty, newline);
		new ValueEncoder(handler).encode(value);
		return handler.encodedString;
	}
/**
 *  Parses and decodes well structured csv data.
 **/
	public static function decode(value : String, ?check_type:Bool, ?delimiter : String,  ?emptytonull:Bool, ?newline: String, ?quote: String, ?doublequotations: Bool, ?skipwhitespace: Bool) : Array<Array<Dynamic>>
	{
		var handler = new ValueHandler();
		new CsvDecoder(handler, check_type, delimiter , emptytonull, newline, quote, doublequotations, skipwhitespace).decode(value);
		return handler.value;
	}

	public static function decodeObjects(value : String, ?check_type:Bool, ?delimiter : String,  ?emptytonull:Bool, ?newline: String, ?quote: String, ?doublequotations: Bool, ?skipwhitespace: Bool) : Array<Dynamic>
	{
		var values  = decode(value, check_type, delimiter,  emptytonull, newline, quote, doublequotations, skipwhitespace),
			headers = values.shift().map(function(v) return "" + v),
			len     = headers.length;
		return values.map(function(arr) {
			var ob : Dynamic = {};
			for(i in 0...len)
				Reflect.setField(ob, headers[i], arr[i]);
			return ob;
		});
	}
}