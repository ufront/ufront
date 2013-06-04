package thx.languages;

import thx.culture.Language;

class Pt extends Language {
	function new() {
		name = "pt";
		english = "Portuguese";
		native = "Português";
		iso2 = "pt";
		iso3 = "por";
		pluralRule = 1;
		Language.add(this);
	}
	@:isVar public static var language(get_language, null) : Language; static function get_language() { if(null == language) language = new Pt(); return language; }
	static function __init__() { get_language(); }
}