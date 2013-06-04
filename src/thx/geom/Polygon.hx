/**
 * ...
 * @author Franco Ponticelli
 */

package thx.geom;
using Arrays;

class Polygon
{
	var coordinates : Array<Array<Float>>;
	public function new(coordinates : Array<Array<Float>>)
	{
		this.coordinates = coordinates;
	}

	public function area()
	{
		var n = coordinates.length,
			a = coordinates[n - 1][0] * coordinates[0][1],
			b = coordinates[n - 1][1] * coordinates[0][0];
		for (i in 1...n)
		{
			a += coordinates[i - 1][0] * coordinates[i][1];
			b += coordinates[i - 1][1] * coordinates[i][0];
		}
		return (b - a) * .5;
	}

	public function centroid(?k : Float)
	{
		var a, b, c, x = 0.0, y = 0.0;
		if(null == k)
			k = 1 / (6 * area());
		for (i in 0...coordinates.length-1)
		{
			a = coordinates[i];
			b = coordinates[i + 1];
			c = a[0] * b[1] - b[0] * a[1];
			x += (a[0] + b[0]) * c;
			y += (a[1] + b[1]) * c;
		}
		return [x * k, y * k];
	}

	/**
	 * The Sutherland-Hodgman clipping algorithm.
	 */
	public function clip(subject : Array<Array<Float>>)
	{
		var input, a = coordinates.last(), b, c, d, m;
		for (i in 0...coordinates.length)
		{
			input = subject.copy();
			subject = [];
			b = coordinates[i];
			c = input[(m = input.length) - 1];
			for (j in 0...m)
			{
				d = input[j];
				if (polygonInside(d, a, b))
				{
					if (!polygonInside(c, a, b))
						subject.push(polygonIntersect(c, d, a, b));
					subject.push(d);
				} else if (polygonInside(c, a, b))
					subject.push(polygonIntersect(c, d, a, b));
				c = d;
			}
			a = b;
		}
		return subject;
	}

	static function polygonInside(p : Array<Float>, a : Array<Float>, b : Array<Float>)
	{
		return (b[0] - a[0]) * (p[1] - a[1]) < (b[1] - a[1]) * (p[0] - a[0]);
	}

	static function polygonIntersect(c : Array<Float>, d : Array<Float>, a : Array<Float>, b : Array<Float>)
	{
		var x1 = c[0], x2 = d[0], x3 = a[0], x4 = b[0],
			y1 = c[1], y2 = d[1], y3 = a[1], y4 = b[1],
			x13 = x1 - x3,
			x21 = x2 - x1,
			x43 = x4 - x3,
			y13 = y1 - y3,
			y21 = y2 - y1,
			y43 = y4 - y3,
			ua = (x43 * y13 - y43 * x13) / (y43 * x21 - x43 * y21);
		return [x1 + ua * x21, y1 + ua * y21];
	}
}