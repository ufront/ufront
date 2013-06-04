package thx.languages;

import thx.culture.Language;

class Kk extends Language {
	function new() {
		name = "kk";
		english = "Kazakh";
		native = "Қазащb";
		iso2 = "kk";
		iso3 = "kaz";
		pluralRule = 1;
		Language.add(this);
	}
	@:isVar public static var language(get_language, null) : Language; static function get_language() { if(null == language) language = new Kk(); return language; }
	static function __init__() { get_language(); }
}