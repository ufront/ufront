package thx.html;
using Strings;
import thx.xml.DocumentFormat;

class HtmlDocumentFormat extends DocumentFormat
{
	public var indent : String;
	public var newline : String;
	public var wrapColumns : Int;
	public var specialElementContentFormat : SpecialElementContentFormat;

	var _level : Int;
	var _begin : Bool;

	public function new()
	{
		super();
		indent = "  ";
		newline = "\n";
		wrapColumns = 80;
		specialElementContentFormat = AsCommentedText;
		_level = 0;
		_begin = true;
	}
	
	function indentWrap(content : String)
	{
		if("" == content)
			return "";
		else
			return newline + content.wrapColumns(wrapColumns, indent.repeat(_level), newline);
	}
	
	override function format(node : Xml)
	{
		return super.format(node).ltrim(newline);
	}
	
	override function isEmpty(node : Xml)
	{
		return Element.isEmpty(node.nodeName);
	}
	
	public function formatInlineNode(node : Xml)
	{
		var t = node.nodeType;
		if(Xml.Element == t)
		{
			return formatInlineElement(node);
		} else if(Xml.PCData == t) {
			return formatInlinePCData(node);
		} else if(Xml.CData == t) {
            return formatInlineCData(node);
	    } else if(Xml.Comment == t) {
            return formatInlineComment(node);
	    } else {
			return throw "invalid node type: " + Std.string(t);
		}
	}
	
	function formatInlineElement(node : Xml)
	{
		if(isEmpty(node))
		{
			return formatInlineEmptyElement(node);
		} else {
			return
				  formatInlineOpenElement(node)
				+ formatInlineChildren(node)
				+ formatInlineCloseElement(node);
		}
	}
	
	function contentIsEmpty(node : Xml)
	{
		for (c in node)
		{
			if (c.nodeType != Xml.PCData || StringTools.trim(c.nodeValue) != "")
				return false;
		}
		return true;
	}
	
	function formatSpecialElement(node : Xml)
	{
		if (contentIsEmpty(node))
		{
			return indentWrap(formatInlineOpenElement(node) + formatInlineCloseElement(node));
		} else {
			return formatOpenElement(node) + wrapSpecialElementContent(formatChildren(node)) + formatCloseElement(node);
		}
	}
	
	function wrapSpecialElementContent(content : String)
	{
		switch(specialElementContentFormat)
		{
			case AsPlainText:
				return content;
			case AsCData:
				return "<![CDATA[" + newline + content + newline + "]]>";
			case AsCommentedText:
				return "<!--" + newline + content + newline + "// -->";
		}
	}
	
	override function formatElement(node : Xml)
	{
		if (Element.isSpecial(node.nodeName)) {
			return formatSpecialElement(node);
		} else if (Element.shouldPreserve(node.nodeName))
		{
			var open = formatOpenElement(node);
			var content = "";
			for (child in node)
				content += child.toString();
			var close = formatInlineCloseElement(node);
			return open + content + close;
		} else if(isEmpty(node))
		{
			if(Element.isInline(node.nodeName))
				return formatInlineEmptyElement(node);
			else
				return formatEmptyElement(node);
		} else {
			if (Element.isBlock(node.nodeName) && inlineContent(node)){
				var open    = formatInlineOpenElement(node);
				var content = formatInlineChildren(node);
				var close   = formatInlineCloseElement(node);
				
				if(indent.length * _level + open.length + content.length + close.length <= wrapColumns)
					return indentWrap(open + content + close);
				else
				{
					_level++;
					content = indentWrap(content);
					_level--;
					return
						  indentWrap(open)
						+ content
						+ indentWrap(close);
				}
			} else if(Element.isInline(node.nodeName)) {
				return
					  formatInlineOpenElement(node)
					+ formatInlineChildren(node)
					+ formatInlineCloseElement(node);
			} else {
				return
					  formatOpenElement(node)
					+ formatChildren(node)
					+ formatCloseElement(node);
			}
		}
	}
	
	function inlineContent(node : Xml)
	{
		for(child in node)
		{
			if(child.nodeType == Xml.PCData || (child.nodeType == Xml.Element && Element.isInline(child.nodeName)))
				continue;
			return false;
		}
		return true;
	}
	
	override function formatChildren(node : Xml)
	{
		_level++;
		var content = super.formatChildren(node);
		_level--;
		return content;
	}
	
	function formatInlineChildren(node : Xml)
	{
		var buf = new StringBuf();
	   	for(child in node)
			buf.add(formatInlineNode(child));
		return buf.toString();
	}
	
	override function formatDocType(node : Xml)
	{
		return indentWrap(super.formatDocType(node));
	}

	override function formatProlog(node : Xml)
	{
		return indentWrap(super.formatProlog(node));
	}
	
	override function formatComment(node : Xml)
	{
		if(stripComments)
			return "";
		else
			return indentWrap(nodeFormat.formatComment(node));
	}
	
	function formatInlineComment(node : Xml)
	{
		if(stripComments)
			return "";
		else
			return nodeFormat.formatComment(node);
	}
	
	override function formatEmptyElement(node : Xml)
	{
		return indentWrap(super.formatEmptyElement(node));
	}
	
	override function formatOpenElement(node : Xml)
	{
		return indentWrap(super.formatOpenElement(node));
	}
	
	override function formatCloseElement(node : Xml)
	{
		return indentWrap(super.formatCloseElement(node));
	}
	
	function formatInlineEmptyElement(node : Xml)
	{
		return super.formatEmptyElement(node);
	}
	
	function formatInlineOpenElement(node : Xml)
	{
		return super.formatOpenElement(node);
	}
	
	function formatInlineCloseElement(node : Xml)
	{
		return super.formatCloseElement(node);
	}
	
	override function formatDocument(node : Xml)
	{
		return super.formatChildren(node);
	}

	override function formatPCData(node : Xml)
	{
		return indentWrap(super.formatPCData(node));
	}

	override function formatCData(node : Xml)
	{
		return indentWrap(super.formatCData(node));
	}
	
	function formatInlinePCData(node : Xml)
	{
		return super.formatPCData(node);
	}

	function formatInlineCData(node : Xml)
	{
		return super.formatCData(node);
	}
}

enum SpecialElementContentFormat
{
	AsPlainText;
	AsCData;
	AsCommentedText;
}