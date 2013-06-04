package thx.validation;
import thx.util.Result;
import thx.util.Message;

/**
 * ...
 * @author Franco Ponticelli
 */

class CustomValidator<T> extends Validator<T>
{
	var validators : Array<T -> Message>;
	public function new()
	{
		validators = [];
	}
	
	override public function validate(value : T) : Result
	{
		for (validator in validators)
		{
			var message = validator(value);
			if (null != message)
				return Failure([message]);
		}
		return Ok;
	}
	
	public function add(handler : T -> Message)
	{
		validators.push(handler);
	}
	
	public function clear()
	{
		validators = [];
	}
}