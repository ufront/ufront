package thx.languages;

import thx.culture.Language;

class Hi extends Language {
	function new() {
		name = "hi";
		english = "Hindi";
		native = "हिंदी";
		iso2 = "hi";
		iso3 = "hin";
		pluralRule = 1;
		Language.add(this);
	}
	@:isVar public static var language(get_language, null) : Language; static function get_language() { if(null == language) language = new Hi(); return language; }
	static function __init__() { get_language(); }
}