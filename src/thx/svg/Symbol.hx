package thx.svg;
import thx.math.Const;

/**
 * Based on D3.js by Michael Bostock
 * @author Franco Ponticelli
 */

class Symbol
{
	static var sqrt3 = Math.sqrt(3);
	static var tan30 = Math.tan(30 * Math.PI / 180);

	public static function triangleDown(size : Float)
	{
		var rx = Math.sqrt(size / sqrt3),
			ry = rx * sqrt3 / 2;
		return "M0," + ry
			+ "L" + rx +"," + -ry
			+ " " + -rx + "," + -ry
			+ "Z";
	}

	public static function triangleUp(size : Float)
	{
		var rx = Math.sqrt(size / sqrt3),
			ry = rx * sqrt3 / 2;
		return "M0," + -ry
			+ "L" + rx +"," + ry
			+ " " + -rx + "," + ry
			+ "Z";
	}

	public static function square(size : Float)
	{
		var r = Math.sqrt(size) / 2;
		return "M" + -r + "," + -r
			+ "L" + r + "," + -r
			+ " " + r + "," + r
			+ " " + -r + "," + r
			+ "Z";
	}

	public static function diamond(size : Float)
	{
		var ry = Math.sqrt(size / (2 * tan30)),
			rx = ry * tan30;
		return "M0," + -ry
			+ "L" + rx + ",0"
			+ " 0," + ry
			+ " " + -rx + ",0"
			+ "Z";
	}

	public static function cross(size : Float)
	{
		var r = Math.sqrt(size / 5) / 2;
		return "M" + -3 * r + "," + -r
			+ "H" + -r
			+ "V" + -3 * r
			+ "H" + r
			+ "V" + -r
			+ "H" + 3 * r
			+ "V" + r
			+ "H" + r
			+ "V" + 3 * r
			+ "H" + -r
			+ "V" + r
			+ "H" + -3 * r
			+ "Z";
	}

	public static function circle(size : Float)
	{
		var r = Math.sqrt(size / Math.PI);
		return "M0," + r
			+ "A" + r + "," + r + " 0 1,1 0," + (-r)
			+ "A" + r + "," + r + " 0 1,1 0," + r
			+ "Z";
	}

	public static function arrowUp(size : Float)
	{
		var r = Math.sqrt(size / 2);
		return "M" + -r + ",0"
			+ "h" + (r / 2)
			+ "v" + r
			+ "h" + r
			+ "v" + -r
			+ "h" + (r / 2)
			+ "l" + -r + "," + -r
			+ "Z";
	}

	public static function arrowDown(size : Float)
	{
		var r = Math.sqrt(size / 2);
		return "M" + -r + ",0"
			+ "h" + (r / 2)
			+ "v" + -r
			+ "h" + r
			+ "v" + r
			+ "h" + (r / 2)
			+ "l" + -r + "," + r
			+ "Z";
	}

	public static function arrowDownWide(size : Float)
	{
		var r = Math.sqrt(size / 2.5);
		return "M" + -r + ",0"
			+ "h" + (r / 4)
			+ "v" + -r
			+ "h" + r * 1.5
			+ "v" + r
			+ "h" + (r / 4)
			+ "l" + -r * 1 + "," + r
			+ "Z";
	}

	public static function arrowRight(size : Float)
	{
		var r = Math.sqrt(size / 2);
		return "M" + "0," + -r
			+ "v" + (r / 2)
			+ "h" + -r
			+ "v" + r
			+ "h" + r
			+ "v" + (r / 2)
			+ "l" + r + "," + -r
			+ "Z";
	}

	public static function arrowLeft(size : Float)
	{
		var r = Math.sqrt(size / 2);
		return "M" + "0," + -r
			+ "v" + (r / 2)
			+ "h" + r
			+ "v" + r
			+ "h" + -r
			+ "v" + (r / 2)
			+ "l" + -r + "," + -r
			+ "Z";
	}

	public static function star(size : Float)
	{
		var r = Math.sqrt(size / 0.31027) / 2;
		return
			  "M0," + (-r)
			+ "L" + (r * 0.236)  + "," + (r * -0.325) + " "
				  + (r * 0.951)  + "," + (r * -0.309) + " "
				  + (r * 0.382)  + "," + (r *  0.124) + " "
				  + (r * 0.588)  + "," + (r *  0.809) + " "
				  + (r * 0)      + "," + (r *  0.401) + " "
				  + (r * -0.588) + "," + (r *  0.809) + " "
				  + (r * -0.382) + "," + (r *  0.124) + " "
				  + (r * -0.951) + "," + (r * -0.309) + " "
				  + (r * -0.236) + "," + (r * -0.325) + " " +
			"Z";
	}
}