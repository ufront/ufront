/**
 * ...
 * @author Franco Ponticelli
 */

package thx.geo;

interface IProjection 
{
	public function project(coords : Array<Float>) : Array<Float>;
	public function invert(coords : Array<Float>) : Array<Float>;
}