package thx.xml;

class AttributeFormat
{
	public function new(){}
	
	public function formatAttributes(node : Xml)
	{
		var buf = new StringBuf();
		for(name in node.attributes())
		{
			buf.add(" ");
			buf.add(formatAttribute(name, node.get(name)));
		}
		return buf.toString();
	}
	
	public function formatAttribute(name : String, value : String)
	{
		return name + '="' + value + '"';
	}
}