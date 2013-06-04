package thx.translation;

interface ITranslation
{
	public var domain(get, set) : String;
	public function singular(id : String, ?domain : String) : String;
	public function plural(ids : String, idp : String, quantifier : Int, ?domain : String) : String;
}