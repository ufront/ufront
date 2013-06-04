package thx.svg;

/**
 * Based on D3.js by Michael Bostock
 * @author Franco Ponticelli
 */

class Area<TData>
{
	var _x : TData -> Int -> Float;
	var _y0 : TData -> Int -> Float;
	var _y1 : TData -> Int -> Float;
	var _interpolator : LineInterpolator;
	public function new(?x : TData -> Int -> Float, ?y0 : TData -> Int -> Float, ?y1 : TData -> Int -> Float, ?interpolator : LineInterpolator)
	{
		this._x = x;
		this._y0 = y0;
		this._y1 = y1;
		this._interpolator = interpolator;
	}

	public function shape(?data : Array<TData>, ?i : Int)
	{
		var second = LineInternals.linePoints(data, _x, _y0);
		second.reverse();
		return data.length < 1 ? null
			: "M" + LineInternals.interpolatePoints(LineInternals.linePoints(data, _x, _y1), _interpolator)
			+ "L" + LineInternals.interpolatePoints(second, _interpolator)
			+ "Z";
	}

	public function getInterpolator() return _interpolator;
	public function interpolator(type : LineInterpolator)
	{
		_interpolator = type;
		return this;
	}

	public function getX() return _x;
	public function x(v : TData -> Int -> Float)
	{
		_x = v;
		return this;
	}

	public function getY0() return _y0;
	public function y0(v : TData -> Int -> Float)
	{
		_y0 = v;
		return this;
	}

	public function getY1() return _y1;
	public function y1(v : TData -> Int -> Float)
	{
		_y1 = v;
		return this;
	}

	public static function pointArray(?interpolator : LineInterpolator)
		return new Area<Array<Float>>(function(d,_) return d[0], function(d,_) return d[1], function(d,_) return d[2], interpolator);

	public static function pointObject(?interpolator : LineInterpolator)
		return new Area<{x:Float,y0:Float,y1:Float}>(function(d,_) return d.x, function(d,_) return d.y0, function(d,_) return d.y1, interpolator);

	public static function pointArray2(?interpolator : LineInterpolator)
		return new Area<Array<Float>>(function(d,_) return d[0], function(_,_) return 0.0, function(d,_) return d[1], interpolator);

	public static function pointObjectXY(?interpolator : LineInterpolator)
		return new Area<{x:Float,y:Float}>(function(d,_) return d.x, function(_,_) return 0.0, function(d,_) return d.y, interpolator);
}