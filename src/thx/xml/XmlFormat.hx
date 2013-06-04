package thx.xml;

import Xml;

class XmlFormat
{
	public var indent : Null<String>;
	public var newline : Null<String>;
	public var stripComments : Null<Bool>;
	public var autoformat : Bool;
	public var normalizeNewlines : Bool;
	public var wrapColumns : Null<Int>;

	public function new(autoformat = true, ?indent : String, ?newline : String)
	{
		this.autoformat = autoformat;
		this.indent = indent;
		this.newline = newline;
		this.normalizeNewlines = true;
	}
	
	public function format(xml : Xml)
	{   
		var valueFormat     = createValueFormat();
		var attributeFormat = createAttributeFormat();
		var documentFormat  = createDocumentFormat();
		var nodeFormat      = createNodeFormat();
		
		documentFormat.nodeFormat  = nodeFormat;
		nodeFormat.valueFormat     = valueFormat;
		nodeFormat.attributeFormat = attributeFormat;
		
		return documentFormat.format(xml);
	}
	
	function createValueFormat() : ValueFormat
	{
		if(autoformat)
			return new NormalizeWhitespaceValueFormat();
		else if(normalizeNewlines)
		    return new NormalizeNewlineValueFormat(newline);
		else
			return new ValueFormat();
	}
	
	function createAttributeFormat() : AttributeFormat
	{
		return new AttributeFormat();
	}
	
	function createDocumentFormat() : DocumentFormat
	{
		var document : DocumentFormat;
		if(autoformat)
		{
			var doc = new AutoDocumentFormat();
		    if(null != indent)
		    	doc.indent = indent;
	  		if(null != newline)
				doc.newline = newline;
			if(null != wrapColumns)
				doc.wrapColumns = wrapColumns;
			document = doc;
		} else
			document = new DocumentFormat();
		if(null != stripComments)
			document.stripComments = stripComments;
		return document;
	}
	
	function createNodeFormat() : NodeFormat
	{
		return new NodeFormat();
	}
}