package thx.languages;

import thx.culture.Language;

class Tr extends Language {
	function new() {
		name = "tr";
		english = "Turkish";
		native = "Türkçe";
		iso2 = "tr";
		iso3 = "tur";
		pluralRule = 0;
		Language.add(this);
	}
	@:isVar public static var language(get_language, null) : Language; static function get_language() { if(null == language) language = new Tr(); return language; }
	static function __init__() { get_language(); }
}