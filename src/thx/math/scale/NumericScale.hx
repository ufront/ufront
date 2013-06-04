package thx.math.scale;

/**
 * Based on D3.js by Michael Bostock
 * @author Franco Ponticelli
 */

import thx.error.AbstractMethod;
using Arrays;

class NumericScale<This> implements IScale<Float, Float>
{
	var _domain : Array<Float>;
	var _range : Array<Float>;

	var f : Float -> Float -> (Float -> Float) -> (Float -> Float);
	var _clamp : Bool;
	var _output : Float -> Float;
	var _input : Float -> Float;
	public function new()
	{
		_domain = [0.0, 1.0];
		_range = [0.0, 1.0];

		f = Floats.interpolatef;
		_clamp = false;
		rescale();
	}

	function rescale()
	{
		var linear = _domain.length == 2 ? scaleBilinear : scalePolylinear,
			uninterpolate = _clamp ? Floats.uninterpolateClampf : Floats.uninterpolatef;
		_output = linear(_domain, _range, uninterpolate, f);
		_input = linear(_range, _domain, uninterpolate, Floats.interpolatef);
		return _this();
	}

	public function scale(x : Float) : Float
	{
		return _output(x);
	}

	public function invert(y : Float) : Float
	{
		return _input(y);
	}

	public function getDomain() : Array<Float> return _domain;
	public function domain(d : Array<Float>) : This
	{
		_domain = d;
		return rescale();
	}

	public function getRange() : Array<Float> return _range;
	public function range(r : Array<Float>) : This
	{
		_range = r;
		return rescale();
	}

	public function rangeRound(r : Array<Float>) : This
	{
		range(r);
		interpolatef(Ints.interpolatef);
		return _this();
	}

	public function getInterpolate() : Float -> Float -> (Float -> Float) -> (Float -> Float) return f;
	public function interpolatef(x : Float -> Float -> (Float -> Float) -> (Float -> Float)) : This
	{
		f = x;
		return rescale();
	}

	public function getClamp() : Bool return _clamp;
	public function clamp(v : Bool) : This
	{
		this._clamp = v;
		return rescale();
	}

	public function ticks() : Array<Float>
	{
		return throw new AbstractMethod();
	}

	public function tickFormat(v : Float, ?i : Int) : String
	{
		return throw new AbstractMethod();
	}

	public function transform(scale : Float, t : Float, a : Float, b : Float) : This
	{
		var range = getRange().map(function(v) return (v - t) / scale);
		domain([a, b]);
		var r = range.map(invert);
		domain(r);
		return _this();
	}

	inline function _this() : This return cast this;

	static function scaleBilinear(domain : Array<Float>, range : Array<Float>, uninterpolate : Float -> Float -> (Float -> Float), interpolate : Float -> Float -> (Float -> Float) -> (Float -> Float))
	{
		var u = uninterpolate(domain[0], domain[1]),
			i = interpolate(range[0], range[1], null);
		return function(x : Float) return i(u(x));
	}

	static function scalePolylinear(domain : Array<Float>, range : Array<Float>, uninterpolate : Float -> Float -> (Float -> Float), interpolate : Float -> Float -> (Float -> Float) -> (Float -> Float))
	{
		var u = [],
			i = [];
		for (j in 1...domain.length)
		{
			u.push(uninterpolate(domain[j - 1], domain[j]));
			i.push(interpolate(range[j - 1], range[j], null));
		}

		return function(x)
		{
			var j = Arrays.bisect(domain, x, 1, domain.length - 1) - 1;
			return i[j](u[j](x));
		}
	}
}