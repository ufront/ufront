package thx.xml;

using Strings;
import StringTools;

class AutoDocumentFormat extends DocumentFormat
{
	public var indent : String;
	public var newline : String;
	public var wrapColumns : Int;

	var _level : Int;
	var _begin : Bool;

	public function new()
	{
		super();
		indent = "  ";
		newline = "\n";
		wrapColumns = 80;
		_level = 0;
		_begin = true;
	}
	
	function indentWrap(content : String)
	{
		return newline + content.wrapColumns(wrapColumns, indent.repeat(_level), newline);
	}
	
	override function format(node : Xml)
	{
		return super.format(node).ltrim(newline);
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
	
	override function formatChildren(node : Xml)
	{
		_level++;
		var content = super.formatChildren(node);
		_level--;
		return content;
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
}