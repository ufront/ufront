package thx.languages;

import thx.culture.Language;

class Fa extends Language {
	function new() {
		name = "fa";
		english = "Persian";
		native = "فارسى";
		iso2 = "fa";
		iso3 = "fas";
		pluralRule = 1;
		Language.add(this);
	}
	@:isVar public static var language(get_language, null) : Language; static function get_language() { if(null == language) language = new Fa(); return language; }
	static function __init__() { get_language(); }
}