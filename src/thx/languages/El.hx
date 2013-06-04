package thx.languages;

import thx.culture.Language;

class El extends Language {
	function new() {
		name = "el";
		english = "Greek";
		native = "ελληνικά";
		iso2 = "el";
		iso3 = "ell";
		pluralRule = 1;
		Language.add(this);
	}
	@:isVar public static var language(get_language, null) : Language; static function get_language() { if(null == language) language = new El(); return language; }
	static function __init__() { get_language(); }
}