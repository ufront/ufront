package thx.languages;

import thx.culture.Language;

class Lv extends Language {
	function new() {
		name = "lv";
		english = "Latvian";
		native = "latviešu";
		iso2 = "lv";
		iso3 = "lav";
		pluralRule = 3;
		Language.add(this);
	}
	@:isVar public static var language(get_language, null) : Language; static function get_language() { if(null == language) language = new Lv(); return language; }
	static function __init__() { get_language(); }
}