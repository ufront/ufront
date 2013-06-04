package thx.validation;

/**
 * ...
 * @author Franco Ponticelli
 */

import thx.util.Result;
using thx.util.Results;

class EmailValidator extends Validator<String>
{
	static var _reEmail = new EReg('^(?:[a-z0-9!#$%&\'*+/=?^_`{|}~-]+(?:\\.[a-z0-9!#$%&\'*+/=?^_`{|}~-]+)*|"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])$', 'i');
	static var _reEmailDomain = new EReg('\\.(?:[A-Z]{2}|com|org|net|edu|gov|mil|biz|info|mobi|name|aero|asia|jobs|museum)$', 'i');
	
	public var validateDomain : Bool;
	public function new(validatedomain = true)
	{
		this.validateDomain = validatedomain;
	}
	
	override public function validate(value : String)
	{
		if (!_reEmail.match(value))
			return "invalid email address '{0}'".failure([value]);
		if (validateDomain && !_reEmailDomain.match(value))
			return "invalid domain for '{0}'".failure([value]);
		return Ok;
	}
}