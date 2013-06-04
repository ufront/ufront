/**
 * ...
 * @author Franco Ponticelli
 */

class DynamicsT
{
	public static function toHash<T>(ob : Dynamic<T>) : Map<String, T>
	{
		var Map  = new Map ();
		return copyToHash(ob, Map );
	}

	public static function copyToHash<T>(ob : Dynamic<T>, hash : Map<String, T>) : Map<String, T>
	{
		for (field in Reflect.fields(ob))
			hash.set(field, Reflect.field(ob, field));
		return hash;
	}
}