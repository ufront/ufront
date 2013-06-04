package thx.culture;

/**
 * ...
 * @author Franco Ponticelli
 */

 using Arrays;

class FormatParams
{
	public static function cleanQuotes(p : String)
	{
		if (p.length <= 1)
			return p;
		var f = p.substr(0, 1);
		if (('"' == f || "'" == f) && p.substr( -1) == f)
			return p.substr(1, p.length - 2);
		else
			return p;
	}

	// TODO: add support for nested formats (usefull for Arrays.format)
	public static function params(p : String, ps : Array<String>, alt : String)
	{
		if (null != ps && null != p)
			return [p].concat(ps);
		if ((null == ps || ps.length == 0) && null == p)
			return [alt];
		if (null == ps || ps.length == 0)
		{
			var parts = p.split(":");
			return [parts[0]].concat(parts.length == 1 ? [] : Arrays.map(parts[1].split(","), function(s, i) if (0 == i) return s else return cleanQuotes(s)));
		}
		return ps;
	}
}