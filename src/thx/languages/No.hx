package thx.languages;

import thx.culture.Language;

class No extends Language {
	function new() {
		name = "no";
		english = "Norwegian";
		native = "norsk";
		iso2 = "no";
		iso3 = "nor";
		pluralRule = 1;
		Language.add(this);
	}
	@:isVar public static var language(get_language, null) : Language; static function get_language() { if(null == language) language = new No(); return language; }
	static function __init__() { get_language(); }
}