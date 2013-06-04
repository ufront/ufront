package thx.languages;

import thx.culture.Language;

class Lt extends Language {
	function new() {
		name = "lt";
		english = "Lithuanian";
		native = "lietuvių";
		iso2 = "lt";
		iso3 = "lit";
		pluralRule = 1;
		Language.add(this);
	}
	@:isVar public static var language(get_language, null) : Language; static function get_language() { if(null == language) language = new Lt(); return language; }
	static function __init__() { get_language(); }
}