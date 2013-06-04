package thx.languages;

import thx.culture.Language;

class Da extends Language {
	function new() {
		name = "da";
		english = "Danish";
		native = "dansk";
		iso2 = "da";
		iso3 = "dan";
		pluralRule = 1;
		Language.add(this);
	}
	@:isVar public static var language(get_language, null) : Language; static function get_language() { if(null == language) language = new Da(); return language; }
	static function __init__() { get_language(); }
}