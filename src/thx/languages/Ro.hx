package thx.languages;

import thx.culture.Language;

class Ro extends Language {
	function new() {
		name = "ro";
		english = "Romanian";
		native = "română";
		iso2 = "ro";
		iso3 = "ron";
		pluralRule = 5;
		Language.add(this);
	}
	@:isVar public static var language(get_language, null) : Language; static function get_language() { if(null == language) language = new Ro(); return language; }
	static function __init__() { get_language(); }
}