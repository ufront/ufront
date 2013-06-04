package thx.math.scale;

/**
 * Based on D3.js by Michael Bostock
 * @author Franco Ponticelli
 * @todo update to version 1.16 (from 1.11)
 */

import thx.math.Const;

using Arrays;

class Linear extends NumericScale<Linear>
{
	var m : Int;
	public function new()
	{
		super();
		m = 10;
	}

	public function getModulo() : Float return m;
	public function modulo(m : Int) : Linear
	{
		this.m = m;
		return _this();
	}

	public function tickRange()
	{
		var start = Arrays.min(_domain),
			stop = Arrays.max(_domain),
			span = stop - start,
			step = Math.pow(10, Math.floor(Math.log(span / m) / Const.LN10)),
			err = m / (span / step);
		if (err <= .15)
			step *= 10;
		else if (err <= .35)
			step *= 5;
		else if (err <= .75)
			step *= 2;

		return {
			start : Math.ceil(start / step) * step,
			stop : Math.floor(stop / step) * step + step * .5,
			step : step
		};
	}

	override public function ticks() : Array<Float>
	{
		var range = tickRange();
		return Floats.range(range.start, range.stop, range.step);
	}

	override public function tickFormat(v : Float, ?i : Int) : String
	{
		var n = Math.max(0, -Math.floor(Math.log(tickRange().step) / Const.LN10 + .01));
		return Floats.format(v, "D:"+n);
	}
}