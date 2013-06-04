package thx.languages;

import thx.culture.Language;

class Be extends Language {
	function new() {
		name = "be";
		english = "Belarusian";
		native = "Беларускі";
		iso2 = "be";
		iso3 = "bel";
		pluralRule = 7;
		Language.add(this);
	}
	@:isVar public static var language(get_language, null) : Language; static function get_language() { if(null == language) language = new Be(); return language; }
	static function __init__() { get_language(); }
}