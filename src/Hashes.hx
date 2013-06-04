/**
 * ...
 * @author Franco Ponticelli
 */

import DynamicsT;
import thx.collection.Set;

class Hashes
{
	public static function entries<T>(h : Map<String, T> ) : Array<{ key : String, value : T }>
	{
		var arr = [];
		for (key in h.keys())
			arr.push({ key : key, value : h.get(key) });
		return arr;
	}

	public static function toDynamic<T>(hash : Map<String, T>) : Dynamic<T>
	{
		var o : Dynamic<T> = { };
		for (key in hash.keys())
			Reflect.setField(o, key, hash.get(key));
		return o;
	}

	public static function importObject<T>(hash : Map<String, T>, ob : Dynamic<T>) : Map<String, T>
	{
		return DynamicsT.copyToHash(ob, hash);
	}

	public static function copyTo<T>(from : Map<String, T>, to : Map<String, T>)
	{
		for (k in from.keys())
			to.set(k, from.get(k));
		return to;
	}

	public static function clone<T>(src : Map<String, T>)
	{
		var h = new Map ();
		Hashes.copyTo(src, h);
		return h;
	}

	public static inline function arrayOfKeys(hash : Map<String, Dynamic>)
	{
		return Iterators.array(hash.keys());
	}

	public static function setOfKeys(hash : Map<String, Dynamic>) : Set<String>
	{
		var set = new Set();
		for(k in hash.keys())
			set.add(k);
		return set;
	}

	public static inline function empty(hash : Map<String, Dynamic>) return count(hash) == 0;

	public static function count(hash : Map<String, Dynamic>)
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

	public static function mergef<T>(hash : Map<String, T> , new_hash : Map<String, T> , f:String->T->T->T)
	{
		for (k in new_hash.keys()){
			var new_val = new_hash.get(k);
			if (hash.exists(k)){
				var old_val = new_hash.get(k);
				hash.set(k, f(k, old_val, new_val));
			} else{
				hash.set(k,new_val);
			}
		}
	}

	public static function merge<T>(hash : Map<String, T> , new_hash : Map<String, T>)
	{
		mergef(hash, new_hash, function(key, old_v,new_v) return new_v);
	}

	public static function clear(hash : Map<String, Dynamic>)
	{
		#if cpp
		var _hash : { private var __Internal : Dynamic; } = hash;
		_hash.__Internal = {};
		#else
		var _hash : FriendHash = hash;
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

typedef FriendHash = {
	private var h :
		#if flash9 flash.utils.Dictionary
		#elseif php ArrayAccess<Dynamic>
		#else Dynamic #end;
}