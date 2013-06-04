import Type;

class Types
{
	inline public static function className(o : Dynamic)
	{
		return fullName(o).split('.').pop();
	}

	inline public static function fullName(o : Dynamic)
	{
		return Type.getClassName(Type.getClass(o));
	}

	public static function typeName(o : Dynamic) : String
	{
		return switch(Type.typeof(o))
		{
			case TNull    : "null";
			case TInt     : "Int";
			case TFloat   : "Float";
			case TBool    : "Bool";
			case TFunction: "function";
			case TClass(c): Type.getClassName(c);
			case TEnum(e) : Type.getEnumName(e);
			case TObject  : "Object";
			case TUnknown : "Unknown";
		}
	}

	public static function hasSuperClass(type : Class<Dynamic>, sup : Class<Dynamic>)
	{
		while(null != type)
		{
			if(type == sup)
				return true;
			type = Type.getSuperClass(type);
		}
		return false;
	}

	public static inline function isAnonymous(v : Dynamic) : Bool
	{
		return Reflect.isObject(v) && null == Type.getClass(v);
	}

	static public #if !php inline #end function as<T1, T2>(value : T1, type : Dynamic) : Null<T2>
	{
		return (Std.is(value, type) ? cast value : null);
	}

	static public function ifIs<T1, T2>(value : T1, type : Class<T2>, handler : T2 -> Void) : T1
	{
		if (Std.is(value, type))
			handler(cast value);
		return value;
	}

	static public inline function of<T>(type : Dynamic, value : Dynamic) : Null<T>
	{
		return (Std.is(value, type) ? cast value : null);
	}

	public static function sameType(a : Dynamic, b : Dynamic) : Bool
	{
		if (null == a && b == null) return true;
		if (null == a || b == null) return false;
		var tb = Type.typeof(b);
		switch(tb)
		{
			case TClass(c):
				return Std.is(a, c);
			case TEnum(e):
				return Std.is(a, e);
			default:
				return Type.typeof(a) == tb;
		}
	}

	public static function isPrimitive(v : String)
	{
		return switch(Type.typeof(v))
		{
			case TNull, TInt, TFloat, TBool: true;
			case TFunction, TEnum(_), TObject, TUnknown : false;
			case TClass(c): Type.getClassName(c) == "String";
		}
	}
}