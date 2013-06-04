package thx.languages;

import thx.culture.Language;

class Pl extends Language {
	function new() {
		name = "pl";
		english = "Polish";
		native = "polski";
		iso2 = "pl";
		iso3 = "pol";
		pluralRule = 9;
		Language.add(this);
	}
	@:isVar public static var language(get_language, null) : Language; static function get_language() { if(null == language) language = new Pl(); return language; }
	static function __init__() { get_language(); }
}