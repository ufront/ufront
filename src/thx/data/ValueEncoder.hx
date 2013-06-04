/**
 * ...
 * @author Franco Ponticelli
 */

package thx.data;
import thx.error.Error;

class ValueEncoder
{
	var handler : IDataHandler;
	public function new(handler : IDataHandler)
	{
		this.handler = handler;
	}

	public function encode(o : Dynamic)
	{
		handler.start();
		encodeValue(o);
		handler.end();
	}

	function encodeValue(o : Dynamic)
	{
		switch(Type.typeof(o))
		{
			case TNull:
				handler.valueNull();
			case TInt:
				handler.valueInt(o);
			case TFloat:
				handler.valueFloat(o);
			case TBool:
				handler.valueBool(o);
			case TObject:
				encodeObject(o);
			case TFunction:
				throw new Error("unable to encode TFunction type");
			case TClass(c):
				if (Std.is(o, String))
					handler.valueString(o);
				else if (Std.is(o, Array))
					encodeArray(o);
				else if (Std.is(o, Date))
					handler.valueDate(o);
				else if (Std.is(o, Map ))
					encodeHash(o);
				else if (Std.is(o, List))
					encodeList(o);
				else
					// Custom Classes
					throw new Error("unable to encode class '{0}'", Type.getClassName(c));
			case TEnum(e):
				throw new Error("unable to encode TEnum type '{0}'", Type.getEnumName(e));
			case TUnknown:
				throw new Error("unable to encode TUnknown type");
		}
	}

	function encodeObject(o : { } )
	{
		handler.objectStart();
		for (key in Reflect.fields(o))
		{
			handler.objectFieldStart(key);
			encodeValue(Reflect.field(o, key));
			handler.objectFieldEnd();
		}
		handler.objectEnd();
	}

	function encodeHash(o : Map<String, Dynamic>)
	{
		handler.objectStart();
		for (key in o.keys())
		{
			handler.objectFieldStart(key);
			encodeValue(o.get(key));
			handler.objectFieldEnd();
		}
		handler.objectEnd();
	}

	function encodeList(list : List<Dynamic>)
	{
		handler.arrayStart();
		for (item in list)
		{
			handler.arrayItemStart();
			encodeValue(item);
			handler.arrayItemEnd();
		}
		handler.arrayEnd();
	}

	function encodeArray(a : Array<Dynamic>)
	{
		handler.arrayStart();
		for (item in a)
		{
			handler.arrayItemStart();
			encodeValue(item);
			handler.arrayItemEnd();
		}
		handler.arrayEnd();
	}
}