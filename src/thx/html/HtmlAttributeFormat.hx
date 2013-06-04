package thx.html;

import thx.xml.AttributeFormat;

class HtmlAttributeFormat extends AttributeFormat
{
	override public function formatAttribute(name : String, value : String)
	{
		if(Attribute.isFill(name))
			return name;
		else
			return name + '="' + value + '"';
	}	
}