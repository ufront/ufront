package thx.languages;

import thx.culture.Language;

class Te extends Language {
	function new() {
		name = "te";
		english = "Telugu";
		native = "తెలుగు";
		iso2 = "te";
		iso3 = "tel";
		pluralRule = 1;
		Language.add(this);
	}
	@:isVar public static var language(get_language, null) : Language; static function get_language() { if(null == language) language = new Te(); return language; }
	static function __init__() { get_language(); }
}