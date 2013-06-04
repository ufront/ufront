package thx.math.scale;
import thx.math.Const;

/**
 * Based on D3.js by Michael Bostock
 * @author Franco Ponticelli
 * @todo add clamp/clampMin/clampMax
 */

using Arrays;

class Pow extends NumericScale<Pow>
{
	var tick : Linear;
	var _exponent : Float;
	var powp : Float -> Float;
	var powb : Float -> Float;

	public function new()
	{
		super();
		tick = new Linear();
		_exponent = 1;
		powb = powp = function(v) return v;
	}
	
	override public function scale(x : Float)
	{
		return super.scale(powp(x));
	}
	
	override public function invert(x : Float)
	{
		return powb(super.invert(x));
	}
	
	override public function getDomain() {
		var me = this;
		return super.getDomain().map(function(d) return me.powb(d));
	}
	
	override public function domain(d : Array<Float>)
	{
		var pow : Float -> (Float -> Float) = (Arrays.min(d) < 0 ? _pown : _pow);
		powp = pow(_exponent);
		powb = pow(1.0 / _exponent);
		super.domain([powp(d[0]), powp(d[1])]);
		tick.domain(d);
		return this;
	}

	override public function ticks()
	{
		return tick.ticks();
	}
	
	override public function tickFormat(v : Float, ?i : Int)
	{
		return tick.tickFormat(v, i);
	}
	
	public function getModulo() return tick.getModulo();
	public function modulo(v : Int)
	{
		tick.modulo(v);
		return this;
	}
	
	public function getExponent()
	{
		return _exponent;
	}
	
	public function exponent(x : Float)
	{
		var d = getDomain();
		_exponent = x;
		domain(d);
		return this;
	}
	
	public static function sqrt()
	{
		return new Pow().exponent(.5);
	}
	
	static function _pow(e : Float) : Float -> Float
	{
		return function(v : Float) return Math.pow(v, e);
	}
	
	static function _pown(e : Float) : Float -> Float
	{
		return function(v : Float) return -Math.pow(-v, e);
	}
}