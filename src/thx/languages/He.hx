package thx.languages;

import thx.culture.Language;

class He extends Language {
	function new() {
		name = "he";
		english = "Hebrew";
		native = "עברית";
		iso2 = "he";
		iso3 = "heb";
		pluralRule = 1;
		Language.add(this);
	}
	@:isVar public static var language(get_language, null) : Language; static function get_language() { if(null == language) language = new He(); return language; }
	static function __init__() { get_language(); }
}