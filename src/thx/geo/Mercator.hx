/**
 * Based on D3.js by Michael Bostock
 * @author Franco Ponticelli
 */

package thx.geo;
import thx.math.Const;

class Mercator implements IProjection
{
	@:isVar public var scale(get, set) : Float;
	@:isVar public var translate(get, set) : Array<Float>;

	public function new()
	{
		scale = 500;
		translate = [480.0, 250];
	}

	public function project(coords : Array<Float>)
	{
		var x = coords[0] / 360,
			y = -(Math.log(Math.tan(Math.PI / 4 + coords[1] * Const.TO_RADIAN / 2)) / Const.TO_RADIAN) / 360;
		return [
			scale * x + translate[0],
			scale * Math.max( -.5, Math.min(.5, y)) + translate[1]
		];
	}

	public function invert(coords : Array<Float>)
	{
		var x = (coords[0] - translate[0]) / scale,
			y = (coords[1] - translate[1]) / scale;
		return [
			360 * x,
			2 * Math.atan(Math.exp(-360 * y * Const.TO_RADIAN)) / Const.TO_RADIAN - 90
		];
	}

	function set_scale(scale : Float) return this.scale = scale;
	function get_scale() return scale;

	function get_translate() return translate.copy();
	function set_translate(translate : Array<Float>)
	{
		this.translate = [translate[0], translate[1]];
		return translate;
	}
}