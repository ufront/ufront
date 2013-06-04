package thx.languages;

import thx.culture.Language;

class Sl extends Language {
	function new() {
		name = "sl";
		english = "Slovenian";
		native = "slovenski";
		iso2 = "sl";
		iso3 = "slv";
		pluralRule = 10;
		Language.add(this);
	}
	@:isVar public static var language(get_language, null) : Language; static function get_language() { if(null == language) language = new Sl(); return language; }
	static function __init__() { get_language(); }
}