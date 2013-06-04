package thx.xml;
using StringTools;

class NormalizeWhitespaceValueFormat extends ValueFormat
{
	var _wsReplace : EReg;
	var _wsTestStart : EReg;
	var _wsTestEnd : EReg;
	public function new()
	{
		super();
		_wsReplace = ~/(\s|\n|\r)+/g;
	}
	
	override public function format(value : String)
	{
		var v = _wsReplace.replace(value, " ");
		if (v == " ")
			return "";
		else
			return v;
	}
}