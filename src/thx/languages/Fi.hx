package thx.languages;

import thx.culture.Language;

class Fi extends Language {
	function new() {
		name = "fi";
		english = "Finnish";
		native = "suomi";
		iso2 = "fi";
		iso3 = "fin";
		pluralRule = 1;
		Language.add(this);
	}
	@:isVar public static var language(get_language, null) : Language; static function get_language() { if(null == language) language = new Fi(); return language; }
	static function __init__() { get_language(); }
}