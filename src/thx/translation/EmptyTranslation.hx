package thx.translation;
import thx.culture.Info;
import thx.culture.Culture;
import thx.translation.ITranslation;
import thx.translation.PluralForms;

class EmptyTranslation implements ITranslation
{
	public var domain(get, set) : String;
	var _domain : String;

	public function new()
	{
	}

	public function singular(id : String, ?domain : String) : String
	{
		return id;
	}

	public function plural(ids : String, idp : String, quantifier : Int, ?domain : String) : String
	{
		if (null != ids && quantifier == 1)
			return ids;
		else
			return idp;
	}

	function get_domain()
	{
		return null;
	}
	function set_domain(v : String) return v
}