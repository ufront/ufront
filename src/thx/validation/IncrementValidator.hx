/**
 * ...
 * @author Franco Ponticelli
 */

package thx.validation;
using thx.util.Results;
import thx.error.Error;
import thx.util.Result;

class IncrementValidator extends Validator<Float>
{
	public var increment : Float;
	public function new(increment : Float)
	{
		if (0 == increment)
			throw new Error("increment must be different from zero (0)");
		this.increment = increment;
	}
	
	override public function validate(value : Float)
	{
		var test = value / increment;
		if (test == Std.int(test))
		{
			return Ok;
		} else {
			return "value must be an increment of {0}".failure([increment]);
		}
	}
}