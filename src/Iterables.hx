/**
 * ...
 * @author Franco Ponticelli
 */

class Iterables
{

	inline public static function count<T>(it : Iterable<T>)
	{
		return Iterators.count(it.iterator());
	}

	inline public static function indexOf<T>(it : Iterable<T>, ?v : T, ?f : T -> Bool)
	{
		return Iterators.indexOf(it.iterator(), v, f);
	}

	inline public static function contains<T>(it : Iterable<T>, ?v : T, ?f : T -> Bool)
	{
		return Iterators.contains(it.iterator(), v, f);
	}

	inline public static function array<T>(it : Iterable<T>) : Array<T>
	{
		return Iterators.array(it.iterator());
	}

	inline public static function join<T>(it : Iterable<T>, glue = ", ")
	{
		return Iterators.join(it.iterator(), glue);
	}

	inline public static function map<TIn,TOut>(it : Iterable<TIn>, f : TIn -> Int -> TOut) : Array<TOut>
	{
		return Iterators.map(it.iterator(), f);
	}

	inline public static function each<T>(it : Iterable<T>, f : T -> Int -> Void) : Void
	{
		return Iterators.each(it.iterator(), f);
	}

	inline public static function filter<T>(it : Iterable<T>, f : T -> Bool) : Array<T>
	{
		return Iterators.filter(it.iterator(), f);
	}

	inline public static function reduce<TIn,TOut>(it : Iterable<TIn>, f : TOut -> TIn -> Int -> TOut, initialValue : TOut) : TOut
	{
		return Iterators.reduce(it.iterator(), f, initialValue);
	}

	inline public static function random<T>(it : Iterable<T>) : T
	{
		return Arrays.random(Iterables.array(it));
	}

	inline public static function any<T>(it : Iterable<T>, f : T -> Bool) : Bool
	{
		return Iterators.any(it.iterator(), f);
	}

	inline public static function all<T>(it : Iterable<T>, f : T -> Bool) : Bool
	{
		return Iterators.all(it.iterator(), f);
	}

	inline public static function last<T>(it : Iterable<T>) : Null<T>
	{
		return Iterators.last(it.iterator());
	}

	inline public static function lastf<T>(it : Iterable<T>, f : T -> Bool) : Null<T>
	{
		return Iterators.lastf(it.iterator(), f);
	}

	inline public static function first<T>(it : Iterable<T>) : Null<T>
	{
		return Iterators.first(it.iterator());
	}

	inline public static function firstf<T>(it : Iterable<T>, f : T -> Bool) : Null<T>
	{
		return Iterators.firstf(it.iterator(), f);
	}

	inline public static function order<T>(it : Iterable<T>, ?f : T -> T -> Int) : Array<T>
	{
		return Iterators.order(it.iterator(), f);
	}

	public static function isIterable(v : Dynamic) {
		var fields = Types.isAnonymous(v) ? Reflect.fields(v) : Type.getInstanceFields(Type.getClass(v));
		if(!Lambda.has(fields, "iterator")) return false;
		return Reflect.isFunction(Reflect.field(v, "iterator"));
	}
}