package thx.languages;

import thx.culture.Language;

class Mr extends Language {
	function new() {
		name = "mr";
		english = "Marathi";
		native = "मराठी";
		iso2 = "mr";
		iso3 = "mar";
		pluralRule = 1;
		Language.add(this);
	}
	@:isVar public static var language(get_language, null) : Language; static function get_language() { if(null == language) language = new Mr(); return language; }
	static function __init__() { get_language(); }
}