package thx.type;

import thx.error.Error;
import haxe.rtti.CType;

class Rttis
{
	public static function typeName(type : CType, opt : Bool) : String
	{
		switch(type)
		{
			case CFunction(_,_):
				return opt ? "Null<function>" : "function";
			case CUnknown:
				return opt ? "Null<unknown>" : "unknown";
			case CAnonymous(_), CDynamic(_):
				return opt ? "Null<Dynamic>" : "Dynamic";
			case CTypedef(name, params), CAbstract(name, params):
				if(name == "Null")
				{
					if(opt)
					{
						var t = name;
						if(params != null && params.length > 0)
						{
							var types = [];
							for(p in params)
								types.push(typeName(p, false));
							t += '<'+types.join(',')+'>';
						}
						return t;
					} else {
						return typeName(params.first(), false);
					}
				} else {
					var t = name;
					if(params != null && params.length > 0)
					{
						var types = [];
						for(p in params)
							types.push(typeName(p, false));
						t += '<'+types.join(',')+'>';
					}
					return opt ? 'Null<'+t+'>' : t;
				}
			case CEnum(name, params), CClass(name, params):
				var t = name;
				if(params != null && params.length > 0)
				{
					var types = [];
					for(p in params)
						types.push(typeName(p, false));
					t += '<'+types.join(',')+'>';
				}
				return opt ? 'Null<'+t+'>' : t;
		}
	}

	public static function typePath(type : CType)
	{
		switch(type)
		{
			case CFunction(_,_), CUnknown, CAnonymous(_), CDynamic(_), CTypedef(_, _), CAbstract(_, _):
				return null;
			case CEnum(name, _), CClass(name, _):
				return name;
		}
	}

	public static function methodArgumentTypes(cls : Class<Dynamic>, method : String) : Null<Array<String>>
	{
		var fields = getClassFields(cls);
		if(null == fields) return null;
		var field = fields.get(method);
		if(null == field) return null;
		var result = [];
		for(arg in methodArguments(field))
			result.push(typeName(arg.t, arg.opt));
		return result;
	}

	public static function methodArguments(field : ClassField)
	{
		switch(field.type)
		{
			case CFunction(args, _):
			    return Lambda.array(args);
			default:
				return null;
		}
	}

	public static function methodReturnType(field : ClassField)
	{
		switch(field.type)
		{
			case CFunction(_, ret):
				return ret;
			default:
				return null;
		}
	}

	public static function argumentAcceptNull(arg : {name : String, opt : Bool, t : CType})
	{
		if(arg.opt)
			return true;
		switch(arg.t)
		{
			case CTypedef(n, _):
				return "Null" == n;
			default:
				return false;
		}
	}

	public static function getClassFields(cls : Class<Dynamic>)
	{
		return unifyFields(getClassDef(cls));
	}

	public static function typeParametersMap(cls : Class<Dynamic>, ?Map  : Map<String, CType>)
	{
		if(null == Map )
			Map  = new Map ();
		var c = getClassDef(cls);
		if (null != c.superClass)
		{
			var sp = c.superClass.path;
			var sc = Type.resolveClass(sp);
			typeParametersMap(sc, Map );
			var s = getClassDef(sc);

			var i = 0;
			for (param in c.superClass.params)
				Map .set(sp + "." + s.params[i++], param);
		}
		return Map ;
	}

	public static function unifyFields(cls : Classdef, ?h : Map<String, ClassField>) : Map<String, ClassField>
	{
		if(h == null)
			h = new Map ();
		for(f in cls.fields)
			if(!h.exists(f.name))
				h.set(f.name, f);
		var parent = cls.superClass;
		if(parent != null)
		{
			var pcls = Type.resolveClass(parent.path);
			var x = Xml.parse(untyped pcls.__rtti).firstElement();
			switch(new haxe.rtti.XmlParser().processElement(x))
			{
				case TClassdecl(c):
			   		unifyFields(c, h);
				default:
					throw new Error("Invalid type parent type ({0}) for class: {1}", [parent.path, cls]);
			}
		}
		return h;
	}

	public static function hasInfo(cls : Class<Dynamic>) : Bool
	{
		return null != untyped cls.__rtti;
	}

	static var _cache = new Map ();
	public static function getClassDef(cls : Class<Dynamic>)
	{
		var name = Type.getClassName(cls);
		if (_cache.exists(name))
			return _cache.get(name);

		var x = Xml.parse(untyped cls.__rtti).firstElement();
		var infos = new haxe.rtti.XmlParser().processElement(x);

		switch(infos)
		{
			case TClassdecl(c):
				_cache.set(name, c);
				return c;
			default:
				return throw new Error("not a class!");
		}
	}

	public static function isMethod(field : ClassField)
	{
		return switch(field.type)
		{
			case CFunction(_, _): true;
			default: false;
		}
	}
}