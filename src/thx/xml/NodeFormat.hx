package thx.xml;

class NodeFormat
{   
	public var valueFormat : ValueFormat;
	public var attributeFormat : AttributeFormat;    
	public function new(){}
	
	public function formatEmptyElement(node : Xml)
	{
		return
			  "<" 
			+ node.nodeName
			+ attributeFormat.formatAttributes(node)
			+ "/>";
	}
	
	public function formatOpenElement(node : Xml)
	{   
		return 
			  "<"
			+ node.nodeName
			+ attributeFormat.formatAttributes(node)
			+ ">";
	}
	
	public function formatCloseElement(node : Xml)
	{   
		return "</" + node.nodeName + ">";
	}

	public function formatPCData(node : Xml)
	{
		return valueFormat.format(node.nodeValue);
	}

	public function formatDocType(node : Xml)
	{   
		return "<!DOCTYPE " + valueFormat.format(node.nodeValue) + ">";
	}

	public function formatProlog(node : Xml)
	{
		return "<?" + valueFormat.format(node.nodeValue) + "?>";
	}

	public function formatComment(node : Xml)
	{
		return "<!--" + valueFormat.format(node.nodeValue) + "-->";
	}

	public function formatCData(node : Xml)
	{
		return "<![CDATA[" + valueFormat.format(node.nodeValue) + "]]>";
	}
}