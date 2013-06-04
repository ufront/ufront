/**
 * ...
 * @author Franco Ponticelli
 */

package thx.svg;
import thx.svg.LineInterpolator;

class LineInterpolators
{
	public static function parse(s : String, sep = ":")
	{

		var interp = s.split(sep)[0].toLowerCase();
		return switch(interp)
		{
			case "basis":
				LineInterpolator.Basis;
			case "basisopen":
				LineInterpolator.BasisOpen;
			case "basisclosed":
				LineInterpolator.BasisClosed;
			case "cardinal":
				LineInterpolator.Cardinal(argument(s, sep));
			case "cardinalopen":
				LineInterpolator.CardinalOpen(argument(s, sep));
			case "cardinalclosed":
				LineInterpolator.CardinalClosed(argument(s, sep));
			case "monotone":
				LineInterpolator.Monotone;
			case "step":
				LineInterpolator.Step;
			case "stepafter":
				LineInterpolator.StepAfter;
			case "stepbefore":
				LineInterpolator.StepBefore;
			// case "linear":
			default:
				Linear;
		}
	}

	static function argument(s : String, sep : String) : Null<Float>
	{
		var v = s.split(sep)[1];
		if (null == v)
			return null;
		else
			return Std.parseFloat(v);
	}
}