/**
 * Based on D3.js by Michael Bostock
 * @author Franco Ponticelli
 * A composite projection for the United States, 960x500. The set of standard
 * parallels for each region comes from USGS, which is published here:
 * http://egsc.usgs.gov/isb/pubs/MapProjections/projections.html#albers
 * TODO allow the composite projection to be rescaled?
 */

package thx.geo;
import thx.error.NotImplemented;

class AlbersUsa implements IProjection
{
	public var translate(get, set) : Array<Float>;
	public var scale(get, set) : Float;

	var lower48 : Albers;
	var alaska : Albers;
	var hawaii : Albers;
	var puertoRico : Albers;

	public function new()
	{
		lower48 = new Albers();

		alaska = new Albers();
		alaska.origin    = [-160.0, 60];
		alaska.parallels = [  55.0, 65];

		hawaii = new Albers();
		hawaii.origin    = [-160.0, 20];
		hawaii.parallels = [   8.0, 18];

		puertoRico = new Albers();
		puertoRico.origin    = [-60.0, 10];
		puertoRico.parallels = [  8.0, 18];

		scale = lower48.scale;
	}

	var last : String;
	public function project(coords : Array<Float>)
	{
		var lon = coords[0],
			lat = coords[1];
/*
		var isalaska = lat > 50;
		var ishawaii = lat <= 50 && lon < -140;
		var isrico = lat <= 50 && lon >= -140 && lat < 21;
		if ("" + isalaska + ishawaii + isrico != last)
		{
			last = "" + isalaska + ishawaii + isrico;
			trace("alaska " + isalaska + ", hawaii " + ishawaii + ", rico " + isrico);
		}
*/
		return (
			   lat > 50   ? alaska
			: (lon < -140 ? hawaii
			: (lat < 21   ? puertoRico
			: lower48
		))).project(coords);
	}

	public function invert(coords : Array<Float>) : Array<Float>
	{
		return throw new NotImplemented();
	}

	function set_scale(scale : Float)
	{
		lower48.scale    = scale;
		alaska.scale     = scale * .6;
		hawaii.scale     = scale;
		puertoRico.scale = scale * 1.5;
		this.translate = lower48.translate;
		return scale;
	}

	function get_scale() return lower48.scale;

	function set_translate(translate : Array<Float>)
	{
		var dz = lower48.scale / 1000,
			dx = translate[0],
			dy = translate[1];
		lower48.translate    = translate;
		alaska.translate     = [dx - 400 * dz, dy + 170 * dz];
		hawaii.translate     = [dx - 190 * dz, dy + 200 * dz];
		puertoRico.translate = [dx + 580 * dz, dy + 430 * dz];
		return translate;
	}
	function get_translate() return lower48.translate;
}