/**
 * ...
 * @author Franco Ponticelli
 */

package thx.culture;

class Info
{
	public var name(default, null) : String;
	public var native(default, null) : String;
	public var english(default, null) : String;
	public var iso2(default, null) : String;
	public var iso3(default, null) : String;
	public var pluralRule(default, null) : Int;
	
	public function toString()
	{
		return native + " (" + english + ")";
	}
}