package thx.html;

import thx.xml.NodeFormat;

class HtmlNodeFormat extends NodeFormat
{
	override public function formatEmptyElement(node : Xml)
	{
		return
			  "<" 
			+ node.nodeName
			+ attributeFormat.formatAttributes(node)
			+ ">";
	}
}