package thx.languages;

import thx.culture.Language;

class Ur extends Language {
	function new() {
		name = "ur";
		english = "Urdu";
		native = "اُردو";
		iso2 = "ur";
		iso3 = "urd";
		pluralRule = 1;
		Language.add(this);
	}
	@:isVar public static var language(get_language, null) : Language; static function get_language() { if(null == language) language = new Ur(); return language; }
	static function __init__() { get_language(); }
}