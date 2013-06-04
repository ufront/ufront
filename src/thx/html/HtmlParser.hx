/**
* Port of HTML Parser By John Resig (ejohn.org)
* Original code by Erik Arvidsson, Mozilla Public License
* http://erik.eae.net/simplehtmlparser/simplehtmlparser.js
*
* // Use this way:
* var xml : Xml = Html.toXml(htmlString);
*
*/
package thx.html;
import thx.collection.Set;
import thx.html.HtmlHandler;
import thx.error.NullArgument;

class HtmlParser {
	// Regular Expressions for parsing tags and attributes
	static var startTag = ~/^<(\w+)((?:\s+[\w-]+(?:\s*=\s*(?:(?:"[^"]*")|(?:'[^']*')|[^>\s]+))?)*)\s*(\/?)>/;
	static var endTag = ~/^<\/(\w+)[^>]*>/;
	static var attr = ~/([\w-]+)(?:\s*=\s*(?:(?:"((?:\\.|[^"])*)")|(?:'((?:\\.|[^'])*)')|([^>\s]+)))?/gi;
	static var comment = ~/<!--(.*?)-->/g;
	static var cdata = ~/<!\[CDATA\[(.*?)]]>/g;
	static var doctype = ~/<!DOCTYPE(.*?)>/gi;
	static var declaration = ~/<?xml(.*?)>/g;

	var handler : HtmlHandler;
	var html : String;
	public function new(html : String)
	{
		NullArgument.throwIfNull(html);
		this.html = html;
	}

	var stack : Array<String>;
	public function process(handler : HtmlHandler)
	{
		NullArgument.throwIfNull(handler);
		this.handler = handler;
		var index : Int;
		var chars : Bool;
		var last = html;
		stack = [];
		var me = this;
		while (html != '') {
			chars = true;
			// Make sure we're not in a script or style element
			if (stacklast() == null || !Element.isSpecial(stacklast()))
			{
				// Comment
				if (html.indexOf("<!--") == 0)
				{
					index = html.indexOf("-->");
					if(index >= 0) {
						handler.comment(html.substr(4, index));
						html = html.substr(index + 3);
						chars = false;
					}
				// end tag
				} else if (html.indexOf("</") == 0)
				{
					if (endTag.match(html))
					{
						html = endTag.matchedRight();
						endTag.map(endTag.matched(0), function(re) { me.parseEndTag(re.matched(1)); return ""; });
						chars = false;
					}
				// start tag
				} else if (html.indexOf("<") == 0)
				{
					if (startTag.match(html))
					{
						html = startTag.matchedRight();
						startTag.map(startTag.matched(0), function(re) { me.parseStartTag(re.matched(1), re.matched(2), re.matched(3) == '/'); return ""; });
						chars = false;
					} else if (declaration.match(html)) {
						html = declaration.matchedRight();
						handler.declaration(declaration.matched(1));
						chars = false;
					} else if(doctype.match(html)) {
						html = doctype.matchedRight();
						handler.doctype(doctype.matched(1));
						chars = false;
					}
				}
				if (chars)
				{
					index = html.indexOf("<");
					var text = index < 0 ? html : html.substr(0, index);
					html = index < 0 ? "" : html.substr(index);
					handler.chars(text);
				}
			} else {
				var re = new EReg('(.*)</' + stacklast() + '[^>]*>', 'mi');
				re.match(html);
				var text = re.matchedLeft();
				text = comment.replace(text, "$1");
				text = cdata.replace(text, "$1");
				handler.chars(text);
				html = re.matchedRight();
				parseEndTag(stacklast());
			}

			if(html == last) throw "Parse Error: " + html.substr(0, 250);
			last = html;
		}

		// Clean up any remaining tags
		parseEndTag(null);
	}

	inline function stacklast()
	{
		return stack[stack.length-1];
	}

	function parseStartTag(tagName : String, rest : String, unary : Bool)
	{
		if (Element.isBlock(tagName))
		{
			while (stacklast() != null && Element.isInline(stacklast()))
				parseEndTag(stacklast());
		}

		if(Element.isCloseSelf(tagName) && stacklast() == tagName)
			parseEndTag(tagName);

		unary = Element.isEmpty(tagName) || unary;

		if(!unary)
			stack.push(tagName);

		var attrs = [];

		attr.map(rest, function(re : EReg)
		{
			var name = re.matched(1);
			var value = re.matched(2);
			if (value == null)
			{
				value = re.matched(3);
				if (value == null)
				{
					value = re.matched(4);
					if(value == null)
						value = Attribute.isFill(name) ? name : '';
				}
			}

			attrs.push({
				name: name,
				value: value,
				escaped: (~/(^|[^\\])"/g).replace(value, '$1\\\"') //"
			});
			return "";
		});

		handler.start(tagName, attrs, unary);
	}

	function parseEndTag(tagName : String)
	{
		var pos = -1;
		// If no tag name is provided, clean shop
		if(tagName == null || tagName == '') // TODO: check if '' is necessary
			pos = 0;

		// Find the closest opened tag of the same type
		else {
			pos = stack.length-1;
			while (pos >= 0)
			{
				if(stack[pos] == tagName)
					break;
				pos--;
			}
		}

		if (pos >= 0)
		{
			var i = stack.length-1;
			// Close all the open elements, up the stack
			while (i >= pos)
			{
				handler.end(stack[i]);
				// Remove the open elements from the stack
				stack.pop();
				i--;
			}
		}
	}
}

/*
this.HTMLtoDOM = function(html, doc) {
	// There can be only one of these elements
	var one = makeMap("html,head,body,title");

	// Enforce a structure for the document
	var structure = {
		link: "head",
		base: "head"
	};

	if(!doc) {
		if(typeof DOMDocument != "undefined")
			doc = new DOMDocument();
		else if(typeof document != "undefined" && document.implementation && document.implementation.createDocument)
			doc = document.implementation.createDocument("", "", null);
		else if(typeof ActiveX != "undefined")
			doc = new ActiveXObject("Msxml.DOMDocument");

	} else
		doc = doc.ownerDocument ||
			doc.getOwnerDocument && doc.getOwnerDocument() ||
			doc;

	var elems = [],
		documentElement = doc.documentElement ||
			doc.getDocumentElement && doc.getDocumentElement();

	// If we're dealing with an empty document then we
	// need to pre-populate it with the HTML document structure
	if(!documentElement && doc.createElement) (function(){
		var html = doc.createElement("html");
		var head = doc.createElement("head");
		head.appendChild(doc.createElement("title"));
		html.appendChild(head);
		html.appendChild(doc.createElement("body"));
		doc.appendChild(html);
	})();

	// Find all the unique elements
	if(doc.getElementsByTagName)
		for (var i in one)
			one[i] = doc.getElementsByTagName(i)[0];

	// If we're working with a document, inject contents into
	// the body element
	var curParentNode = one.body;

	HTMLParser(html, {
		start: function(tagName, attrs, unary) {
			// If it's a pre-built element, then we can ignore
			// its construction
			if(one[tagName]) {
				curParentNode = one[tagName];
				return;
			}

			var elem = doc.createElement(tagName);

			for (var attr in attrs)
				elem.setAttribute(attrs[attr].name, attrs[attr].value);

			if(structure[tagName] && typeof one[structure[tagName]] != "boolean")
				one[structure[tagName]].appendChild(elem);

			else if(curParentNode && curParentNode.appendChild)
				curParentNode.appendChild(elem);

			if(!unary) {
				elems.push(elem);
				curParentNode = elem;
			}
		},
		end: function(tag) {
			elems.length -= 1;

			// Init the new parentNode
			curParentNode = elems[elems.length - 1];
		},
		chars: function(text) {
			curParentNode.appendChild(doc.createTextNode(text));
		},
		comment: function(text) {
			// create comment node
		}
	});

	return doc;
};
*/