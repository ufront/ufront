package thx.languages;

import thx.culture.Language;

class Th extends Language {
	function new() {
		name = "th";
		english = "Thai";
		native = "ไทย";
		iso2 = "th";
		iso3 = "tha";
		pluralRule = 0;
		Language.add(this);
	}
	@:isVar public static var language(get_language, null) : Language; static function get_language() { if(null == language) language = new Th(); return language; }
	static function __init__() { get_language(); }
}