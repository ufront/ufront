package thx.languages;

import thx.culture.Language;

class Kok extends Language {
	function new() {
		name = "kok";
		english = "Konkani";
		native = "कोंकणी";
		iso2 = "kok";
		iso3 = "kok";
		pluralRule = 1;
		Language.add(this);
	}
	@:isVar public static var language(get_language, null) : Language; static function get_language() { if(null == language) language = new Kok(); return language; }
	static function __init__() { get_language(); }
}