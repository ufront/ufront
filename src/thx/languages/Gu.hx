package thx.languages;

import thx.culture.Language;

class Gu extends Language {
	function new() {
		name = "gu";
		english = "Gujarati";
		native = "ગુજરાતી";
		iso2 = "gu";
		iso3 = "guj";
		pluralRule = 1;
		Language.add(this);
	}
	@:isVar public static var language(get_language, null) : Language; static function get_language() { if(null == language) language = new Gu(); return language; }
	static function __init__() { get_language(); }
}