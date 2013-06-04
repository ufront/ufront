/**
 * ...
 * @author Franco Ponticelli
 */

package thx.data;

interface IDataHandler
{
	public function start() : Void;
	public function end() : Void;

	public function objectStart() : Void;
	public function objectFieldStart(name : String) : Void;
	public function objectFieldEnd() : Void;
	public function objectEnd() : Void;

	public function arrayStart() : Void;
	public function arrayItemStart() : Void;
	public function arrayItemEnd() : Void;
	public function arrayEnd() : Void;

	public function valueDate(d : Date) : Void;
	public function valueString(s : String) : Void;
	public function valueInt(i : Int) : Void;
	public function valueFloat(f : Float) : Void;
	public function valueNull() : Void;
	public function valueBool(b : Bool) : Void;

	public function comment(s : String) : Void;
}