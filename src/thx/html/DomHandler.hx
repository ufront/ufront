/**
 * ...
 * @author Franco Ponticelli
 */

package thx.html;

import thx.html.HtmlHandler;

class DomHandler implements HtmlHandler {
	public var document(default, null) : Xml;
	var current : Xml;
	public function new() {
		document = Xml.createDocument();
		current = document;
	}

	public function start(tag : String, attrs : Array<Attr>, unary : Bool) {
		var node = Xml.createElement(tag);
		for(attr in attrs)
			node.set(attr.name, attr.value);
		current.addChild(node);
		if(!unary)
			current = node;
	}

	public function end(tag : String) {
		current = current.parent;
	}

	public function chars(text : String) {
		current.addChild(Xml.createPCData(text));
	}

	public function comment(text : String) {
		current.addChild(Xml.createComment(text));
	}

	public function doctype(text : String) {
		current.addChild(Xml.createDocType(text));
	}
	
	public function declaration(text : String) {
		current.addChild(Xml.createProcessingInstruction(text));
	}
}