package thx.languages;

import thx.culture.Language;

class Ca extends Language {
	function new() {
		name = "ca";
		english = "Catalan";
		native = "català";
		iso2 = "ca";
		iso3 = "cat";
		pluralRule = 1;
		Language.add(this);
	}
	@:isVar public static var language(get_language, null) : Language; static function get_language() { if(null == language) language = new Ca(); return language; }
	static function __init__() { get_language(); }
}