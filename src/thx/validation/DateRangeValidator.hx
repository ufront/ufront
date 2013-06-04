/**
 * ...
 * @author Franco Ponticelli
 */

package thx.validation;
import thx.util.Result;
using thx.util.Results;

class DateRangeValidator extends Validator<Date>
{
	public var min : Null<Date>;
	public var max : Null<Date>;
	public var minInclusive : Bool;
	public var maxInclusive : Bool;
	
	public function new(?min : Date, ?max : Date, mininclusive = true, maxinclusive = true)
	{
		this.min = min;
		this.max = max;
		this.minInclusive = mininclusive;
		this.maxInclusive = maxinclusive;
	}
	
	override public function validate(value : Date)
	{
		if (null != min && ((minInclusive && value.getTime() < min.getTime()) || (!minInclusive && value.getTime() <= min.getTime())))
		{
			if (minInclusive)
				return "value must be at least {0:D}".failure([min]);
			else
				return "value must be greater than {0:D}".failure([min]);
		} else if (null != max && ((maxInclusive && value.getTime() > max.getTime()) || (!maxInclusive && value.getTime() >= max.getTime())))
		{
			if (maxInclusive)
				return "value must be at no more than {0:D}".failure([max]);
			else
				return "value must be lower than {0:D}".failure([max]);
		} else {
			return Ok;
		}
	}
}