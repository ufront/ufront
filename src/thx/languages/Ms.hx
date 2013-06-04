package thx.languages;

import thx.culture.Language;

class Ms extends Language {
	function new() {
		name = "ms";
		english = "Malay";
		native = "Bahasa Malaysia";
		iso2 = "ms";
		iso3 = "msa";
		pluralRule = 0;
		Language.add(this);
	}
	@:isVar public static var language(get_language, null) : Language; static function get_language() { if(null == language) language = new Ms(); return language; }
	static function __init__() { get_language(); }
}