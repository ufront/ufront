package thx.languages;

import thx.culture.Language;

class Bg extends Language {
	function new() {
		name = "bg";
		english = "Bulgarian";
		native = "български";
		iso2 = "bg";
		iso3 = "bul";
		pluralRule = 1;
		Language.add(this);
	}
	@:isVar public static var language(get_language, null) : Language; static function get_language() { if(null == language) language = new Bg(); return language; }
	static function __init__() { get_language(); }
}