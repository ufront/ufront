/**
 * ...
 * @author Franco Ponticelli
 */

import thx.culture.Culture;
import thx.culture.FormatParams;
import thx.error.Error;

class Objects
{
	inline public static function field<T>(o : { }, fieldname : String, ?alt : Null<T> = null) : Null<T>
	{
		return Reflect.hasField(o, fieldname) ? Reflect.field(o, fieldname) : alt;
	}

	inline public static function keys(o : { } ) : Array<String>
	{
		return Reflect.fields(o);
	}

	public static function values<T>(o : { } ) : Array<T>
	{
		var arr = [];
		for (key in Reflect.fields(o))
			arr.push(Reflect.field(o, key));
		return arr;
	}

	public static function entries(o : { } ) : Array<Entry>
	{
		var arr = [];
		for (key in Reflect.fields(o))
			arr.push({ key : key, value : Reflect.field(o, key) });
		return arr;
	}

	public static function each<T>(o : { }, handler : String -> T -> Void)
	{
		for(key in Reflect.fields(o))
		{
			handler(key, Reflect.field(o, key));
		}
	}

	public static function map<TIn, TOut>(o : { }, handler : String -> TIn -> TOut) : Array<TOut>
	{
		var results = [];
		for(key in Reflect.fields(o))
		{
			results.push(handler(key, Reflect.field(o, key)));
		}
		return results;
	}

	public static inline function with<T>(ob : T, f : T -> Void)
	{
		f(ob);
		return ob;
	}

	public static function toHash<T>(ob : {}) : Map<String, T>
	{
		var Map  = new Map ();
		return copyToHash(ob, Map );
	}

	public static function copyToHash<T>(ob : {}, Map  : Map<String, T>) : Map<String, T>
	{
		for (field in Reflect.fields(ob))
			Map .set(field, Reflect.field(ob, field));
		return Map ;
	}

	public static function interpolate<T>(v : Float, a : T, b : T, ?equation : Float -> Float) : T
	{
		return interpolatef(a, b, equation)(v);
	}

	public static function interpolatef<T>(a : T, b : T, ?equation : Float -> Float) : Float -> T
	{
		var i : Dynamic = { },
			c : Dynamic = { },
			keys = Reflect.fields(a);
		for (key in keys)
		{
			if (Reflect.hasField(b, key))
			{
				var va = Reflect.field(a, key);
				Reflect.setField(i, key, Dynamics.interpolatef(va, Reflect.field(b, key)));
			} else
				Reflect.setField(c, key, Reflect.field(a, key));
		}

		keys = Reflect.fields(b);
		for (key in keys)
		{
			if (!Reflect.hasField(a, key))
				Reflect.setField(c, key, Reflect.field(b, key));
		}

		return function(t) {
			for (k in Reflect.fields(i))
				Reflect.setField(c, k, Reflect.callMethod(i, Reflect.field(i, k), [t]));
			return c;
		};
	}

	// @todo: add support for Array
	public static function copyTo(src : { }, dst : { } )
	{
		for (field in Reflect.fields(src))
		{
			var sv = Dynamics.clone(Reflect.field(src, field));
			var dv = Reflect.field(dst, field);
			if (Types.isAnonymous(sv) && Types.isAnonymous(dv))
			{
				copyTo(sv, dv);
			} else {
				Reflect.setField(dst, field, sv);
			}
		}
		return dst;
	}

	public static function clone<T>(src : T) : T
	{
		var dst = { };
		return cast copyTo(cast src, cast dst);
	}

	public static function mergef(ob : {}, new_ob : {}, f : String->{}->{}->{}) : Void
		{
	/*		if (!Types.isAnonymous(ob)) return;*/
			for (field in Reflect.fields(new_ob)){
				var new_val = Reflect.field(new_ob, field);
				if (Reflect.hasField(ob, field)){
					var old_val = Reflect.field(ob, field);
					Reflect.setField(ob, field, f(field, old_val, new_val));
				} else{
					Reflect.setField(ob, field, new_val);
				}
			}

		}


	public static function merge(ob : {}, new_ob : {} ) : Void
		{
			mergef(ob, new_ob, function(key, old_v, new_v) return new_v );
		}

	static function _flatten(src : { }, cum : { fields : Array<String>, value : Dynamic }, arr : Array<{ fields : Array<String>, value : Dynamic }>, levels : Int, level : Int)
	{
		for (field in Reflect.fields(src))
		{
			var clone = Objects.clone(cum);
			var v = Reflect.field(src, field);
			clone.fields.push(field);
			if (Types.isAnonymous(v) && (levels == 0 || level+1 < levels))
			{
				_flatten(v, clone, arr, levels, level+1);
			} else {
				clone.value = v;
				arr.push(clone);
			}
		}
	}

	public static function flatten(src : { }, levels = 0) : Array<{ fields : Array<String>, value : Dynamic }>
	{
		var arr = [];
		for (field in Reflect.fields(src))
		{
			var v = Reflect.field(src, field);
			if (Types.isAnonymous(v) && levels != 1)
			{
				var item = {
					fields : [field],
					value : null
				};
				_flatten(v, item, arr, levels, 1);
			} else {
				arr.push({
					fields : [field],
					value : v
				});
			}
		}
		return arr;
	}

	public static function compare(a : { }, b : { } )
	{
		var v, fields;
		if ((v = Arrays.compare((fields = Reflect.fields(a)), Reflect.fields(b))) != 0)
			return v;
		for (field in fields)
		{
			if ((v = Dynamics.compare(Reflect.field(a, field), Reflect.field(b, field))) != 0)
				return v;
		}

		return 0;
	}

	public static function addFields(o : { }, fields : Array<String>, values : Array<Dynamic>)
	{
		for (i in 0...fields.length)
			addField(o, fields[i], values[i]);
		return o;
	}

	public static function addField(o : { }, field : String, value : Dynamic)
	{
		Reflect.setField(o, field, value);
		return o;
	}

	public static function format(v : Float, ?param : String, ?params : Array<String>, ?culture : Culture)
	{
		return formatf(param, params, culture)(v);
	}

	public static function formatf(?param : String, ?params : Array<String>, ?culture : Culture)
	{
		params = FormatParams.params(param, params, 'R');
		var format = params.shift();
		switch(format)
		{
			case 'O':
				return function(v) return Std.string(v);
			case 'R':
				return function(v)
				{
					var buf = [];
					for (field in Reflect.fields(v))
						buf.push(field + ":" + Dynamics.format(Reflect.field(v, field), culture));
					return "{" + buf.join(",") + "}";
				}
			default:
				return throw new Error("Unsupported number format: {0}", format);
		}
	}
}

typedef Entry = { key : String, value : Dynamic };

/* TODO

pluck_.pluck(list, propertyName)
A convenient version of what is perhaps the most common use-case for map: extracting a list of property values.

var stooges = [{name : 'moe', age : 40}, {name : 'larry', age : 50}, {name : 'curly', age : 60}];
_.pluck(stooges, 'name');
=> ["moe", "larry", "curly"]

defaults_.defaults(object, *defaults)
Fill in missing properties in object with default values from the defaults objects. As soon as the property is filled, further defaults will have no effect.

var iceCream = {flavor : "chocolate"};
_.defaults(iceCream, {flavor : "vanilla", sprinkles : "lots"});
=> {flavor : "chocolate", sprinkles : "lots"}

times_.times(n, iterator)
Invokes the given iterator function n times.

_(3).times(function(){ genie.grantWish(); });
*/