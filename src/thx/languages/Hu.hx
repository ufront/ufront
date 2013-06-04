package thx.languages;

import thx.culture.Language;

class Hu extends Language {
	function new() {
		name = "hu";
		english = "Hungarian";
		native = "magyar";
		iso2 = "hu";
		iso3 = "hun";
		pluralRule = 1;
		Language.add(this);
	}
	@:isVar public static var language(get_language, null) : Language; static function get_language() { if(null == language) language = new Hu(); return language; }
	static function __init__() { get_language(); }
}