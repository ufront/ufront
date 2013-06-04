package thx.html;

import thx.xml.NodeFormat;

class CloseSelfHtmlNodeFormat extends HtmlNodeFormat
{
	override public function formatCloseElement(node : Xml)
	{
		if(Element.isCloseSelf(node.nodeName))
			return "";
		else   
			return "</" + node.nodeName + ">";
	}
}