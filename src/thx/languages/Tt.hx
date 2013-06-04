package thx.languages;

import thx.culture.Language;

class Tt extends Language {
	function new() {
		name = "tt";
		english = "Tatar";
		native = "Татар";
		iso2 = "tt";
		iso3 = "tat";
		pluralRule = 0;
		Language.add(this);
	}
	@:isVar public static var language(get_language, null) : Language; static function get_language() { if(null == language) language = new Tt(); return language; }
	static function __init__() { get_language(); }
}