package thx.languages;

import thx.culture.Language;

class Af extends Language {
	function new() {
		name = "af";
		english = "Afrikaans";
		native = "Afrikaans";
		iso2 = "af";
		iso3 = "afr";
		pluralRule = 1;
		Language.add(this);
	}
	@:isVar public static var language(get_language, null) : Language; static function get_language() { if(null == language) language = new Af(); return language; }
	static function __init__() { get_language(); }
}