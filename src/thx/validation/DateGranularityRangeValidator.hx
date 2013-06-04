package thx.validation;

#if uform
import uform.util.DateGranularity;
import thx.util.Result;
import uform.model.value.DateType;
using thx.util.Results;

/**
 * ...
 * @author Franco Ponticelli
 */

class DateGranularityRangeValidator extends Validator<Date>
{
	public var granularity : DateGranularity;
	public var min : Null<Date>;
	public var max : Null<Date>;
	public var minInclusive : Bool;
	public var maxInclusive : Bool;
	
	public function new(granularity : DateGranularity, ?min : Date, ?max : Date, mininclusive = true, maxinclusive = true)
	{
		this.granularity = granularity;
		this.min = min;
		this.max = max;
		this.minInclusive = mininclusive;
		this.maxInclusive = maxinclusive;
	}

	override public function validate(value : Date) : Result
	{
		if (null != min)
		{
			if (minInclusive && comparable(value, granularity) < comparable(min, granularity))
			{
				return ("value must be at least {0:C," + DateType.format(granularity) + "}").failure([min]);
			} else if (!minInclusive && comparable(value, granularity) <= comparable(min, granularity))
			{
				return ("value must be greater than {0:C," + DateType.format(granularity) + "}").failure([min]);
			}
		}
		if (null != max)
		{
			if (maxInclusive && comparable(value, granularity) > comparable(max, granularity))
			{
				return ("value can't be greater than than {0:C," + DateType.format(granularity) + "}").failure([max]);
			} else if (!maxInclusive && comparable(value, granularity) >= comparable(max, granularity))
			{
				var f = DateType.format(granularity);
				return ("value must be lower than {0:C," + DateType.format(granularity) + "}").failure([max]);
			}
		}
		return Ok;
	}
	
	function comparable(date : Date, granularity) : Float
	{
		switch(granularity)
		{
			case Year:
				return date.getFullYear();
			case Month:
				return date.getFullYear() + date.getMonth() / 100;
			case Day:
				return date.getFullYear() + date.getMonth() / 100 + date.getDay() / 10000;
			case Hour:
				return date.getFullYear() + date.getMonth() / 100 + date.getDay() / 10000 + date.getHours() / 1000000;
			case Minute:
				return date.getFullYear() + date.getMonth() / 100 + date.getDay() / 10000 + date.getHours() / 1000000 + date.getMinutes() / 100000000.0;
			case Second:
				return date.getFullYear() + date.getMonth() / 100 + date.getDay() / 10000 + date.getHours() / 1000000 + date.getMinutes() / 100000000.0 + date.getSeconds() / 10000000000.0;
		}
	}
}
#end