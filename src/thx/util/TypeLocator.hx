package thx.util;

/**
 * ...
 * @author Franco Ponticelli
 */

class TypeLocator
{
	var _binders : Map<String, Void -> Dynamic>;
	public function new()
	{
		_binders = new Map ();
	}

	public function instance<T>(cls : Class<T>, o : T)
	{
		return bind(cls, function() return o);
	}

	public function bind<T>(cls : Class<T>, f : Void -> T)
	{
		_binders.set(Type.getClassName(cls), f);
		return this;
	}

	public function memoize<T>(cls : Class<T>, f : Void -> T)
	{
		var r = null;
		return bind(cls, function() {
			if (null == r)
				r = f();
			return r;
		});
	}

	public dynamic function unbinded<T>(cls : Class<T>) : Null<T>
	{
		return null;
	}

	public function get<T>(cls : Class<T>) : Null<T>
	{
		var f = _binders.get(Type.getClassName(cls));
		if (null == f)
			return unbinded(cls);
		else
			return f();
	}
}