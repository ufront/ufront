package thx.languages;

import thx.culture.Language;

class Cs extends Language {
	function new() {
		name = "cs";
		english = "Czech";
		native = "čeština";
		iso2 = "cs";
		iso3 = "ces";
		pluralRule = 8;
		Language.add(this);
	}
	@:isVar public static var language(get_language, null) : Language; static function get_language() { if(null == language) language = new Cs(); return language; }
	static function __init__() { get_language(); }
}