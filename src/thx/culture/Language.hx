package thx.culture;

/**
* @todo add lazy loading
*/
class Language extends Info
{
	@:isVar static var languages(get_languages, null) : Map<String, Language>;
	static function get_languages()
	{
		if (null == languages)
			languages = new Map ();
		return languages;
	}

	public static function get(name : String) : Language {
		return languages.get(name.toLowerCase());
	}

	public static function names() {
		return languages.keys();
	}

	public static function add(language : Language) {
		if(!languages.exists(language.iso2))
			languages.set(language.iso2, language);
	}
}