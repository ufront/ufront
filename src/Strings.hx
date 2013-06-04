/**
 * ...
 * @author Franco Ponticelli
 */

import thx.culture.Culture;
import EReg;
import thx.error.Error;
import thx.culture.FormatParams;
using StringTools;
using Arrays;

class Strings
{
	static var _re = new EReg("[{](\\d+)(?::[^}]*)?[}]", "m");
	static var _reSplitWC = ~/(\r\n|\n\r|\n|\r)/g;
	static var _reReduceWS = ~/\s+/;
#if !php
	static var _reStripTags = ~/(<[a-z]+[^>\/]*\/?>|<\/[a-z]+>)/i;
#end

	static var _reFormat = ~/{(\d+)(?::([a-zA-Z]+))?(?:,([^"',}]+|'[^']+'|"[^"]+"))?(?:,([^"',}]+|'[^']+'|"[^"]+"))?(?:,([^"',}]+|'[^']+'|"[^"]+"))?}/m;
	/**
	* Take a string pattern and replaces the placeholders with the value contained in values.
	* The culture parameter is needed for proper localization of numeric and date values.
	* Placeholders follows this schema:
<pre>
{pos[:format][,param]*}
</pre>
	* <em>pos</em> is the position in the array
	* <em>format</em> is a string sequence that identifies a specific value format (see below)
	* <em>param</em> is one or more optional parameters specific to certain format values.
	*
	* <pre>
Numeric Formats
---------------
D (default) Decimal format. The default number of decimals is set by culture. This value can overriden
            using the length parameter.
I           Integer format.
C           Currency format. The default number of decimals is set by culture. This value can overriden
            using the length parameter. The symbol can be overridden appending a string value after C
			Ei. "{0:C,3,USD}" will print something like "USD2.000" instead of "$2.00"
P           Percent format.
M           Permille format.

Date Formats
---------------
D (default) Date format.
DS          Short Date format.
DST         Short date / long time format.
DSTS        Short date / short time format.
DT          Long date / long time format.
DTS         Long date / short time format.
Y           Year format.
YM          Year Month format.
M           Month format.
MN          Month name format.
MS          Short Month name format.
MD          Month Day format.
WD          Week day format.
WDN         Week day name format.
WDS         Short week day name format.
R           RFC Date format.
DT          Date Time format.
U           Universal format.
S           Sortable format.
T           Time format.
TS          Short Time format.
C			Custom, second parameter is the format as described in FormatDate

Boolean Formats
---------------
B			Normal bool (true, false)
N			Numeric representation (1, 0)
R			Replace values with first parameter for true and second for false

String Formats
---------------
S			Normal text.
T           Truncate. First parameter is the length to trim, second is the ellipsis
			(optional parameter, defaults to '...')
PL          Pad left. First parameter is the length, second is filling char
			(optional parameter, defaults to ' ')
PR          Pad right. First parameter is the length, second is filling char
			(optional parameter, defaults to ' ')

List Formats
---------------
J           Joins the elements of the list.
			The first parameter is the format for individual items
			The second parameter is what is shown when the list is empty (defaults to '[]')
			The third is the separator.
            The fourth is the maximum number of values to show (default to nolimit).
			The fifth parameter the ellipsis for not included values (defaults to '...'),
C			Counts the elements in the list

Object Formats
----------------
O			Uses the Std.string function
R			Uses the Reflects.string function for each field value

TODO:
List Formats
---------------
C           Concats the elements of the list

Other things to do. Nested placeholders
</pre>
	*/
	public static function format(pattern : String, values : Array<Dynamic>, nullstring = 'null', ?culture : Culture) {
		if (null == values || 0 == values.length)
			return pattern;
		return formatf(pattern, nullstring, culture)(values);
	}

	public static function formatf(pattern : String, nullstring = 'null', ?culture : Culture)
	{
		var buf = [];
		while (true)
		{
			if (!_reFormat.match(pattern))
			{
				buf.push(function(_) return pattern);
				break;
			}

			var pos = Std.parseInt(_reFormat.matched(1));
			var format = _reFormat.matched(2);
			if (format == '') // '' is for IE
				format = null;
			var p = null;
			var params = [];
			for (i in 3...20) // 20 is a guard limit, 5 is probably more than enough
			{
				p = _reFormat.matched(i);
				if(p == null || p == '') // again IE
					break;
				params.push(FormatParams.cleanQuotes(p));
			}
			var left = _reFormat.matchedLeft();
			buf.push(function(_) return left);
			var df = Dynamics.formatf(format, params, nullstring, culture);
#if haxe3
			buf.push((function(i : Int, v : Array<Dynamic>) return df(v[i])).bind(pos));
#else
			buf.push(callback(function(i : Int, v : Array<Dynamic>) return df(v[i]), pos));
#end
			pattern = _reFormat.matchedRight();
		}
		return function(values : Array<Dynamic>)
		{
			if (null == values)
				values = [];
			return buf.map(function(df) return df(values)).join("");
		}
	}

	public static function formatOne(v : String, ?param : String, ?params : Array<String>, ?culture : Culture)
	{
		return formatOnef(param, params, culture)(v);
	}

	public static function formatOnef(?param : String, ?params : Array<String>, ?culture : Culture)
	{
		params = FormatParams.params(param, params, 'S');
		var format = params.shift();
		switch(format)
		{
			case 'S':
				return function(v : String) return v;
			case 'T':
				var len = params.length < 1 ? 20 : Std.parseInt(params[0]);
				var ellipsis = params.length < 2 ? "..." : params[1];
				return ellipsisf(len, ellipsis);
			case 'PR':
				var len = params.length < 1 ? 10 : Std.parseInt(params[0]);
				var pad = params.length < 2 ? " " : params[1];
				return function(v : String) return StringTools.rpad(v, pad, len);
			case 'PL':
				var len = params.length < 1 ? 10 : Std.parseInt(params[0]);
				var pad = params.length < 2 ? " " : params[1];
				return function(v : String) return StringTools.lpad(v, pad, len);
			default:
				return throw "Unsupported string format: " + format;
		}
	}

	// TODO, test me
	public static function upTo(value : String, searchFor : String)
	{
		var pos = value.indexOf(searchFor);
		if (pos < 0)
			return value;
		else
			return value.substr(0, pos);
	}

	// TODO, test me
	public static function startFrom(value : String, searchFor : String)
	{
		var pos = value.indexOf(searchFor);
		if (pos < 0)
			return value;
		else
			return value.substr(pos + searchFor.length);
	}

	// TODO, test me
	public static function rtrim(value : String, charlist : String) : String
	{
#if php
		return untyped __call__("rtrim", value, charlist);
#else
		var len = value.length;
		while (len > 0)
		{
			var c = value.substr(len - 1, 1);
			if (charlist.indexOf(c) < 0)
				break;
			len--;
		}
		return value.substr(0, len);
#end
	}

	// TODO, test me
	public static function ltrim(value : String, charlist : String) : String
	{
#if php
		return untyped __call__("ltrim", value, charlist);
#else
		var start = 0;
		while (start < value.length)
		{
			var c = value.substr(start, 1);
			if (charlist.indexOf(c) < 0)
				break;
			start++;
		}
		return value.substr(start);
#end
	}

	public static inline function trim(value : String, charlist : String) : String
	{
#if php
		return untyped __call__("trim", value, charlist);
#else
		return rtrim(ltrim(value, charlist), charlist);
#end
	}

	static var _reCollapse = ~/\s+/g;
	public static function collapse(value : String)
	{
		return _reCollapse.replace(StringTools.trim(value), " ");
	}

	public static inline function ucfirst(value : String) : String
	{
		return (value == null ? null : value.charAt(0).toUpperCase() + value.substr(1));
	}

	public static inline function lcfirst(value : String) : String
	{
		return (value == null ? null : value.charAt(0).toLowerCase() + value.substr(1));
	}

	public static function empty(value : String)
	{
		return value == null || value == '';
	}

	public static inline function isAlphaNum(value : String) : Bool
	{
#if php
		return untyped __call__("ctype_alnum", value);
#else
		return (value == null ? false : __alphaNumPattern.match(value));
#end
	}

	public static inline function digitsOnly(value : String) : Bool
	{
#if php
		return untyped __call__("ctype_digit", value);
#else
		return (value == null ? false : __digitsPattern.match(value));
#end
	}

	public static function ucwords(value : String) : String
	{
		return __ucwordsPattern.map(ucfirst(value), __upperMatch);
	}

	/**
	 * Like ucwords but uses only white spaces as boundaries
	 * @param	value
	 * @return
	 */
	public static function ucwordsws(value : String) : String
	{
#if php
		return untyped __call__("ucwords", value);
#else
		return __ucwordswsPattern.map(ucfirst(value), __upperMatch);
#end
	}

	static function __upperMatch(re : EReg)
	{
		return re.matched(0).toUpperCase();
	}
	static var __ucwordsPattern = new EReg('[^a-zA-Z]([a-z])', 'g');
#if !php
	static var __ucwordswsPattern = new EReg('\\s([a-z])', 'g');
	static var __alphaNumPattern = new EReg('^[a-z0-9]+$', 'i');
	static var __digitsPattern = new EReg('^[0-9]+$', '');
#end

	/**
	*  Replaces undescores with space, finds UC characters, turns them into LC and prepends them with a space.
	*  More than one UC in sequence is left untouched.
	**/
	public static function humanize(s : String)
	{
		return underscore(s).replace('_', ' ');
	}

	// TO TEST
	public static function capitalize(s : String)
	{
		return s.substr(0, 1).toUpperCase() + s.substr(1);
	}

	// TO TEST
	public static function succ(s : String)
	{
		return s.substr(0, -1) + String.fromCharCode(s.substr(-1).charCodeAt(0)+1);
	}

	// TO TEST
	public static function underscore(s : String)
	{
		s = (~/::/g).replace(s, '/');
		s =	(~/([A-Z]+)([A-Z][a-z])/g).replace(s, '$1_$2');
		s = (~/([a-z\d])([A-Z])/g).replace(s, '$1_$2');
		s = (~/-/g).replace(s, '_');
		return s.toLowerCase();
	}

	public static function dasherize(s : String)
	{
		return s.replace('_', '-');
	}

	public static function repeat(s : String, times : Int)
	{
		var b = [];
		for(i in 0...times)
			b.push(s);
		return b.join('');
	}

	public static function wrapColumns(s : String, columns = 78, indent = "", newline = "\n")
	{
		var parts = _reSplitWC.split(s);
		var result = [];
		for(part in parts)
		{
			result.push(_wrapColumns(StringTools.trim(_reReduceWS.replace(part, " ")), columns, indent, newline));
		}
		return result.join(newline);
	}

	static function _wrapColumns(s : String, columns : Int, indent : String, newline : String)
	{
		var parts = [];
		var pos = 0;
		var len = s.length;
		var ilen = indent.length;
		columns -= ilen;
		while(true)
		{
			if(pos + columns >= len - ilen)
			{
				parts.push(s.substr(pos));
				break;
			}

			var i = 0;
			while(!StringTools.isSpace(s, pos + columns - i) && i < columns)
			{
				i++;
			}
			if(i == columns)
			{
				// search ahead
				i = 0;
				while(!StringTools.isSpace(s, pos + columns + i) && pos + columns + i < len)
				{
					i++;
				}
				parts.push(s.substr(pos, columns + i));
				pos += columns + i + 1;
			} else {
				parts.push(s.substr(pos, columns - i));
				pos += columns - i + 1;
			}
		}

		return indent + parts.join(newline + indent);
	}

	public static function stripTags(s : String) : String
	{
#if php
		return untyped __call__("strip_tags", s);
#else
		return _reStripTags.replace(s, "");
#end
	}

	static var _reInterpolateNumber = ~/[-+]?(?:\d+\.\d+|\d+\.|\.\d+|\d+)(?:[eE][-]?\d+)?/;
	public static function interpolate(v : Float, a : String, b : String, ?equation : Float -> Float)
	{
		return interpolatef(a, b, equation)(v);
	}

	public static function interpolatef(a : String, b : String, ?equation : Float -> Float)
	{
		function extract(value : String, s : Array<String>, f : Array<Null<Float>>)
		{
			while (_reInterpolateNumber.match(value))
			{
				var left = _reInterpolateNumber.matchedLeft();
				if (!Strings.empty(left))
				{
					s.push(left);
					f.push(null);
				}
				s.push(null);
				f.push(Std.parseFloat(_reInterpolateNumber.matched(0)));
				value = _reInterpolateNumber.matchedRight();
			}
			if (!Strings.empty(value))
			{
				s.push(value);
				f.push(null);
			}
		}
		function decimals(v : Float)
		{
			var s = ""+v,
				p = s.indexOf('.');
			if(p < 0)
				return 0;
			return s.length - p - 1;
		}
		var sa = [],
			fa = [],
			sb = [],
			fb = [];
		extract(a, sa, fa);
		extract(b, sb, fb);

		var functions = [], i = 0;
		var min = Ints.min(sa.length, sb.length);
		while (i < min)
		{
			if (sa[i] != sb[i])
				break;
			if (null == sa[i])
			{
				if (fa[i] == fb[i]) // no need to interpolate
				{
					var s = "" + fa[i];
					functions.push(function(_) return s);
				} else {
					var f = Floats.interpolatef(fa[i], fb[i], equation);
					var dec = Math.pow(10, Ints.max(decimals(fa[i]), decimals(fb[i])));
					functions.push(function(t) return "" + Math.round(f(t)*dec)/dec);
				}
			} else {
				var s = sa[i];
				functions.push(function(_) return s);
			}
			i++;
		}
		var rest = "";
		while (i < sb.length)
		{
			if (null != sb[i])
				rest += sb[i];
			else
				rest += fb[i];
			i++;
		}
		if ("" != rest)
			functions.push(function(_) return rest);
		return function(t) {
			return Arrays.map(functions, function(f,_) return f(t)).join("");
		};
	}

	public static function interpolateChars(v : Float, a : String, b : String, ?equation : Float -> Float)
	{
		return interpolateCharsf(a, b, equation)(v);
	}

	public static function interpolateCharsf(a : String, b : String, ?equation : Float -> Float) : Float -> String
	{

		var aa = a.split(""),
			ab = b.split("");
		while (aa.length > ab.length)
			ab.insert(0, " ");
		while (ab.length > aa.length)
			aa.insert(0, " ");
		var ai = [];
		for (i in 0...aa.length)
			ai[i] = interpolateCharf(aa[i], ab[i]);
		return function(v)
		{
			var r = [];
			for (i in 0...ai.length)
				r[i] = ai[i](v);
			return StringTools.trim(r.join(""));
		}
	}

	public static function interpolateChar(v : Float, a : String, b : String, ?equation : Float -> Float)
	{
		return interpolateCharf(a, b, equation)(v);
	}

	public static function interpolateCharf(a : String, b : String, ?equation : Float -> Float) : Float -> String
	{
		if (~/^\d/.match(b) && a == ' ') a = '0';
		var r = ~/^[^a-zA-Z0-9]/;
		if (r.match(b) && a == ' ')  a = r.matched(0);
		var ca = a.charCodeAt(0),
			cb = b.charCodeAt(0),
			i = Ints.interpolatef(ca, cb, equation);
		return function(v) return String.fromCharCode(i(v));
	}

	public static function ellipsis(s : String, maxlen = 20, symbol = "...")
	{
		if (s.length > maxlen)
			return s.substr(0, Ints.max(symbol.length, maxlen - symbol.length)) + symbol;
		else
			return s;
	}

	public static function ellipsisf(maxlen = 20, symbol = "...")
	{
		return function(s : String)
		{
			if (s.length > maxlen)
				return s.substr(0, Ints.max(symbol.length, maxlen - symbol.length)) + symbol;
			else
				return s;
		}
	}

	public static function compare(a : String, b : String) return a < b ? -1 : a > b ? 1 : 0;
}