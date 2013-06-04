/**
 * ...
 * @author Franco Ponticelli
 */

package thx.collection;

class Sets 
{
	inline public static function indexOf<T>(set : Set<T>, value : T) 
	{
		return Arrays.indexOf(arr(set), value);
	}
	
	inline public static function first<T>(set : Set<T>) 
	{
		return Arrays.first(arr(set));
	}
	
	inline public static function last<T>(set : Set<T>) 
	{
		return Arrays.last(arr(set));
	}
	
	inline public static function order<T>(set : Set<T>, ?f : T -> T -> Int)
	{
		arr(set).sort(null == f ? Dynamics.compare : f);
		return set;
	}
	
	static inline function arr<T>(set : { private var _v : Array<T>; }) return set._v
}