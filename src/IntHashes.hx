import haxe.ds.IntMap;

class IntHashes
{
	public static inline function empty(hash  : IntMap<Dynamic>) return count(hash) == 0;

	public static function count(hash : IntMap<Dynamic>)
	{
		#if neko
		return untyped __dollar__hsize(hash.h);
		#elseif php
		return untyped __call__('count', hash.h);
		#else
		var i = 0;
		for (_ in hash)
			i++;
		return i;
		#end
	}

	public static function clear(hash  : IntMap<Dynamic>)
	{
		#if cpp
		untyped hash.h = __global__.__int_hash_create();
		#else
		var _hash : FriendIntHash = hash;
		#if flash9
		_hash.h = new flash.utils.Dictionary();
		#elseif flash
		_hash.h = untyped __new__(_global["Object"]);
		#elseif neko
		_hash.h = untyped __dollar__hnew(0);
		#elseif js
		untyped {
			_hash.h = __js__("{}");
			if( _hash.h.__proto__ != null ) {
				_hash.h.__proto__ = null;
				__js__("delete")(_hash.h.__proto__);
			}
		}
		#elseif php
		_hash.h = untyped __call__('array');
		#end
		#end
	}
}

typedef FriendIntHash = {
	private var h :
		#if flash9 flash.utils.Dictionary
		#elseif php ArrayAccess<Dynamic>
		#else Dynamic #end;
}