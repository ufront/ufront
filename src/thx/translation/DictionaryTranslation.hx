package thx.translation;
import thx.culture.Info;
import thx.culture.Culture;
import thx.translation.ITranslation;
import thx.translation.PluralForms;

class DictionaryTranslation implements ITranslation
{
	public var domain(get, set) : String;
	var _domain : String;

	var _infos : Map<String, Info>;
	var _domainss : Map<String, Map<String, String>>;
	var _domainsp : Map<String, Map<String, Array<String>>>;

	public function new(?domain : String, ?info : Info)
	{
		_infos = new Map ();
		_domainss = new Map ();
		_domainsp = new Map ();
		addDomain(domain, info);
	}

	public function addDomain(?domain : String, ?info : Info)
	{
		if (null == domain && null == info)
			throw "you have to pass at least a domain or a info";
		if (null == info)
			info = Culture.defaultCulture;
		if (null == domain)
			domain = info.name;
		if (_infos.exists(domain))
			throw "domain already added: " + domain;

		_infos.set(domain, info);
		_domainss.set(domain, new Map ());
		_domainsp.set(domain, new Map ());

		if (null == _domain)
			this.domain = domain;
	}

	public function addSingular(id : String, text : String, ?domain : String)
	{
		if (null == domain)
			domain = this.domain;
		_domainss.get(domain).set(id, text);
	}

	public function addPlural(ids : String, idp : String, texts : Array<String>, ?domain : String)
	{
		if (null == domain)
			domain = this.domain;
		_domainss.get(domain).set(ids, texts[0]);
		_domainsp.get(domain).set(idp, texts);
	}

	public function singular(id : String, ?domain : String) : String
	{
		if (null == domain)
			domain = this.domain;
		var v = _domainss.get(domain).get(id);
		if (null == v)
			return id;
		else
			return v;
	}

	public function plural(ids : String, idp : String, quantifier : Int, ?domain : String) : String
	{
		if (null == domain)
			domain = this.domain;

		var index = PluralForms.pluralRules[_infos.get(domain).pluralRule](quantifier);
		var v = _domainsp.get(domain).get(idp)[index];
		if (null == v)
		{
			if (null != ids && quantifier == 1)
				return ids;
			else
				return idp;
		} else
			return v;
	}

	function get_domain()
	{
		if (null == _domain)
			throw "default domain not yet set";
		return _domain;
	}
	function set_domain(v : String) return _domain = v;
}