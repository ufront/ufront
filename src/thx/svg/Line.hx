package thx.svg;

/**
 * Based on D3.js by Michael Bostock
 * @author Franco Ponticelli
 * @todo complete line functions
 */

import thx.svg.LineInterpolator;

class Line<TData>
{
	var _x : TData -> Int -> Float;
	var _y : TData -> Int -> Float;
	var _interpolator : LineInterpolator;
	public function new(x : TData -> Int -> Float, y : TData -> Int -> Float, ?interpolator : LineInterpolator)
	{
		this._x = x;
		this._y = y;
		this._interpolator = interpolator;
	}

	public function shape(?data : Array<TData>, ?i : Int)
	{
		return data.length < 1 ? null : "M" + LineInternals.interpolatePoints(LineInternals.linePoints(data, _x, _y), _interpolator);
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

	public function getY() return _y;

	public function y(v : TData -> Int -> Float)
	{
		_y = v;
		return this;
	}

	public static function pointArray(?interpolator : LineInterpolator)
	{
		return new Line(function(d : Array<Float>,_) return d[0], function(d : Array<Float>,_) return d[1], interpolator);
	}

	public static function pointObject(?interpolator : LineInterpolator)
	{
		return new Line<{x:Float,y:Float}>(function(d,_) return d.x, function(d,_) return d.y, interpolator);
	}
}