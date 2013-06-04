package thx.languages;

import thx.culture.Language;

class Ta extends Language {
	function new() {
		name = "ta";
		english = "Tamil";
		native = "தமிழ்";
		iso2 = "ta";
		iso3 = "tam";
		pluralRule = 1;
		Language.add(this);
	}
	@:isVar public static var language(get_language, null) : Language; static function get_language() { if(null == language) language = new Ta(); return language; }
	static function __init__() { get_language(); }
}