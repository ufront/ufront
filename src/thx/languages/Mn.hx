package thx.languages;

import thx.culture.Language;

class Mn extends Language {
	function new() {
		name = "mn";
		english = "Mongolian";
		native = "Монгол хэл";
		iso2 = "mn";
		iso3 = "mon";
		pluralRule = 1;
		Language.add(this);
	}
	@:isVar public static var language(get_language, null) : Language; static function get_language() { if(null == language) language = new Mn(); return language; }
	static function __init__() { get_language(); }
}