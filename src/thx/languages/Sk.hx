package thx.languages;

import thx.culture.Language;

class Sk extends Language {
	function new() {
		name = "sk";
		english = "Slovak";
		native = "slovenčina";
		iso2 = "sk";
		iso3 = "slk";
		pluralRule = 8;
		Language.add(this);
	}
	@:isVar public static var language(get_language, null) : Language; static function get_language() { if(null == language) language = new Sk(); return language; }
	static function __init__() { get_language(); }
}