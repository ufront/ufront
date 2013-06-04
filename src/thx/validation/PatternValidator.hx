package thx.validation;

import thx.util.Result;
using thx.util.Results;

/**
 * ...
 * @author Franco Ponticelli
 */

class PatternValidator extends Validator<String>
{
	public var pattern : EReg;
	public var failureMessage : String;
	public function new(pattern : EReg, ?failureMessage = "value doesn't match the required pattern")
	{
		this.pattern = pattern;
		this.failureMessage = failureMessage;
	}
	
	override public function validate(value : String)
	{
		if (pattern.match(value))
			return Ok;
		else
			return failureMessage.failure([]);
	}
}