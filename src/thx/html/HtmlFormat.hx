package thx.html;
import thx.xml.NodeFormat;
import thx.xml.AttributeFormat;
import thx.xml.XmlFormat;
import thx.html.HtmlDocumentFormat;
using Types;

class HtmlFormat extends XHtmlFormat
{
	public var useCloseSelf : Bool;
	public var quotesRemoval : Bool;
	public var specialElementContentFormat : SpecialElementContentFormat;
	public function new()
	{
		super();
		useCloseSelf = false;
		quotesRemoval = false;
	}

	override function createAttributeFormat() : AttributeFormat
	{
		if(quotesRemoval)
		    return new UnquotedHtmlAttributeFormat();
		else
			return new HtmlAttributeFormat();
	}

	override function createNodeFormat() : NodeFormat
	{
		if(useCloseSelf)
		    return new CloseSelfHtmlNodeFormat();
		else
			return new HtmlNodeFormat();
	}

	override function createDocumentFormat()
	{
		var doc = super.createDocumentFormat();
		if (null == specialElementContentFormat)
			return doc;
		var html : HtmlDocumentFormat = doc.as(HtmlDocumentFormat);
		if (null == html)
			return doc;
		html.specialElementContentFormat = specialElementContentFormat;
		return html;
	}
}

