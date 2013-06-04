package thx.type;

import haxe.rtti.Meta;

class Metas
{
	public static function getFieldInfo(cls : Class<Dynamic>, field : String)
	{
		var fields = Meta.getFields(cls);
		if(null == fields)
			return null;
		else
			return Reflect.field(fields, field);
	}
}
