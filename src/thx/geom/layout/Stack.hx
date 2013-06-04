/**
 * Based on D3.js by Michael Bostock
 * @author Franco Ponticelli
 * @todo update to version 1.16 (from 1.11)
 */

package thx.geom.layout;

using Arrays;

class Stack
{
	var _order : StackOrder;
	var _offset : StackOffset;
	public function new()
	{
		_order = DefaultOrder;
		_offset = ZeroOffset;
	}

	public function stack(data : Array<Array<Point>>) : Array<Array<Point0>>
	{
		var n = data.length,
			m = data[0].length,
			i,
			j,
			y0,
			result = [];

		// copy
		for (i in 0...n)
		{
			var r = [];
			result.push(r);
			for (j in 0...m)
			{
				var s = data[i][j];
				r[j] = { x : s.x, y : s.y, y0 : 0.0 };
			}
		}

		var index = getStackOrder(_order, result);
		getStackOffset(_offset, index, result);

		for (j in 0...m)
		{
			y0 = result[index[0]][j].y0;
			for (i in 1...n)
			{
				result[index[i]][j].y0 = y0 += result[index[i - 1]][j].y;
			}
		}
		return result;
	}

	public function getOrder() return _order;
	public function order(x : StackOrder)
	{
		_order = x;
		return this;
	}

	public function getOffset() return _offset;
	public function offset(x : StackOffset)
	{
		_offset = x;
		return this;
	}

	static function getStackOrder(order : StackOrder, data : Array<Array<Point0>>)
	{
		switch(order)
		{
			case DefaultOrder:
				return Ints.range(data.length);
			case InsideOut:
				var n = data.length,
					max = Arrays.map(data, stackMaxIndex),
					sums = Arrays.map(data, stackReduceSum),
					index = Ints.range(n),
					top = 0.0,
					bottom = 0.0,
					tops = [],
					bottoms = [];
				index.sort(function(a, b) return max[a] - max[b]);
				for (i in 0...n)
				{
					var j = index[i];
					if (top < bottom)
					{
						top += sums[j];
						tops.push(j);
					} else {
						bottom += sums[j];
						bottoms.push(j);
					}
				}
				bottoms.reverse();
				return bottoms.concat(tops);
			case ReverseOrder:
				var index = Ints.range(data.length);
				index.reverse();
				return index;
		}
	}

	static function getStackOffset(offset : StackOffset, index : Array<Int>, data : Array<Array<Point0>>)
	{
		switch(offset)
		{
			case Silhouette:
				var n = data.length,
					m = data[0].length,
					sums = [],
					max = 0.0,
					o;
				for (j in 0...m)
				{
					o = 0.0;
					for (i in 0...n)
						o += data[i][j].y;
					if (o > max)
						max = o;
					sums.push(o);
				}
				var i = index[0];
				for (j in 0...m)
					data[i][j].y0 = (max - sums[j]) / 2;
			case Wiggle:
				var n = data.length,
					x = data[0],
					m = x.length,
					max = 0.0,
					k,
					ii,
					ik,
					i0 = index[0],
					s1,
					s2,
					s3,
					dx,
					o,
					o0;
				data[i0][0].y0 = o = o0 = 0.0;
				for (j in 1...m)
				{
					s1 = 0.0;
					for (i in 0...n)
						s1 += data[i][j].y;
					s2 = 0.0;
					dx = x[j].x - x[j - 1].x;
					for (i in 0...n)
					{
						ii = index[i];
						s3 = (data[ii][j].y - data[ii][j - 1].y) / (2 * dx);
						for (k in 0...i)
						{
							s3 += (data[ik = index[k]][j].y - data[ik][j - 1].y) / dx;
						}
						s2 += s3 * data[ii][j].y;
					}
					data[i0][j].y0 = o -= s1 != 0? s2 / s1 * dx : 0;
					if (o < o0)
						o0 = o;
				}
				for (j in 0...m)
					data[i0][j].y0 -= o0;
			case ZeroOffset:
				var m = data[0].length,
					i0 = index[0];
				for (j in 0...m)
				{
					data[i0][j].y0 = 0.0;
				}
		}
	}

	static function stackMaxIndex(data : Array<Point0>, _)
	{
		var j = 0,
			v = data[0].y,
			k,
			n = data.length;
		for (i in 1...n)
		{
			if ((k = data[i].y) > v)
			{
				j = i;
				v = k;
			}
		}
		return j;
	}

	static function stackReduceSum(data : Array<Point0>, _) : Float
	{
		return data.reduce(stackSum, 0.0);
	}

	static function stackSum(p : Float, c : Point0, i : Int) : Float
	{
		return p + c.y;
	}
}

private typedef Point = {
	x : Float,
	y : Float
}

private typedef Point0 = {> Point,
	y0 : Float
}

enum StackOrder
{
	DefaultOrder;
	InsideOut;
	ReverseOrder;
}

enum StackOffset
{
	Silhouette;
	Wiggle;
	ZeroOffset;
}