package thx.xml;

class DocumentFormat
{
	public var nodeFormat : NodeFormat;
	public var stripComments : Bool;   
	public function new()
	{
		stripComments = false;
	}
	
	public function format(node : Xml)
	{
		return formatNode(node);
	}
	
	public function formatNode(node : Xml)
	{
		var t = node.nodeType;
		if(Xml.Element == t)
		{
			return formatElement(node);
		} else if(Xml.PCData == t) {
			return formatPCData(node);
		} else if(Xml.CData == t) {
            return formatCData(node);
		} else if(Xml.Document == t) {
			return formatDocument(node);
		} else if(Xml.DocType == t) {
            return formatDocType(node);
		} else if(Xml.ProcessingInstruction == t) {
            return formatProlog(node);
	    } else if(Xml.Comment == t) {
            return formatComment(node);
	    } else {
			return throw "invalid node type: " + Std.string(t);
		}
	}
	
	function formatElement(node : Xml)
	{
		if(isEmpty(node))
		{
			return formatEmptyElement(node);
		} else {
			return 
				  formatOpenElement(node)
				+ formatChildren(node)
				+ formatCloseElement(node);
		}
	}
	
	function formatEmptyElement(node : Xml)
	{
		return nodeFormat.formatEmptyElement(node);
	}
	
	function formatOpenElement(node : Xml)
	{
		return nodeFormat.formatOpenElement(node);
	}
	
	function formatCloseElement(node : Xml)
	{
		return nodeFormat.formatCloseElement(node);
	}
	
	function formatChildren(node : Xml)
	{
		var buf = new StringBuf();
	   	for(child in node)
			buf.add(formatNode(child));		
		return buf.toString();
	}
	
	function formatPCData(node : Xml)
	{
		return nodeFormat.formatPCData(node);
	}
	
	function formatCData(node : Xml)
	{
		return nodeFormat.formatCData(node);
	}
	
	function formatDocument(node : Xml)
	{
		return formatChildren(node);
	}
	
	function formatDocType(node : Xml)
	{
		return nodeFormat.formatDocType(node);
	}
	
	function formatProlog(node : Xml)
	{
		return nodeFormat.formatProlog(node);
	}
	
	function formatComment(node : Xml)
	{
		if(stripComments)
			return "";
		else
			return nodeFormat.formatComment(node);
	}
	
	function isEmpty(node : Xml)
	{
		return !node.iterator().hasNext();
	}
/*	
	function formatIndent()
	{
		if(autoformat)
			return indent.repeat(_level);
		else
			return "";
	}

	function formatNewline()
	{
		if(autoformat)
			return newline;
		else 
			return "";
	}

	function formatNewlineIndent()
	{
		return
			  formatIndent()
			+ formatNewline();
	}
	
	function formatStart()
	{
		if(_started)
			return newline;
		_started = false;
		return "";
	}
*/
}