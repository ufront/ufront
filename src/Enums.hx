/**
 * ...
 * @author Franco Ponticelli
 */

class Enums
{
	public static function string(e : Dynamic)
	{
		var cons = Type.enumConstructor(e);
		var params = [];
		for (param in Type.enumParameters(e))
			params.push(Dynamics.string(param));
		return cons + (params.length == 0 ? "" : "(" + params.join(", ") + ")");
	}
	
	public static function compare(a : Dynamic, b : Dynamic)
	{
		var v;
		if ((v = Ints.compare(Type.enumIndex(a), Type.enumIndex(b))) != 0)
			return v;
		return Arrays.compare(Type.enumParameters(a), Type.enumParameters(b));
	}
}