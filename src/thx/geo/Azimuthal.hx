/**
 * Based on D3.js by Michael Bostock
 * @author Franco Ponticelli
 */

package thx.geo;
import thx.math.Const;

class Azimuthal implements IProjection
{
	@:isVar public var mode(get, set) : ProjectionMode;
	@:isVar public var origin(get, set) : Array<Float>;
	@:isVar public var scale(get, set) : Float;
	@:isVar public var translate(get, set) : Array<Float>;
	var x0 : Float;
	var y0 : Float;
	var cy0 : Float;
	var sy0 : Float;

	public function new()
	{
		mode = Orthographic;
		scale = 200;
		translate = [480.0, 250];
		origin = [0.0, 0];
	}

	public function project(coords : Array<Float>)
	{
		var x1 = coords[0] * Const.TO_RADIAN - x0,
			y1 = coords[1] * Const.TO_RADIAN,
			cx1 = Math.cos(x1),
			sx1 = Math.sin(x1),
			cy1 = Math.cos(y1),
			sy1 = Math.sin(y1),
			k = switch(mode) {
				case Orthographic:	1;
				case Stereographic:	1 / (1 + sy0 * sy1 + cy0 * cy1 * cx1);
			},
			x = k * cy1 * sx1,
			y = k * (sy0 * cy1 * cx1 - cy0 * sy1);
		return [
			scale * x + translate[0],
			scale * y + translate[1]
		];
	}

	public function invert(coords : Array<Float>)
	{
		var x = (coords[0] - translate[0]) / scale,
			y = (coords[1] - translate[1]) / scale,
			p = Math.sqrt(x * x + y * y),
			c = switch(mode)
			{
				case Orthographic: Math.asin(p);
				case Stereographic: Math.atan(p);
			},
			sc = Math.sin(c),
			cc = Math.cos(c);
		return [
			(x0 + Math.atan2(x * sc, p * cy0 * cc + y * sy0 * sc)) / Const.TO_RADIAN,
			Math.asin(cc * sy0 - (y * sc * cy0) / p) / Const.TO_RADIAN
		];
	}

	function get_origin() return origin.copy();
	function set_origin(origin : Array<Float>)
	{
		this.origin = [origin[0], origin[1]];
		x0 = origin[0] * Const.TO_RADIAN;
		y0 = origin[1] * Const.TO_RADIAN;
		cy0 = Math.cos(y0);
		sy0 = Math.sin(y0);
		return origin;
	}

	function get_translate() return translate.copy();
	function set_translate(translate : Array<Float>)
	{
		this.translate = [translate[0], translate[1]];
		return translate;
	}

	function set_scale(scale : Float) return this.scale = scale;
	function get_scale() return scale;
	function set_mode(mode : ProjectionMode) return this.mode = mode;
	function get_mode() return mode;
}

enum ProjectionMode
{
	Orthographic;
	Stereographic;
}