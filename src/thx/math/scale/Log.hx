package thx.math.scale;
import thx.math.Const;

/**
 * Based on D3.js by Michael Bostock
 * @author Franco Ponticelli
 * @todo add clamp/clampMin/clampMax
 */

using Arrays;

class Log extends NumericScale<Log>
{
	static function _log(x : Float)
	{
		return Math.log(x) / Const.LN10;
	}
	
	static function _logn(x : Float)
	{
		return -Math.log(-x) / Const.LN10;
	}
	
	static function _pow(x : Float)
	{
		return Math.pow(10, x);
	}
	
	static function _pown(x : Float)
	{
		return -Math.pow(10, -x);
	}
	
	var log : Float -> Float;
	var pow : Float -> Float;

	public function new()
	{
		super();
		log = _log;
		pow = _pow;
	}
	
	override public function scale(x : Float)
	{
		return super.scale(log(x));
	}
	
	override public function invert(x : Float)
	{
		return pow(super.invert(x));
	}
	
	override public function getDomain() {
		var me = this;
		return super.getDomain().map(function(d) return me.pow(d));
	}
	
	override public function domain(d : Array<Float>)
	{
		if (Arrays.min(d) < 0) {
			log = _logn;
			pow = _pown;
		} else {
			log = _log;
			pow = _pow;
		}
		return super.domain([log(d[0]), log(d[1])]);
	}
	
	override public function ticks()
	{
		var d = super.getDomain(),
			ticks = [];
		if (d.every(function(d,_) return Math.isFinite(d))) {
			var i = Math.floor(d[0]),
				j = Math.ceil(d[1]),
				u = pow(d[0]),
				v = pow(d[1]);
			if (Reflect.compareMethods(log, _logn))
			{
				ticks.push(pow(i));
				while (i++ < j)
				{
					var k = 9;
					do
					{
						ticks.push(pow(i) * k);
					} while (k-- > 0);
				}
			} else {
				do
				{
					for (k in 1...10)
						ticks.push(pow(i) * k);
				} while (i++ < j);
				ticks.push(pow(i));
			}

			i = 0;
			while (ticks[i] < u) i++; // strip small values
			j = ticks.length;
			while (ticks[j - 1] > v) j--; // strip big values
			ticks = ticks.slice(i, j);
		}
		return ticks;
	}
	
	override public function tickFormat(v : Float, ?i : Int) : String
	{
		return thx.culture.FormatNumber.decimal(v, 1);
	}
}