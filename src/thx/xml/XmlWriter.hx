/**
 * ...
 * @author Franco Ponticelli
 */

package thx.xml;

using StringTools;

class XmlWriter
{
	var _stack : Array<Xml>;
	var _current : Xml;
	public function new(?xml : Xml)
	{
		if (null == xml)
			xml = Xml.createDocument();
		_stack = [xml];
		_current = _stack[0];
	}
	
	public function xml()
	{
		return _stack[0];
	}
	
	public function tag(name : String)
	{
		_current = Xml.createElement(name);
		_t().addChild(_current);
		return this;
	}
	
	public function open(tag : String)
	{
		_current = Xml.createElement(tag);
		_t().addChild(_current);
		_stack.push(_current);
		return this;
	}
	
	public function attr(name : String, value : String)
	{
		_current.set(name, value);
		return this;
	}
	
	public function appendTo(name : String, value : String)
	{
		if (_current.exists(name))
			_current.set(name, _current.get(name) + " " + value);
		else
			attr(name, value);
		return this;
	}
	
	public function attrIf(?cond : Bool, name : String, value : String)
	{
		if ((null == cond && (null != value && "" != value)) || cond)
			attr(name, value);
		return this;
	}
	
	public function text(s : String)
	{
		_t().addChild(Xml.createPCData(s.replace('&', '&amp;').replace('>', '&gt;').replace('<', '&lt;')));
		return this;
	}
	
	public function cdata(s : String)
	{
		_t().addChild(Xml.createCData(s.replace(']]>', ']]&gt;')));
		return this;
	}
	
	public function comment(s : String)
	{
		_t().addChild(Xml.createComment(s));
		return this;
	}
	
	public function close()
	{
		if (_stack.length == 1)
			throw "no open tags to close";
		
		_current = _stack.pop();
		if (!_current.elements().hasNext())
		{
			_current.addChild(Xml.createPCData(""));
		}
		return this;
	}
	
	public function toString()
	{
		return xml().toString();
	}
	
	inline function _t()
	{
		return _stack[_stack.length - 1];
	}
}