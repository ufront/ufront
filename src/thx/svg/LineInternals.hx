package thx.svg;

/**
 * Based on D3.js by Michael Bostock
 * @author Franco Ponticelli
 */

import thx.svg.LineInterpolator;

class LineInternals
{
	public static var arcOffset = -Math.PI / 2;
	public static var arcMax = 2 * Math.PI - 1e-6;

	public static function linePoints<TData>(data : Array<TData>, x : TData -> Int -> Float, y : TData -> Int -> Float)
	{
		var points = [],
			value : TData;
		for(i in 0...data.length)
		{
			value = data[i];
			points.push([
				x(value, i),
				y(value, i)
			]);
		}
		return points;
	}

	public static function interpolatePoints(points : Array<Array<Float>>, type : LineInterpolator)
	{
		if (null == type)
			type = Linear;
		var path = [],
			i = 0,
			n = points.length,
			p = points[0];
		switch(type)
		{
			case Linear:
				path.push(p[0] + "," + p[1]);
				while (++i < n)
				{
					p = points[i];
					path.push("L" + p[0] + "," + p[1]);
				}
			case Step:
				var p1;
				path.push(p[0] + "," + p[1]);
				while (++i < n-1)
				{
					p  = points[i];
					p1 = points[i+1];
					path.push("H" + (p[0]+p1[0])/2 + "V" + p[1]);
				}
				p = points[i];
				path.push("H" + p[0] + "V" + p[1]);
			case StepBefore:
				path.push(p[0] + "," + p[1]);
				while (++i < n)
				{
					p = points[i];
					path.push("V" + p[1] + "H" + p[0]);
				}
			case StepAfter:
				path.push(p[0] + "," + p[1]);
				while (++i < n)
				{
					p = points[i];
					path.push("H" + p[0] + "V" + p[1]);
				}
			case Basis:
				if (points.length < 3)
					return interpolatePoints(points, Linear);
				i = 1;
				p = points[1];
				var x0 = p[0],
					y0 = p[1],
					px = [x0, x0, x0, p[0]],
					py = [y0, y0, y0, p[1]];
				path.push(x0 + "," + y0);
				_lineBasisBezier(path, px, py);
				while (++i < n)
				{
					p = points[i];
					px.shift(); px.push(p[0]);
					py.shift(); py.push(p[1]);
					_lineBasisBezier(path, px, py);
				}
				i = -1;
				while (++i < 2) {
					px.shift(); px.push(p[0]);
					py.shift(); py.push(p[1]);
					_lineBasisBezier(path, px, py);
				}
			case BasisOpen:
				if (points.length < 4)
					return interpolatePoints(points, Linear);
				i = -1;
				var pi,
					px = [0.0],
					py = [0.0];
				while (++i < 3)
				{
					pi = points[i];
					px.push(pi[0]);
					py.push(pi[1]);
				}
				path.push(_lineDot4(_lineBasisBezier3, px)
					+ "," + _lineDot4(_lineBasisBezier3, py));
				--i;
				while (++i < n)
				{
					pi = points[i];
					px.shift();
					px.push(pi[0]);
					py.shift();
					py.push(pi[1]);
					_lineBasisBezier(path, px, py);
				}
			case BasisClosed:
				i = -1;
				var m = n + 4,
					px = [],
					py = [];

				while (++i < 4)
				{
					p = points[i % n];
					px.push(p[0]);
					py.push(p[1]);
				}
				path.push(_lineDot4(_lineBasisBezier3, px) + "," + _lineDot4(_lineBasisBezier3, py));
				--i;
				while (++i < m)
				{
					p = points[i % n];
					px.shift(); px.push(p[0]);
					py.shift(); py.push(p[1]);
					_lineBasisBezier(path, px, py);
				}
			case Cardinal(tension):
				if (null == tension)
					tension = .7;
				if (points.length < 3)
					return interpolatePoints(points, Linear);
				else
					return points[0][0] + "," + points[0][1] + _lineHermite(points, _lineCardinalTangents(points, tension));
			case CardinalOpen(tension):
				return points.length < 4
					? interpolatePoints(points, Linear)
					: points[1][0] + "," + points[1][1] + _lineCardinalTangents(points, tension);
			case CardinalClosed(tension):
				if (null == tension)
					tension = .7;
				return points.length < 3
					? interpolatePoints(points, Linear)
					: points[0][0] + "," + points[0][1] + _lineHermite(points, _lineCardinalTangents([points[points.length - 2]].concat(points).concat([points[1]]), tension));
			case Monotone:
				return points.length < 3
					? interpolatePoints(points, Linear)
					: points[0][0] + "," + points[0][1] + _lineHermite(points, _lineMonotoneTangents(points));
		}
		return path.join("");
	}

	static var _lineBasisBezier1 = [0, 2 / 3, 1 / 3, 0];
    static var _lineBasisBezier2 = [0, 1 / 3, 2 / 3, 0];
    static var _lineBasisBezier3 = [0, 1 / 6, 2 / 3, 1 / 6];

	static function _lineDot4(a : Array<Float>, b : Array<Float>) {
		return a[0] * b[0] + a[1] * b[1] + a[2] * b[2] + a[3] * b[3];
	}

	static function _lineBasisBezier(path : Array<String>, x : Array<Float>, y : Array<Float>)
	{
		path.push(
			"C" + _lineDot4(_lineBasisBezier1, x) +
			"," + _lineDot4(_lineBasisBezier1, y) +
			"," + _lineDot4(_lineBasisBezier2, x) +
			"," + _lineDot4(_lineBasisBezier2, y) +
			"," + _lineDot4(_lineBasisBezier3, x) +
			"," + _lineDot4(_lineBasisBezier3, y));
	}

	static function _lineSlope(p0 : Array<Float>, p1 : Array<Float>)
	{
		return (p1[1] - p0[1]) / (p1[0] - p0[0]);
	}

	static function _lineFiniteDifferences(points : Array<Array<Float>>)
	{
		var i = 0,
			j = points.length - 1,
			m = [],
			p0 = points[0],
			p1 = points[1],
			d = m[0] = _lineSlope(p0, p1);
		while (++i < j)
		{
			m[i] = d + (d = _lineSlope(p0 = p1, p1 = points[i + 1]));
		}
		m[i] = d;
		return m;
	}

	static function _lineMonotoneTangents(points : Array<Array<Float>>)
	{
		var tangents = [],
			d,
			a,
			b,
			s,
			m = _lineFiniteDifferences(points),
			i = -1,
			j = points.length - 1;

		while (++i < j)
		{
			d = _lineSlope(points[i], points[i + 1]);
			if (Math.abs(d) < 1e-6)
			{
				m[i] = m[i + 1] = 0;
			} else {
				a = m[i] / d;
				b = m[i + 1] / d;

				s = a * a + b * b;
				if (s > 9)
				{
					s = d * 3 / Math.sqrt(s);
					m[i] = s * a;
					m[i + 1] = s * b;
				}
			}
		}

		i = -1;
		while (++i <= j)
		{
			s = (points[Ints.min(j, i + 1)][0] - points[Ints.max(0, i - 1)][0])
				/ (6 * (1 + m[i] * m[i]));
			tangents.push([Math.isFinite(s) ? s : 0, Math.isFinite(s = m [i] * s) ? s : 0]);
		}

		return tangents;
	}

	static function _lineHermite(points : Array<Array<Float>>, tangents : Array<Array<Float>>)
	{
		if (tangents.length < 1 || (points.length != tangents.length && points.length != tangents.length + 2))
			return interpolatePoints(points, Linear);

		var quad = points.length != tangents.length,
			path = "",
			p0 = points[0],
			p = points[1],
			t0 = tangents[0],
			t = t0,
			pi = 1;

		if (quad)
		{
			path += "Q" + (p[0] - t0[0] * 2 / 3) + "," + (p[1] - t0[1] * 2 / 3) + "," + p[0] + "," + p[1];
			p0 = points[1];
			pi = 2;
		}

		if (tangents.length > 1) {
			t = tangents[1];
			p = points[pi];
			pi++;
			path += "C" + (p0[0] + t0[0]) + "," + (p0[1] + t0[1])
				+ "," + (p[0] - t[0]) + "," + (p[1] - t[1])
				+ "," + p[0] + "," + p[1];
			for (i in 2...tangents.length)
			{
				p = points[pi];
				t = tangents[i];
				path += "S" + (p[0] - t[0]) + "," + (p[1] - t[1]) + "," + p[0] + "," + p[1];
				pi++;
			}
		}

		if (quad) {
			var lp = points[pi];
			path += "Q" + (p[0] + t[0] * 2 / 3) + "," + (p[1] + t[1] * 2 / 3) + "," + lp[0] + "," + lp[1];
		}

		return path;
	}


	static function _lineCardinalTangents(points : Array<Array<Float>>, tension : Float)
	{
		var tangents = [],
			a = (1 - tension) / 2,
			p0 = points[0],
			p1 = points[1],
			p2 = points[2],
			i = 2,
			n = points.length;
		while (++i < n)
		{
			tangents.push([a * (p2[0] - p0[0]), a * (p2[1] - p0[1])]);
			p0 = p1;
			p1 = p2;
			p2 = points[i];
		}
		tangents.push([a * (p2[0] - p0[0]), a * (p2[1] - p0[1])]);
		return tangents;
	}
}