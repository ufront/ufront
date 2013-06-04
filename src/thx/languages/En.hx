package thx.languages;

import thx.culture.Language;

class En extends Language {
	function new() {
		name = "en";
		english = "English";
		native = "English";
		iso2 = "en";
		iso3 = "eng";
		pluralRule = 1;
		Language.add(this);
	}
	@:isVar public static var language(get_language, null) : Language; static function get_language() { if(null == language) language = new En(); return language; }
	static function __init__() { get_language(); }
}