package thx.languages;

import thx.culture.Language;

class Et extends Language {
	function new() {
		name = "et";
		english = "Estonian";
		native = "eesti";
		iso2 = "et";
		iso3 = "est";
		pluralRule = 1;
		Language.add(this);
	}
	@:isVar public static var language(get_language, null) : Language; static function get_language() { if(null == language) language = new Et(); return language; }
	static function __init__() { get_language(); }
}