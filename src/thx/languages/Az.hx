package thx.languages;

import thx.culture.Language;

class Az extends Language {
	function new() {
		name = "az";
		english = "Azeri";
		native = "Azərbaycan­ılı";
		iso2 = "az";
		iso3 = "aze";
		pluralRule = 1;
		Language.add(this);
	}
	@:isVar public static var language(get_language, null) : Language; static function get_language() { if(null == language) language = new Az(); return language; }
	static function __init__() { get_language(); }
}