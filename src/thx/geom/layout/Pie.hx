/**
 * Based on D3.js by Michael Bostock
 * @author Franco Ponticelli
 */

package thx.geom.layout;
import thx.math.Const;

using Arrays;

class Pie<T>
{
	var _startAngle : Array<T> -> Int -> Float;
	var _endAngle : Array<T> -> Int -> Float;
	var _sort : T -> T -> Int;
	var _value : T -> Int -> Float;

	public function new()
	{
		_startAngle = function(_,_) return 0.0;
		_endAngle = function(_, _) return Const.TWO_PI;
		_sort = null;
		_value = function(d, _) return Dynamics.number(d);
	}

	public function pie(data : Array<T>, ?i : Int)
	{
		var a = _startAngle(data, i),
			k = _endAngle(data, i) - a;

		var index = Ints.range(data.length);
		if (_sort != null)
		{
			var s = _sort;
			index.sort(function(i, j) {
				return s(data[i], data[j]);
			});
		}

		var values = Arrays.map(data, _value);

		k /= values.reduce(function(p, d, _) return p + d, 0.0);
		if (!Math.isFinite(k))
			k = 0;
		var d;
		var arcs = Arrays.map(index, function(_, i) {
			d = values[i];
			return {
				value : d,
				startAngle : a,
				endAngle : a += d * k
			}
		});

		return Arrays.map(data, function(d, i) {
			return arcs[index[i]];
		});
	}

	public function getStartAngle() return _startAngle;
	public function startAngle(v : Float) return startAnglef(function(_, _) return v);
	public function startAnglef(v : Array<T> -> Int -> Float)
	{
		_startAngle = v;
		return this;
	}

	public function getEndAngle() return _endAngle;
	public function endAngle(v : Float) return endAnglef(function(_, _) return v);
	public function endAnglef(v : Array<T> -> Int -> Float)
	{
		_endAngle = v;
		return this;
	}

	public function getSort() return _sort;
	public function sort(v : T -> T -> Int)
	{
		_sort = v;
		return this;
	}

	public function getValue() return _value;
	public function valuef(v : T -> Int -> Float)
	{
		_value = v;
		return this;
	}
}