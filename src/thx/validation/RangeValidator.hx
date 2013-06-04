package thx.validation;

/**
 * ...
 * @author Franco Ponticelli
 */

using thx.util.Results;
import thx.util.Result;

class RangeValidator<T : Float> extends Validator<T>
{
	public var min : Null<Float>;
	public var max : Null<Float>;
	public var minInclusive : Bool;
	public var maxInclusive : Bool;
	
	public function new(?min : Float, ?max : Float, mininclusive = true, maxinclusive = true)
	{
		this.min = min;
		this.max = max;
		this.minInclusive = mininclusive;
		this.maxInclusive = maxinclusive;
	}
	
	override public function validate(value : T)
	{
		if (null != min && ((minInclusive && value < min) || (!minInclusive && value <= min)))
		{
			if (minInclusive)
				return "value must be at least {0}".failure([min]);
			else
				return "value must be greater than {0}".failure([min]);
		} else if (null != max && ((maxInclusive && value > max) || (!maxInclusive && value >= max)))
		{
			if (maxInclusive)
				return "value must be at no more than {0}".failure([max]);
			else
				return "value must be lower than {0}".failure([max]);
		} else {
			return Ok;
		}
	}
}