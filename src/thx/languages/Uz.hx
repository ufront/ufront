package thx.languages;

import thx.culture.Language;

class Uz extends Language {
	function new() {
		name = "uz";
		english = "Uzbek";
		native = "U'zbek";
		iso2 = "uz";
		iso3 = "uzb";
		pluralRule = 0;
		Language.add(this);
	}
	@:isVar public static var language(get_language, null) : Language; static function get_language() { if(null == language) language = new Uz(); return language; }
	static function __init__() { get_language(); }
}