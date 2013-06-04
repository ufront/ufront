package thx.languages;

import thx.culture.Language;

class Hy extends Language {
	function new() {
		name = "hy";
		english = "Armenian";
		native = "Հայերեն";
		iso2 = "hy";
		iso3 = "hye";
		pluralRule = 1;
		Language.add(this);
	}
	@:isVar public static var language(get_language, null) : Language; static function get_language() { if(null == language) language = new Hy(); return language; }
	static function __init__() { get_language(); }
}