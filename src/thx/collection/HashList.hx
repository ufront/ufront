/**
 * ...
 * @author Franco Ponticelli
 */

package thx.collection;

class HashList<T>
{
	public var length(default, null) : Int;
	
	public function new() : Void
	{
		length = 0;
		__keys = [];
		__hash = new Map ();
	}
	
	public function set( key : String, value : T ) : Void
	{
		if (!__hash.exists(key))
		{
			__keys.push(key);
			length++;
		}
		__hash.set(key, value);
	}
	
	public function setAt(index : Int, key : String, value : T) : Void
	{
		remove(key);
		__keys.insert(index, key);
		__hash.set(key, value);
		length++;
	}

	public function get( key : String ) : Null < T >
	{
		return __hash.get(key);
	}
	
	public function getAt(index : Int) : Null<T>
	{
		return __hash.get(__keys[index]);
	}
	
	public function indexOf(key : String) : Int
	{
		if (!__hash.exists(key)) return -1;
		for (i in 0...__keys.length)
			if (__keys[i] == key)
				return i;
		return throw "this should never happen";
	}

	public function exists( key : String ) : Bool
	{
		return __hash.exists(key);
	}

	public function remove( key : String ) : T
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
		var key = __keys[index];
		if (key == null) return null;
		var item = __hash.get(key);
		__hash.remove(key);
		__keys.remove(key);
		length--;
		return item;
	}
	
	public function keyAt(index : Int)
	{
		return __keys[index];
	}

	public function keys() : Iterator<String>
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
		for( i in it ) {
			s.add(i);
			s.add(" => ");
			s.add(Std.string(get(i)));
			if( it.hasNext() )
				s.add(", ");
		}
		s.add("}");
		return s.toString();
	}
	
	var __keys : Array<String>;
	var __hash : Map<String, T>;
}