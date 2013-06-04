package thx.html;
import thx.error.Error;
import thx.html.HtmlDocumentFormat;
import thx.html.HtmlVersion;

/**
 * ...
 * @author Franco Ponticelli
 */

class Html
{
	public static function getFormatter(version) : XHtmlFormat
	{
		var format : XHtmlFormat;
		switch(version)
		{
			case Html401Strict, Html401Transitional, Html401Frameset:
				var f = new HtmlFormat();
				f.quotesRemoval = false;
				f.useCloseSelf = false;
				f.specialElementContentFormat = AsCommentedText;
				format = f;
			case Html5:
				var f = new HtmlFormat();
				f.quotesRemoval = true;
				f.useCloseSelf = true;
				f.specialElementContentFormat = AsPlainText;
				format = f;
			case XHtml10Transitional, XHtml10Frameset, XHtml10Strict, XHtml11:
				format = new XHtmlFormat();
		}
		format.autoformat = true;
		format.normalizeNewlines = true;
		return format;
	}
	
	public static function getHtml(dom : Xml)
	{
		if (dom.nodeType != Xml.Document)
			throw new Error("invalid node type '{0}', should be Xml.Document", dom.nodeType);
		return dom.firstElement();
	}
	
	public static function getHead(dom : Xml)
	{
		return getHtml(dom).firstElement();
	}
	
	public static function getTitle(dom : Xml)
	{
		return getHead(dom).elementsNamed("title").next();
	}
	
	public static function getBody(dom : Xml)
	{
		return getHtml(dom).elementsNamed("body").next();
	}
	
	public static function createDocument(version)
	{
		var parser = getParser(version);
		return parser(getTemplate(version));
	}
	
	public static function getParser(version) : String -> Xml
	{
		switch(version)
		{
			case Html401Strict, Html401Transitional, Html401Frameset, Html5:
				return Html.toXml;
			case XHtml10Transitional, XHtml10Frameset, XHtml10Strict, XHtml11:
				return Xml.parse;
		}
	}
	
	public static function getTemplate(version)
	{
		switch(version)
		{
			case Html401Strict:
				return getTemplateHtml4Strict();
			case Html401Transitional:
				return getTemplateHtml4Transitional();
			case Html401Frameset:
				return getTemplateHtml4Frameset();
			case Html5:
				return getTemplateHtml5();
			case XHtml10Transitional:
				return getTemplateXHtml10Transitional();
			case XHtml10Frameset:
				return getTemplateXHtml10Frameset();
			case XHtml10Strict:
				return getTemplateXHtml10Strict();
			case XHtml11:
				return getTemplateXHtml11();
		}
	}
	
	static function getTemplateHtml4Strict()
	{
		return '<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd"><html><head><title></title></head><body></body></html>';
	}
	
	static function getTemplateHtml4Transitional()
	{
		return '<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"><html><head><title></title></head><body></body></html>';
	}
	
	static function getTemplateHtml4Frameset()
	{
		return '<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Frameset//EN" "http://www.w3.org/TR/html4/frameset.dtd"><html><head><title></title></head><frameset><noframes><body></body></noframes></frameset></html>';
	}
	
	static function getTemplateHtml5()
	{
		return '<!doctype html><html><head><title></title></head><body></body></html>';
	}
	
	static function getTemplateXHtml10Transitional()
	{
		return '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"><html xmlns="http://www.w3.org/1999/xhtml"><head><title></title></head><body></body></html>';
	}
	
	static function getTemplateXHtml10Strict()
	{
		return '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"><html xmlns="http://www.w3.org/1999/xhtml"><head><title></title></head><body></body></html>';
	}
	
	static function getTemplateXHtml10Frameset()
	{
		return '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Frameset//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd"><html xmlns="http://www.w3.org/1999/xhtml"><head><title></title></head><frameset><noframes><body></body></noframes></frameset></html>';
	}
	
	static function getTemplateXHtml11()
	{
		return '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd"><html xmlns="http://www.w3.org/1999/xhtml"><head><title></title></head><body></body></html>';
	}
	
	public static function toXml(html : String)
	{
		var handler = new DomHandler();
		var parser = new HtmlParser(html);
		parser.process(handler);
		return handler.document;
	}
	
	public static function toXmlString(html : String) {
		var handler = new TextHandler();
		var parser = new HtmlParser(html);
		parser.process(handler);
		return handler.results;
	}
}