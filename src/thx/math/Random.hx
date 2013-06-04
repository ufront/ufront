package thx.math;

/**
 * Adapted from Nicolas Cannasse code.
 *
 * @author Franco Ponticelli
 * @author Nicolas Cannasse
 */

class Random
{
	public var seed : Int;

	public function new(seed = 1)
	{
		this.seed = seed;
	}

	public inline function int() : Int
	{
#if neko
		return untyped __dollar__int( seed = (seed * 16807.0) % 2147483647.0 ) & 0x3FFFFFFF;
#elseif flash9
		return (seed = Std.int((seed * 16807.0) % 2147483647.0)) & 0x3FFFFFFF;
#else
		return (seed = (seed * 16807) % 0x7FFFFFFF) & 0x3FFFFFFF;
#end
	}

	public inline function float() : Float
	{
		return int() / 1073741823.0; // divided by 2^30-1
	}
}