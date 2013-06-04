package thx.xml;

class NormalizeNewlineValueFormat extends ValueFormat
{   
	var _newLineReplace : EReg;
	var _newline : String;
	public function new(newline = "\n")
	{   
		super();
		_newline = newline;
		_newLineReplace = ~/(\r\n|\n\r|\n|\r)/m;
	}
	
	override public function format(value : String)
	{
		return _newLineReplace.replace(value, _newline);
	}
}