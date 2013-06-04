package thx.languages;

import thx.culture.Language;

class Ko extends Language {
	function new() {
		name = "ko";
		english = "Korean";
		native = "한국어";
		iso2 = "ko";
		iso3 = "kor";
		pluralRule = 0;
		Language.add(this);
	}
	@:isVar public static var language(get_language, null) : Language; static function get_language() { if(null == language) language = new Ko(); return language; }
	static function __init__() { get_language(); }
}