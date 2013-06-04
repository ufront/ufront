package thx.text;

class ERegs
{
	static var _escapePattern = ~/[\*\+\?\|\{\[\(\)\^\$\.# \\]/g;
	public static function escapeERegChars(s : String)
	{
		if (_escapePattern.match(s))
			return _escapePattern.map(s, function(e : EReg) return "\\" + e.matched(0));
		else
			return s;
	}
}