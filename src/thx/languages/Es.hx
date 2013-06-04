package thx.languages;

import thx.culture.Language;

class Es extends Language {
	function new() {
		name = "es";
		english = "Spanish";
		native = "español";
		iso2 = "es";
		iso3 = "spa";
		pluralRule = 1;
		Language.add(this);
	}
	@:isVar public static var language(get_language, null) : Language; static function get_language() { if(null == language) language = new Es(); return language; }
	static function __init__() { get_language(); }
}