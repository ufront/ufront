package thx.languages;

import thx.culture.Language;

class Id extends Language {
	function new() {
		name = "id";
		english = "Indonesian";
		native = "Bahasa Indonesia";
		iso2 = "id";
		iso3 = "ind";
		pluralRule = 0;
		Language.add(this);
	}
	@:isVar public static var language(get_language, null) : Language; static function get_language() { if(null == language) language = new Id(); return language; }
	static function __init__() { get_language(); }
}