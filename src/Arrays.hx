/**
 * ...
 * @author Franco Ponticelli
 */
import thx.culture.Culture;
import thx.culture.FormatParams;

class Arrays
{
	/**
	 * push the value into the array and return the array itself only if the condition
	 * evaluates to true.
	 */
	public static function addIf<T>(arr : Array<T>, ?condition : Bool, value : Null<T>) : Array<T>
	{
		if (null != condition)
		{
			if(condition)
				arr.push(value);
		} else if (null != value)
			arr.push(value);
		return arr;
	}

	/**
	 * push the value into the array and return the array itself
	 */
	inline public static function add<T>(arr : Array<T>, value : T) : Array<T>
	{
		arr.push(value);
		return arr;
	}

	/**
	 * removes the value from the array and return the array itself
	 */
	inline public static function delete<T>(arr : Array<T>, value : T) : Array<T>
	{
		arr.remove(value);
		return arr;
	}

	public static function removef<T>(arr : Array<T>, f : T -> Bool) : Bool
	{
		var index = -1;
		for(i in 0...arr.length)
			if(f(arr[i]))
			{
				index = i;
				break;
			}
		if(index < 0)
			return false;
		arr.splice(index, 1);
		return true;
	}

	inline public static function deletef<T>(arr : Array<T>, f : T -> Bool) : Array<T>
	{
		Arrays.removef(arr, f);
		return arr;
	}

	/**
	 * creates a new array filtered by the 'f' function
	 */
	public static function filter<T>(arr : Array<T>, f : T -> Bool) : Array<T>
	{
		var result = [];
		for (i in arr)
			if (f(i))
				result.push(i);
		return result;
	}

	public static function min<T>(arr : Array<T>, ?f : T -> Float) : Null<T>
	{
		if (arr.length == 0)
			return null;
		if (null == f) {
			var a = arr[0], p = 0;
			var comp = Dynamics.comparef(a);
			for(i in 1...arr.length) if(comp(a, arr[i]) > 0) a = arr[p = i];
			return arr[p];
		} else {
			var a = f(arr[0]), p = 0, b;
			for(i in 1...arr.length) if(a > (b = f(arr[i]))) { a = b; p = i; }
			return arr[p];
		}
	}

	public static function floatMin<T>(arr : Array<T>, f : T -> Float) : Float
	{
		if (arr.length == 0)
			return Math.NaN;
		var a = f(arr[0]), b;
		for(i in 1...arr.length) if(a > (b = f(arr[i]))) { a = b; }
		return a;
	}

	public static function bounds<T>(arr : Array<T>, ?f : T -> Float) : Array<Null<T>>
	{
		if (arr.length == 0)
			return null;
		if (null == f) {
			var a = arr[0], p = 0;
			var b = arr[0], q = 0;
			for(i in 1...arr.length) {
				var comp = Dynamics.comparef(a);
				if(comp(a, arr[i]) > 0) a = arr[p = i];
				if(comp(b, arr[i]) < 0) b = arr[q = i];
			}
			return [arr[p], arr[q]];
		} else {
			var a = f(arr[0]), p = 0, b;
			var c = f(arr[0]), q = 0, d;
			for(i in 1...arr.length) if(a > (b = f(arr[i]))) { a = b; p = i; }
			for(i in 1...arr.length) if(c < (d = f(arr[i]))) { c = d; q = i; }
			return [arr[p], arr[q]];
		}
	}

	public static function boundsFloat<T>(arr : Array<T>, f : T -> Float) : Array<Float>
	{
		if (arr.length == 0)
			return null;
		var a = f(arr[0]), b;
		var c = f(arr[0]), d;
		for(i in 1...arr.length) {
			if(a > (b = f(arr[i]))) { a = b; }
			if(c < (d = f(arr[i]))) { c = d; }
		}
			return [a, c];
	}

	public static function max<T>(arr : Array<T>, ?f : T -> Float) : Null<T>
	{
		if (arr.length == 0)
			return null;
		if (null == f) {
			var a = arr[0], p = 0;
			var comp = Dynamics.comparef(a);
			for(i in 1...arr.length) if(comp(a, arr[i]) < 0) a = arr[p = i];
			return arr[p];
		} else {
			var a = f(arr[0]), p = 0, b;
			for(i in 1...arr.length) if(a < (b = f(arr[i]))) { a = b; p = i; }
			return arr[p];
		}
	}


	public static function floatMax<T>(arr : Array<T>, f : T -> Float) : Float
	{
		if (arr.length == 0)
			return Math.NaN;
		var a = f(arr[0]), b;
		for(i in 1...arr.length) if(a < (b = f(arr[i]))) { a = b; }
		return a;
	}

	public static function flatten<T>(arr : Array<Array<T>>) : Array<T>
	{
		var r = [];
		for (v in arr)
			r = r.concat(v);
		return r;
	}

	inline public static function map<TIn,TOut>(arr : Array<TIn>, f : TIn -> Int -> TOut) : Array<TOut>
	{
		return Iterators.map(arr.iterator(), f);
	}

	inline public static function reduce<TIn,TOut>(arr : Array<TIn>, f : TOut -> TIn -> Int -> TOut, initialValue : TOut) : TOut
	{
#if js
		return untyped arr.reduce(f, initialValue);
#else
		return Iterators.reduce(arr.iterator(), f, initialValue);
#end
	}

	inline public static function order<T>(arr : Array<T>, ?f : T -> T -> Int)
	{
		arr.sort(null == f ? Dynamics.compare : f);
		return arr;
	}

	public static function orderMultiple<T>(arr : Array<T>, ?f : T -> T -> Int, rest : Array<Array<Dynamic>>)
	{
		var swap = true,
			t : Dynamic;
		rest.remove(arr); // prevents infinite loop if hte arr is passed twice
		while (swap)
		{
			swap = false;
			for (i in 0...arr.length - 1)
			{
				if (f(arr[i], arr[i + 1]) > 0)
				{
					swap = true;

					t = arr[i];
					arr[i] = arr[i + 1];
					arr[i + 1] = t;

					for (a in rest)
					{
						t = a[i];
						a[i] = a[i+1];
						a[i+1] = t;
					}
				}
			}
		}
	}

	public static function split<T>(arr : Array<T>, ?f : T -> Int -> Bool) : Array<Array<T>>
	{
		if (null == f) f = function(v, _) return v == null;
		var arrays = [],
			i = -1,
			values = [],
			value;
		for(i in 0...arr.length)
		{
			if (f(value = arr[i], i))
				values = [];
			else {
				if (values.length == 0) arrays.push(values);
				values.push(value);
			}
		}
		return arrays;
	}

	public static function exists<T>(arr : Array<T>, ?value : T, ?f : T -> Bool)
	{
		if (null != f)
		{
			for (v in arr)
				if (f(v))
					return true;
		} else {
			for (v in arr)
				if (v == value)
					return true;
		}
		return false;
	}

	public static function format(v : Array<Dynamic>, ?param : String, ?params : Array<String>, ?culture : Culture)
	{
		params = FormatParams.params(param, params, 'J');
		var format = params.shift();
		switch(format)
		{
			case 'J':
				if (v.length == 0)
				{
					var empty = null == params[1] ? '[]' : params[1];
					return empty;
				}

				var sep = null == params[2] ? ', ' : params[2];
				var max : Null<Int> = params[3] == null ? null : ('' == params[3] ? null : Std.parseInt(params[3]));
				if (null != max && max < v.length)
				{
					var elipsis = null == params[4] ? ' ...' : params[4];
					return Arrays.map(v.copy().splice(0, max), function(d, i) return Dynamics.format(d, params[0], culture)).join(sep) + elipsis;
				} else
					return Arrays.map(v, function(d, i) return Dynamics.format(d, params[0], culture)).join(sep);
			case 'C':
				return Ints.format(v.length, 'I', [], culture);
			default:
				throw "Unsupported array format: " + format;
		}
	}

	public static function formatf(?param : String, ?params : Array<String>, ?culture : Culture)
	{
		params = FormatParams.params(param, params, 'J');
		var format = params.shift();
		switch(format)
		{
			case 'J':
				return function(v : Array<Dynamic>)
				{
					if (v.length == 0)
					{
						var empty = null == params[1] ? '[]' : params[1];
						return empty;
					}

					var sep = null == params[2] ? ', ' : params[2];
					var max : Null<Int> = params[3] == null ? null : ('' == params[3] ? null : Std.parseInt(params[3]));
					if (null != max && max < v.length)
					{
						var elipsis = null == params[4] ? ' ...' : params[4];
						return Arrays.map(v.copy().splice(0, max), function(d, i) return Dynamics.format(d, params[0], culture)).join(sep) + elipsis;
					} else
						return Arrays.map(v, function(d, i) return Dynamics.format(d, params[0], culture)).join(sep);
				}
			case 'C':
				var f = Ints.formatf('I', [], culture);
				return function(v) return f(v.length);
			default:
				throw "Unsupported array format: " + format;
		}
	}

	public static function interpolate(v : Float, a : Array<Float>, b : Array<Float>, ?equation : Float -> Float) : Array<Float>
	{
		return interpolatef(a, b, equation)(v);
	}

	public static function interpolatef(a : Array<Float>, b : Array<Float>, ?equation : Float -> Float)
	{
		var functions = [],
			i = 0,
			min = Ints.min(a.length, b.length);

		while (i < min)
		{
			if (a[i] == b[i])
			{
				var v = b[i];
				functions.push(function(_) return v);
			} else
				functions.push(Floats.interpolatef(a[i], b[i], equation));
			i++;
		}
		while (i < b.length)
		{
			var v = b[i];
			functions.push(function(_) return v);
			i++;
		}
		return function(t) return Arrays.map(functions, function(f, _) return f(t));
	}

	public static function interpolateStrings(v : Float, a : Array<String>, b : Array<String>, ?equation : Float -> Float) : Array<String>
	{
		return interpolateStringsf(a, b, equation)(v);
	}

	public static function interpolateStringsf(a : Array<String>, b : Array<String>, ?equation : Float -> Float)
	{
		var functions = [],
			i = 0,
			min = Ints.min(a.length, b.length);

		while (i < min)
		{
			if (a[i] == b[i])
			{
				var v = b[i];
				functions.push(function(_) return v);
			} else
				functions.push(Strings.interpolatef(a[i], b[i], equation));
			i++;
		}
		while (i < b.length)
		{
			var v = b[i];
			functions.push(function(_) return v);
			i++;
		}
		return function(t) return Arrays.map(functions, function(f, _) return f(t));
	}

	public static function interpolateInts(v : Float, a : Array<Int>, b : Array<Int>, ?equation : Float -> Float) : Array<Int>
	{
		return interpolateIntsf(a, b, equation)(v);
	}

	public static function interpolateIntsf(a : Array<Int>, b : Array<Int>, ?equation : Float -> Float)
	{
		var functions = [],
			i = 0,
			min = Ints.min(a.length, b.length);

		while (i < min)
		{
			if (a[i] == b[i])
			{
				var v = b[i];
				functions.push(function(_) return v);
			} else
				functions.push(Ints.interpolatef(a[i], b[i], equation));
			i++;
		}
		while (i < b.length)
		{
			var v = b[i];
			functions.push(function(_) return v);
			i++;
		}
		return function(t) return Arrays.map(functions, function(f, _) return f(t));
	}

	#if js inline #end public static function indexOf<T>(arr : Array<T>, el : T)
	{
#if js
		return untyped arr.indexOf(el);
#else
		var len = arr.length;
		for (i in 0...len)
			if (arr[i] == el)
				return  i;
		return -1;
#end
	}

	#if js inline #end public static function every<T>(arr : Array<T>, f : T -> Int -> Bool) : Bool
	{
#if js
		return untyped arr.every(f);
#else
		for (i in 0...arr.length)
			if (!f(arr[i], i))
				return false;
		return true;
#end
	}

	#if js inline #end public static function each<T>(arr : Array<T>, f : T -> Int -> Void) : Void
	{
#if js
		untyped arr.forEach(f);
#else
		for (i in 0...arr.length)
			f(arr[i], i);
#end
	}

	inline public static function any<T>(arr : Array<T>, f : T -> Bool) : Bool
	{
		return Iterators.any(arr.iterator(), f);
	}

	inline public static function all<T>(arr : Array<T>, f : T -> Bool) : Bool
	{
		return Iterators.all(arr.iterator(), f);
	}

	public static function random<T>(arr : Array<T>) : T
	{
		return arr[Std.random(arr.length)];
	}

	public static function string<T>(arr : Array<T>)
	{
		return "[" + Arrays.map(arr, function(v, _) return Dynamics.string(v)).join(", ") + "]";
	}

	inline public static function last<T>(arr : Array<T>) : Null<T>
	{
		return arr[arr.length - 1];
	}

	public static function lastf<T>(arr : Array<T>, f : T -> Bool) : Null<T>
	{
		var i = arr.length;
		while (--i >= 0)
			if (f(arr[i]))
				return arr[i];
		return null;
	}

	inline public static function first<T>(arr : Array<T>) : Null<T>
	{
		return arr[0];
	}

	public static function firstf<T>(arr : Array<T>, f : T -> Bool) : Null<T>
	{
		for (v in arr)
			if (f(v))
				return v;
		return null;
	}

	inline public static function bisect(a : Array<Float>, x : Float, lo = 0, ?hi : Int)
	{
		return bisectRight(a, x, lo, hi);
	}

	public static function bisectRight(a : Array<Float>, x : Float, lo = 0, ?hi : Int)
	{
		if (null == hi)
			hi = a.length;
		while (lo < hi)
		{
			var mid = lo + hi >> 1;
			if (x < a[mid])
				hi = mid;
			else
				lo = mid + 1;
		}
		return lo;
	}

	public static function bisectLeft(a : Array<Float>, x : Float, lo = 0, ?hi : Int)
	{
		if (null == hi)
			hi = a.length;
		while (lo < hi)
		{
			var mid = lo + hi >> 1;
			if (a[mid] < x)
				lo = mid + 1;
			else
				hi = mid;
		}
		return lo;
	}

	public static function nearest<T>(a : Array<T>, x : Float, f : T -> Float) : T
	{
		var delta = [];
		for (i in 0...a.length)
			delta.push( { i : i, v : Math.abs(f(a[i]) - x) } );
		delta.sort(function(a, b) return Floats.compare(a.v, b.v));
		return a[delta[0].i];
	}

	public static function compare<T>(a : Array<T>, b : Array<T>)
	{
		var v : Int;
		if ((v = Ints.compare(a.length, b.length)) != 0)
			return v;
		for (i in 0...a.length)
		{
			if ((v = Dynamics.compare(a[i], b[i])) != 0)
				return v;
		}
		return 0;
	}

	public static function product<T>(a : Array<Array<T>>) : Array<Array<T>>
	{
		if (a.length == 0)
			return [];

		var arr = a.copy(),
			result : Array<Array<T>> = [],
			temp : Array<Array<T>>;

		for (value in arr[0])
			result.push([value]);
		for (i in 1...arr.length)
		{
			temp = [];
			for (acc in result)
				for (value in arr[i])
					temp.push(acc.copy().concat([value]));
			result = temp;
		}
		return result;
	}

	public static function rotate<T>(a : Array<Array<T>>) : Array<Array<T>>
	{
		if (a.length == 0)
			return [];

		var result = [];
		for (i in 0...a[0].length)
			result[i] = [];
		for (j in 0...a.length)
			for (i in 0...a[0].length)
				result[i][j] = a[j][i];
		return result;
	}

	public static function shuffle<T>(a : Array<T>) : Array<T>
	{
		var t = Ints.range(a.length),
			arr = [];
		while (t.length > 0)
		{
			var pos = Std.random(t.length),
				index = t[pos];
			t.splice(pos, 1);
			arr.push(a[index]);
		}
		return arr;
	}

	public static function scanf<T>(arr : Array<T>, weightf : T -> Int -> Float, incremental = true) : Float -> Null<T>
	{
		var tot = 0.0,
			weights = [];
		if(incremental)
		{
			for(i in 0...arr.length)
			{
				weights[i] = (tot += weightf(arr[i], i));
			}
		} else {
			for(i in 0...arr.length)
			{
				weights[i] = weightf(arr[i], i);
			}
			tot = weights[weights.length-1];
		}

		function scan(v : Float, start : Int, end : Int)
		{
			if(start == end)
				return arr[start];
			var mid   = Math.floor((end - start) / 2) + start,
				value = weights[mid];
			if(v < value)
				return scan(v, start, mid);
			else
				return scan(v, mid+1, end);
		}

		return function(v : Float)
		{
			if(v < 0 || v > tot) // out of range
				return null;
			return scan(v, 0, weights.length - 1);
		}
	}

#if (js && js_shims)
	static function __init__()
	{
		untyped __js__("if (!('indexOf' in Array.prototype)) {
    Array.prototype.indexOf= function(find, i /*opt*/) {
        if (i===undefined) i= 0;
        if (i<0) i+= this.length;
        if (i<0) i= 0;
        for (var n= this.length; i<n; i++)
            if (i in this && this[i]===find)
                return i;
        return -1;
    };
}
if (!('lastIndexOf' in Array.prototype)) {
    Array.prototype.lastIndexOf= function(find, i /*opt*/) {
        if (i===undefined) i= this.length-1;
        if (i<0) i+= this.length;
        if (i>this.length-1) i= this.length-1;
        for (i++; i-->0;) /* i++ because from-argument is sadly inclusive */
            if (i in this && this[i]===find)
                return i;
        return -1;
    };
}
if (!('forEach' in Array.prototype)) {
    Array.prototype.forEach= function(action, that /*opt*/) {
        for (var i= 0, n= this.length; i<n; i++)
            if (i in this)
                action.call(that, this[i], i, this);
    };
}
if (!('map' in Array.prototype)) {
    Array.prototype.map= function(mapper, that /*opt*/) {
        var other= new Array(this.length);
        for (var i= 0, n= this.length; i<n; i++)
            if (i in this)
                other[i]= mapper.call(that, this[i], i, this);
        return other;
    };
}
if (!('filter' in Array.prototype)) {
    Array.prototype.filter= function(filter, that /*opt*/) {
        var other= [], v;
        for (var i=0, n= this.length; i<n; i++)
            if (i in this && filter.call(that, v= this[i], i, this))
                other.push(v);
        return other;
    };
}
if (!('every' in Array.prototype)) {
    Array.prototype.every= function(tester, that /*opt*/) {
        for (var i= 0, n= this.length; i<n; i++)
            if (i in this && !tester.call(that, this[i], i, this))
                return false;
        return true;
    };
}");
	}
#end
}

/* TODO

sortBy_.sortBy(list, iterator, [context])
Returns a sorted copy of list, ranked in ascending order by the results of running each value through iterator.

_.sortBy([1, 2, 3, 4, 5, 6], function(num){ return Math.sin(num); });
=> [5, 4, 6, 3, 1, 2]

groupBy_.groupBy(list, iterator)
Splits a collection into sets, grouped by the result of running each value through iterator. If iterator is a string instead of a function, groups by the property named by iterator on each of the values.

_.groupBy([1.3, 2.1, 2.4], function(num){ return Math.floor(num); });
=> {1: [1.3], 2: [2.1, 2.4]}

_.groupBy(['one', 'two', 'three'], 'length');
=> {3: ["one", "two"], 5: ["three"]}

initial_.initial(array, [n])
Returns everything but the last entry of the array. Especially useful on the arguments object. Pass n to exclude the last n elements from the result.

_.initial([5, 4, 3, 2, 1]);
=> [5, 4, 3, 2]

rest_.rest(array, [index]) Alias: tail
Returns the rest of the elements in an array. Pass an index to return the values of the array from that index onward.

_.rest([5, 4, 3, 2, 1]);
=> [4, 3, 2, 1]

compact_.compact(array)
Returns a copy of the array with all falsy values removed. In JavaScript, false, null, 0, "", undefined and NaN are all falsy.

_.compact([0, 1, false, 2, '', 3]);
=> [1, 2, 3]

without_.without(array, [*values])
Returns a copy of the array with all instances of the values removed. === is used for the equality test.

_.without([1, 2, 1, 0, 3, 1, 4], 0, 1);
=> [2, 3, 4]
union_.union(*arrays)
Computes the union of the passed-in arrays: the list of unique items, in order, that are present in one or more of the arrays.

_.union([1, 2, 3], [101, 2, 1, 10], [2, 1]);
=> [1, 2, 3, 101, 10]
intersection_.intersection(*arrays)
Computes the list of values that are the intersection of all the arrays. Each value in the result is present in each of the arrays.

_.intersection([1, 2, 3], [101, 2, 1, 10], [2, 1]);
=> [1, 2]
difference_.difference(array, *others)
Similar to without, but returns the values from array that are not present in the other arrays.

_.difference([1, 2, 3, 4, 5], [5, 2, 10]);
=> [1, 3, 4]
uniq_.uniq(array, [isSorted], [iterator]) Alias: unique
Produces a duplicate-free version of the array, using === to test object equality. If you know in advance that the array is sorted, passing true for isSorted will run a much faster algorithm. If you want to compute unique items based on a transformation, pass an iterator function.

_.uniq([1, 2, 1, 3, 1, 4]);
=> [1, 2, 3, 4]
zip_.zip(*arrays)
Merges together the values of each of the arrays with the values at the corresponding position. Useful when you have separate data sources that are coordinated through matching array indexes. If you're working with a matrix of nested arrays, zip.apply can transpose the matrix in a similar fashion.

_.zip(['moe', 'larry', 'curly'], [30, 40, 50], [true, false, false]);
=> [["moe", 30, true], ["larry", 40, false], ["curly", 50, false]]
*/