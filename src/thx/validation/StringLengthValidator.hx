package thx.validation;

/**
 * ...
 * @author Franco Ponticelli
 */
import thx.util.Result;
//import thx.error.Error;
using thx.util.Results;

class StringLengthValidator extends Validator<String>
{
	public var minLength : Int;
	public var maxLength : Null<Int>;
	public function new(minlength = 0, ?maxlength : Int)
	{
		minLength = minlength;
		maxLength = maxlength;
	}
	
	override public function validate(value : String)
	{
		if (value.length < minLength)
		{
			return "value must be at least {0} character(s) long".failure([minLength]);
		} else if (null != maxLength && value.length > maxLength)
		{
			return "value should be shorter than {0} character(s)".failure([maxLength]);
		} else {
			return Ok;
		}
	}
}