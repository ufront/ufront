package thx.languages;

import thx.culture.Language;

class Dv extends Language {
	function new() {
		name = "dv";
		english = "Divehi";
		native = "ދިވެހިބަސް";
		iso2 = "dv";
		iso3 = "div";
		pluralRule = 1;
		Language.add(this);
	}
	@:isVar public static var language(get_language, null) : Language; static function get_language() { if(null == language) language = new Dv(); return language; }
	static function __init__() { get_language(); }
}