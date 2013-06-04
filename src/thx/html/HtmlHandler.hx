/**
 * ...
 * @author Franco Ponticelli
 */

package thx.html;

interface HtmlHandler
{
	public function start(tag : String, attrs : Array<Attr>, unary : Bool) : Void;
	public function end(tag : String) : Void;
	public function chars(text : String) : Void;
	public function comment(text : String) : Void;
	public function doctype(text : String) : Void;
	public function declaration(text : String) : Void;
}

typedef Attr = {
	name : String,
	value : String,
	escaped : String
}