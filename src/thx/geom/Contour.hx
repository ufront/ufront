/**
 * ...
 * @author Franco Ponticelli
 */

package thx.geom;

class Contour
{
	static function contourStart(grid : Int -> Int -> Bool)
	{
		var x = 0,
			y = 0;

		while (true)
		{
			if (grid(x, y))
			{
				return [x, y];
			}
			if (x == 0)
			{
				x = y + 1;
				y = 0;
			} else {
				x = x - 1;
				y = y + 1;
			}
		}
		return null;
	}

	static var contourDx = [1, 0, 1, 1, -1, 0, -1, 1, 0, 0, 0, 0, -1, 0, -1, null];
	static var contourDy = [0, -1, 0, 0, 0, -1, 0, 0, 1, -1, 1, 1, 0, -1, 0, null];

	public static function contour(grid : Int -> Int -> Bool, ?start : Array<Int>)
	{
		var s = null == start ? contourStart(grid) : start,
			c = [],
			x = s[0],
			y = s[1],
			dx = 0,
			dy = 0,
			pdx = 666,
			pdy = 666,
			i = 0;

		do
		{
			i = 0;
			if (grid(x-1, y-1)) i += 1;
			if (grid(x  , y-1)) i += 2;
			if (grid(x-1, y  )) i += 4;
			if (grid(x  , y  )) i += 8;

			if (i == 6)
			{
				dx = pdy == -1 ? -1 : 1;
				dy = 0;
			} else if (i == 9)
			{
				dx = 0;
				dy = pdx == 1 ? -1 : 1;
			} else
			{
				dx = contourDx[i];
				dy = contourDy[i];
			}

			if (dx != pdx && dy != pdy)
			{
				c.push([x, y]);
				pdx = dx;
				pdy = dy;
			}

			x += dx;
			y += dy;
		} while (s[0] != x || s[1] != y);

		return c;
	}
}