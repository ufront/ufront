package thx.languages;

import thx.culture.Language;

class Ky extends Language {
	function new() {
		name = "ky";
		english = "Kyrgyz";
		native = "Кыргыз";
		iso2 = "ky";
		iso3 = "kir";
		pluralRule = 1;
		Language.add(this);
	}
	@:isVar public static var language(get_language, null) : Language; static function get_language() { if(null == language) language = new Ky(); return language; }
	static function __init__() { get_language(); }
}