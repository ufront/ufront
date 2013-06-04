package thx.languages;

import thx.culture.Language;

class Ar extends Language {
	function new() {
		name = "ar";
		english = "Arabic";
		native = "العربية";
		iso2 = "ar";
		iso3 = "ara";
		pluralRule = 12;
		Language.add(this);
	}
	@:isVar public static var language(get_language, null) : Language; static function get_language() { if(null == language) language = new Ar(); return language; }
	static function __init__() { get_language(); }
}