package thx.languages;

import thx.culture.Language;

class Ru extends Language {
	function new() {
		name = "ru";
		english = "Russian";
		native = "русский";
		iso2 = "ru";
		iso3 = "rus";
		pluralRule = 7;
		Language.add(this);
	}
	@:isVar public static var language(get_language, null) : Language; static function get_language() { if(null == language) language = new Ru(); return language; }
	static function __init__() { get_language(); }
}