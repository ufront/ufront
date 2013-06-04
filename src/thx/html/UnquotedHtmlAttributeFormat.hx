package thx.html;

import thx.xml.AttributeFormat;

class UnquotedHtmlAttributeFormat extends AttributeFormat
{   
	var _containsWS : EReg;
	public function new()
	{
		super();
		_containsWS = ~/\s/m;
	}
	
	override public function formatAttribute(name : String, value : String)
	{
		if(Attribute.isFill(name))
			return name;
		else
			return name + '=' + quote(value);
	}
	
	function quote(value : String)
	{
		if ("" != value && !_containsWS.match(value))
			return value;
		else
			return '"' + value + '"';		
	}	
}