package thx.validation;
using thx.util.Results;
import thx.util.Result;
/**
 * ...
 * @author Franco Ponticelli
 */

class UrlValidator extends Validator<String>
{
	static var _reUrl = new EReg('^(http|ftp|https)://[\\w\\-_]+(\\.[\\w\\-_]+)+([\\w\\-\\.,@?^=%&amp;:/~\\+#]*[\\w\\-\\@?^=%&amp;/~\\+#])?$', '');
	
	public function new() { }
	
	override public function validate(value : String)
	{
		if (!_reUrl.match(value))
			return "invalid url '{0}'".failure([value]);
		else
			return Ok;
	}
}