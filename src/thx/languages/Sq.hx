package thx.languages;

import thx.culture.Language;

class Sq extends Language {
	function new() {
		name = "sq";
		english = "Albanian";
		native = "shqipe";
		iso2 = "sq";
		iso3 = "sqi";
		pluralRule = 1;
		Language.add(this);
	}
	@:isVar public static var language(get_language, null) : Language; static function get_language() { if(null == language) language = new Sq(); return language; }
	static function __init__() { get_language(); }
}