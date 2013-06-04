package thx.math.scale;

/**
 * Based on D3.js by Michael Bostock
 * @author Franco Ponticelli
 */

class LinearT<T> implements IScale<Float, T>
{
	static function _f<T>(_ : T, _ : T, ?_ : Float -> Float) : Float -> T
	{
		return function(_ : Float) return null;
	}
	
	var _domain : Array<Float>;
	var _range : Array<T>;
	
	var f : T -> T -> (Float -> Float) -> (Float -> T);
	var _clamp : Bool;
	var _output : Float -> T;
	public function new()
	{
		_domain = [0.0, 1.0];
		_range = null;
		f = _f;
		_clamp = false;
		rescale();
	}
	
	function rescale()
	{
		if (null == _range)
			return this;
		var linear = _domain.length == 2 ? scaleBilinear : scalePolylinear,
			uninterpolate = _clamp ? Floats.uninterpolateClampf : Floats.uninterpolatef;
		_output = linear(_domain, _range, uninterpolate, f);
		return this;
	}
	
	public function scale(x : Float) : T
	{
		return _output(x);
	}

	public function getDomain() : Array<Float> return _domain;
	public function domain(d : Array<Float>)
	{
		_domain = d;
		return rescale();
	}
	
	public function getRange() : Array<T> return _range;
	public function range(r : Array<T>)
	{
		_range = r;
		return rescale();
	}

	public function getInterpolate() : T -> T -> (Float -> Float) -> (Float -> T) return f;
	public function interpolatef(x : T -> T -> (Float -> Float) -> (Float -> T))
	{
		f = x;
		return rescale();
	}
	
	public function getClamp() : Bool return _clamp;
	public function clamp(v : Bool)
	{
		this._clamp = v;
		return rescale();
	}
	
	function tickRange(m : Float)
	{
		var start = Math.min(_domain[0], _domain[1]),
			stop = Math.max(_domain[0], _domain[1]),
			span = stop - start,
			step = Math.pow(10, Math.floor(Math.log(span / m) / Const.LN10)),
			err = m / (span / step);
		if (err <= .15)
			step *= 10;
		else if (err <= .35)
			step *= 5;
		else if (err <= -75)
			step *= 2;
		
		return {
			start : Math.ceil(start / step) * step,
			stop : Math.floor(stop / step) * step + step * .5,
			step : step
		};
	}
	
	public function ticks(m : Float)
	{
		var range = tickRange(m);
		return Floats.range(range.start, range.stop, range.step);
	}

	public function tickFormat(m : Float)
	{
		var n = Math.max(0, -Math.floor(Math.log(tickRange(m).step) / Const.LN10 + .01));
		return Floats.formatf("D:"+n);
	}
	
	static function scaleBilinear<T>(domain : Array<Float>, range : Array<T>, uninterpolate : Float -> Float -> (Float -> Float), interpolate : T -> T -> (Float -> Float) -> (Float -> T))
	{
		var u = uninterpolate(domain[0], domain[1]),
			i = interpolate(range[0], range[1], null);
		return function(x : Float) return i(u(x));
	}
	
	static function scalePolylinear<T>(domain : Array<Float>, range : Array<T>, uninterpolate : Float -> Float -> (Float -> Float), interpolate : T -> T -> (Float -> Float) -> (Float -> T))
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