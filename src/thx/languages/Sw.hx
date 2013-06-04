package thx.languages;

import thx.culture.Language;

class Sw extends Language {
	function new() {
		name = "sw";
		english = "Kiswahili";
		native = "Kiswahili";
		iso2 = "sw";
		iso3 = "swa";
		pluralRule = 1;
		Language.add(this);
	}
	@:isVar public static var language(get_language, null) : Language; static function get_language() { if(null == language) language = new Sw(); return language; }
	static function __init__() { get_language(); }
}