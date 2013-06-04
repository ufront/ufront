/**
 * ...
 * @author Franco Ponticelli
 */

package thx.validation;
import thx.util.Result;
using thx.util.Results;

class SingleLineValidator extends Validator<String>
{
	static var _re = ~/(\n|\r)/m;
	public function new(){}
	
	override public function validate(value : String)
	{
		if (_re.match(value))
		{
			return "value contains one ore more line breaks".failure([]);
		} else {
			return Ok;
		}
	}
}