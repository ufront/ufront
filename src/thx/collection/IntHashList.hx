/**
 * ...
 * @author Franco Ponticelli
 */

package thx.collection;

class IntHashList<T>
{
	public var length(default, null) : Int;
	
	public function new() : Void
	{
		length = 0;
		__keys = [];
		__hash = new Map ();
	}
	
	public function set( key : Int, value : T ) : Void
	{
		if (!__hash.exists(key))
		{
			__keys.push(key);
			length++;
		}
		__hash.set(key, value);
	}

	public function get( key : Int ) : Null < T >
	{
		return __hash.get(key);
	}
	
	public function getAt(index : Int) : Null<T>
	{
		return __hash.get(__keys[index]);
	}

	public function exists( key : Int ) : Bool
	{
		return __hash.exists(key);
	}

	public function remove( key : Int ) : T
	{
		var item = __hash.get(key);
		if (item == null) return null;
		__hash.remove(key);
		__keys.remove(key);
		length--;
		return item;
	}
	
	public function removeAt(index : Int) : T
	{
		if (index < 0 || index >= length) return null;
		var key = __keys[index];
		var item = __hash.get(key);
		__hash.remove(key);
		__keys.remove(key);
		length--;
		return item;
	}

	public function keys() : Iterator<Int>
	{
		return __keys.iterator();
	}

	public function iterator() : Iterator<T>
	{
		return array().iterator();
	}
	
	public function clear() : Void
	{
		__hash = new Map ();
		__keys = [];
		length = 0;
	}

	public function array() : Array < T >
	{
		var values = [];
		for (k in __keys)
			values.push(__hash.get(k));
		return values;
	}
	
	public function toString()
	{
		var s = new StringBuf();
		s.add("{");
		var it = keys();
		for ( i in it )
		{
			s.add(i);
			s.add(" => ");
			s.add(Std.string(get(i)));
			if( it.hasNext() )
				s.add(", ");
		}
		s.add("}");
		return s.toString();
	}
	
	var __keys : Array<Int>;
	var __hash : Map<Int, T>;
}