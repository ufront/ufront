import thx.culture.Culture;
import thx.error.Error;
import haxe.ds.StringMap;
import haxe.ds.IntMap;

/**
 * ...
 * @author Franco Ponticelli
 */

class Dynamics
{
	public static function format(v : Dynamic, ?param : String, ?params : Array<String>, ?nullstring : String, ?culture : Culture)
	{
		return formatf(param, params, nullstring, culture)(v);
	}

	public static function formatf(?param : String, ?params : Array<String>, nullstring = 'null', ?culture : Culture)
	{
		return function(v : Dynamic) : String
		{
			switch(Type.typeof(v)) {
				case TNull:
					return nullstring;
				case TInt:
					return Ints.format(v, param, params, culture);
				case TFloat:
					return Floats.format(v, param, params, culture);
				case TBool:
					return Bools.format(v, param, params, culture);
				case TClass(c):
					if(c == String) {
						return Strings.formatOne(v, param, params, culture);
					} else if (c == Array) {
						return Arrays.format(v, param, params, culture);
					} else if(c == Date) {
						return Dates.format(v, param, params, culture);
					} else {
						return Objects.format(v, param, params, culture);
					}
				case TObject:
					return Objects.format(v, param, params, culture);
				case TFunction:
					return "function()";
				default:
					return throw new Error("Unsupported type format: {0}", Type.typeof(v));
			}
		}
	}

	public static function interpolate(v : Float, a : Dynamic, b : Dynamic, ?equation : Float -> Float)
	{
		return interpolatef(a, b, equation)(v);
	}

	public static function interpolatef(a : Dynamic, b : Dynamic, ?equation : Float -> Float) : Float -> Dynamic
	{
		var ta = Type.typeof(a);
		var tb = Type.typeof(b);
		if (!(Floats.isNumeric(a) && Floats.isNumeric(b)) && !Type.enumEq(ta, tb))
			throw new Error("arguments a ({0}) and b ({0}) have different types", [a, b]);
		switch(ta)
		{
			case TNull: return function(_) return null;
			case TInt:
				if (Std.is(b, Int))
					return Ints.interpolatef(a, b, equation);
				else
					return Floats.interpolatef(a, b, equation);
			case TFloat: return Floats.interpolatef(a, b, equation);
			case TBool: return Bools.interpolatef(a, b, equation);
			case TObject: return Objects.interpolatef(a, b, equation);
			case TClass(c):
				var name = Type.getClassName(c);
				switch(name)
				{
					case "String": return Strings.interpolatef(a, b, equation);
					case "Date": return Dates.interpolatef(a, b, equation);
					default: throw new Error("cannot interpolate on instances of {0}", name);
				}
			default: throw new Error("cannot interpolate on functions/enums/unknown");
		}
	}

	public static function string(v : Dynamic)
	{
		switch(Type.typeof(v))
		{
			case TNull: return "null";
			case TInt: return Ints.format(v);
			case TFloat: return Floats.format(v);
			case TBool: return Bools.format(v);
			case TObject:
				var keys = Objects.keys(v);
				var result = [];
				for (key in keys)
					result.push(key + " : " + string(Reflect.field(v, key)));
				return "{" + result.join(", ") + "}";
			case TClass(c):
				var name = Type.getClassName(c);
				switch(name)
				{
					case "Array":
						return Arrays.string(v);
					case "String":
						var s : String = v;
						if (s.indexOf('"') < 0)
							return '"' + s + '"';
						else if (s.indexOf("'") < 0)
							return "'" + s + "'";
						else
							return '"' + StringTools.replace(s, '"', '\\"') + '"';
					case "Date":
						return Dates.format(v);
					default:
						return Std.string(v);
				}
			case TEnum(_):
				return Enums.string(v);
			case TUnknown:
				return "<unknown>";
			case TFunction:
				return "<function>";
		}
	}

	/**
	 * @todo add compare over comparison method for custom classes
	 */
	public static function compare(a : Dynamic, b : Dynamic)
	{
		if (null == a && null == b)
			return 0;
		if (null == a)
			return -1;
		if (null == b)
			return 1;
		switch(Type.typeof(a))
		{
			case TInt, TFloat: return Floats.compare(a, b);
			case TBool: return Bools.compare(a, b);
			case TObject: return Objects.compare(a, b);
			case TClass(c):
				var name = Type.getClassName(c);
				switch(name)
				{
					case "Array":
						return Arrays.compare(a, b);
					case "String":
						return Strings.compare(a, b);
					case "Date":
						return Dates.compare(a, b);
					default:
						return Strings.compare(Std.string(a), Std.string(b));
				}
			case TEnum(_):
				return Enums.compare(a, b);
			default:
				return 0;
		}
	}

	public static function comparef(sample : Dynamic) : Dynamic -> Dynamic -> Int
	{
		switch(Type.typeof(sample))
		{
			case TInt, TFloat: return Floats.compare;
			case TBool: return Bools.compare;
			case TObject: return Objects.compare;
			case TClass(c):
				var name = Type.getClassName(c);
				switch(name)
				{
					case "Array":
						return Arrays.compare;
					case "String":
						return Strings.compare;
					case "Date":
						return Dates.compare;
					default:
						return function(a, b) return Strings.compare(Std.string(a), Std.string(b));
				}
			case TEnum(_):
				return Enums.compare;
			default:
				return Dynamics.compare;
		}
	}

	public static function clone(v : Dynamic, cloneInstances = false)
	{
		switch(Type.typeof(v))
		{
			case TNull:
				return null;
			case TInt, TFloat, TBool, TEnum(_), TUnknown, TFunction:
				return v;
			case TObject:
				var o = { };
				Objects.copyTo(v, o);
				return o;
			case TClass(c):
				var name = Type.getClassName(c);
				switch(name)
				{
					case "Array":
						var src : Array<Dynamic> = v,
							a = [];
						for (i in src)
							a.push(Dynamics.clone(i));
						return a;
					case "String", "Date":
						return v;
					default:
						if(cloneInstances)
						{
							var o = Type.createEmptyInstance(c);
							for (field in Reflect.fields(v))
								Reflect.setField(o, field, clone(Reflect.field(v, field)));
							return o;
						} else {
							return v;
						}
				}
		}
	}

	public static function same<T1, T2>(a : T1, b : T2) : Bool
	{
		var ta = Types.typeName(a),
			tb = Types.typeName(b);

		if(ta != tb)
			return false;
		switch(Type.typeof(a))
		{
			case TFloat:
				return Floats.equals(cast a, cast b);
			case TNull, TInt, TBool:
				return untyped a == b;
			case TFunction:
				return Reflect.compareMethods(a, b);
			case TClass(c):
				var ca = Type.getClassName(c),
					cb = Type.getClassName(Type.getClass(b));
				if (ca != cb)
					return false;

				// string
				if (Std.is(a, String) && untyped a != b)
					return false;

				// arrays
				if (Std.is(a, Array))
				{
					var aa : Array<Dynamic> = cast a,
						ab : Array<Dynamic> = cast b;
					if (aa.length != ab.length)
						return false;
					for (i in 0...aa.length)
						if (!same(aa[i], ab[i]))
							return false;
					return true;
				}

				// date
				if(Std.is(a, Date))
					return untyped a.getTime() == b.getTime();

				// Map, StringMap, IntMap
				if (Std.is(a, Map) || Std.is(a, StringMap) || Std.is(a, IntMap))
				{
					var ha : Map<String, Dynamic> = cast a,
						hb : Map<String, Dynamic> = cast b;
					var ka = Iterators.array(ha.keys()),
						kb = Iterators.array(hb.keys());
					if (ka.length != kb.length)
						return false;
					for (key in ka)
						if (!hb.exists(key) || !same(ha.get(key), hb.get(key)))
							return false;
					return true;
				}

				// iterator or iterable
				var t = false;
				if ((t = Iterators.isIterator(a)) || Iterables.isIterable(a))
				{
					var va = t ? Iterators.array(cast a) : Iterables.array(cast a),
						vb = t ? Iterators.array(cast b) : Iterables.array(cast b);
					if (va.length != vb.length)
						return false;

					for (i in 0...va.length)
						if (!same(va[i], vb[i]))
							return false;
					return true;
				}

				// custom class
				var fields = Type.getInstanceFields(Type.getClass(a));
				for (field in fields)
				{
					var va = Reflect.field(a, field);
					if (Reflect.isFunction(va))
						continue;
					var vb = Reflect.field(b, field);
					if(!same(va, vb))
						return false;
				}
				return true;

			case TEnum(e) :
				var ea  = Type.getEnumName(e),
					teb = Type.getEnum(cast b),
					eb  = Type.getEnumName(teb);
				if (ea != eb)
					return false;

				if (Type.enumIndex(cast a) != Type.enumIndex(cast b))
					return false;
				var pa = Type.enumParameters(cast a),
					pb = Type.enumParameters(cast b);
				for (i in 0...pa.length)
					if (!same(pa[i], pb[i]))
						return false;
				return true;
			case TObject  :
				// anonymous object
				var fa = Reflect.fields(a),
					fb = Reflect.fields(b);
				for (field in fa)
				{
					fb.remove(field);
					if (!Reflect.hasField(b, field))
						return false;
					var va = Reflect.field(a, field);
					if(Reflect.isFunction(va))
						continue;
					var vb = Reflect.field(b, field);
					if(!same(va, vb))
						return false;
				}
				if (fb.length > 0)
					return false;

				// iterator
				var t = false;
				if ((t = Iterators.isIterator(a)) || Iterables.isIterable(a))
				{
					if (t && !Iterators.isIterator(b))
						return false;
					if (!t && !Iterables.isIterable(b))
						return false;


					var aa = t ? Iterators.array(cast a) : Iterables.array(cast a);
					var ab = t ? Iterators.array(cast b) : Iterables.array(cast b);
					if (aa.length != ab.length)
						return false;
					for (i in 0...aa.length)
						if (!same(aa[i], ab[i]))
							return false;
					return true;
				}
				return true;
			case TUnknown :
				return throw "Unable to compare two unknown types";
		}
		return throw new Error("Unable to compare values: {0} and {1}", [a, b]);
	}

	#if js inline #end public static function number(v : Dynamic) : Float
	{
#if js
		return untyped __js__("Number")(v);
#else
		if (Std.is(v, Bool))
			return v == true ? 1 : 0;
		else if (Std.is(v, Date))
			return v.getTime();
		else if (Std.is(v, String))
			return Std.parseFloat(v);
		else
			return Math.NaN;
#end
	}
}