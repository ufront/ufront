/**
 * Based on D3.js by Michael Bostock
 */
package thx.math.scale;

import thx.collection.IntHashList;
using Arrays;

class Ordinal<TDomain, TRange> implements IScale<TDomain, TRange>
{
	var _domain : Array<TDomain>;
	var _range : Array<TRange>;
	public var rangeBand(default, null) : Float;

	public function new()
	{
		_domain = [];
		_range = [];
		rangeBand = 0.0;
	}

	public function scale(x : TDomain) : TRange
	{
		var i = _domain.indexOf(x);
		if (i < 0)
		{
			_domain.push(x);
			i = _domain.length -1;
		}
		return _range[i];
	}

	public function getDomain() return _domain.copy();
	public function domain(x : Array<TDomain>)
	{
		_domain = x.copy();
		return this;
	}

	public function getRange() return _range.copy();
	public function range(a : Array<TRange>)
	{
		_range = a.copy();
		return this;
	}

	public function rangePoints(start : Float, stop : Float, padding = 0.0)
	{
		var step = (stop - start) / (_domain.length - 1 + padding);
		var range = _domain.length == 1
			? [(start + stop) / 2]
			: Floats.range(start + step * padding / 2, stop + step / 2, step);
		var ordinal = new Ordinal().domain(_domain).range(range);
		ordinal.rangeBand = 0;
		return ordinal;
	}

	public function rangeBands(start : Float, stop : Float, padding = 0.0)
	{
		var step = (stop - start) / (_domain.length + padding);
		var range = Floats.range(start + step * padding, stop, step);
		var ordinal = new Ordinal().domain(_domain).range(range);
		ordinal.rangeBand = step * (1 - padding);
		return ordinal;
	}

	public function rangeRoundBands(start : Int, stop : Int, padding = 0.0)
	{
		var diff = stop - start,
			step = Math.floor(diff / (_domain.length + padding)),
			err = diff - (_domain.length - padding) * step;
		var range = Ints.range(start + Math.round(err / 2), stop, step);
		var ordinal = new Ordinal().domain(_domain).range(range);
		ordinal.rangeBand = Math.round(step * (1 - padding));
		return ordinal;
	}
}