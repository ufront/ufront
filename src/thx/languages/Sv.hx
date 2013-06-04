package thx.languages;

import thx.culture.Language;

class Sv extends Language {
	function new() {
		name = "sv";
		english = "Swedish";
		native = "svenska";
		iso2 = "sv";
		iso3 = "swe";
		pluralRule = 1;
		Language.add(this);
	}
	@:isVar public static var language(get_language, null) : Language; static function get_language() { if(null == language) language = new Sv(); return language; }
	static function __init__() { get_language(); }
}