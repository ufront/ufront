package thx.languages;

import thx.culture.Language;

class Syr extends Language {
	function new() {
		name = "syr";
		english = "Syriac";
		native = "ܣܘܪܝܝܐ";
		iso2 = "syr";
		iso3 = "syr";
		pluralRule = 12;
		Language.add(this);
	}
	@:isVar public static var language(get_language, null) : Language; static function get_language() { if(null == language) language = new Syr(); return language; }
	static function __init__() { get_language(); }
}