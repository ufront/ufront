package thx.math.scale;

/**
 * Based on D3.js by Michael Bostock
 * @author Franco Ponticelli
 */
using Arrays;

class Quantile<TRange> implements IScale<Float, TRange>
{
	var _domain : Array<Float>;
	var _range : Array<TRange>;
	var _thresolds : Array<Float>;
	public function new()
	{
		_domain = [];
		_range = [];
		_thresolds = [];
	}

	function rescale()
	{
		var k = 0,
			n = _domain.length,
			q = _range.length,
			i,
			j;
		_thresolds[Ints.max(0, q - 2)] = 0.0;
		while (++k < q)
		{
			_thresolds[k - 1] = (0 != (j = n * k / q) % 1)
				? _domain[Std.int(~~j)]
				: (_domain[i = Std.int(~~j)] + _domain[i - 1]) / 2;
		}
	}

	public function scale(v : Float)
	{
//		if (Math.isNaN(v)) return Math.NaN;
		return _range[Arrays.bisect(_thresolds, v)];
	}

	public function getDomain() return _domain;

	public function domain(x : Array<Float>)
	{
		_domain = x.filter(function(d) return !Math.isNaN(d));
		_domain.sort(Floats.compare);
		rescale();
		return this;
	}

	public function getRange() return _range;
	public function range(x : Array<TRange>)
	{
		_range = x.copy();
		rescale();
		return this;
	}

	public function getQuantiles()
	{
		return function() return _thresolds.copy();
	}
}