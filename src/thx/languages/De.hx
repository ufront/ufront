package thx.languages;

import thx.culture.Language;

class De extends Language {
	function new() {
		name = "de";
		english = "German";
		native = "Deutsch";
		iso2 = "de";
		iso3 = "deu";
		pluralRule = 1;
		Language.add(this);
	}
	@:isVar public static var language(get_language, null) : Language; static function get_language() { if(null == language) language = new De(); return language; }
	static function __init__() { get_language(); }
}