package thx.validation;
import thx.error.AbstractMethod;
import thx.util.Result;
/**
 * ...
 * @author Franco Ponticelli
 */

class Validator<T> implements IValidator<T>
{
	public function validate(value : T) : Result
	{
		return throw new AbstractMethod();
	}

	public function isValid(value : T) : Bool
	{
		return Type.enumEq(validate(value), Ok);
	}
}