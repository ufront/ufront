/**
 * ...
 * @author Franco Ponticelli
 */

package thx.html;

import thx.html.HtmlHandler;

class TextHandler implements HtmlHandler {
	public var results(default, null) : String;
	public function new() {
		results = '';
	}

	public function start(tag : String, attrs : Array<Attr>, unary : Bool) {
		results += "<" + tag;
		for(i in 0...attrs.length)
			results += " " + attrs[i].name + '="' + attrs[i].escaped + '"';
		results += (unary ? "/" : "") + ">";
	}


	public function end(tag : String) {
		results += "</" + tag + ">";
	}

	public function chars(text : String) {
		results += text;
	}

	public function comment(text : String) {
		results += "<!--" + text + "-->";
	}

	public function doctype(text : String) {
		results += '<!DOCTYPE ' + text + '>';
	}
	
	public function declaration(text : String) {
		results += '<?xml ' + text + '>';
	}
}