package thx.validation;

/**
 * ...
 * @author Franco Ponticelli
 */

import thx.util.Result;

interface IValidator<T>
{
	public function validate(value : T) : Result;
	public function isValid(value : T) : Bool;
}