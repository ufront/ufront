package thx.languages;

import thx.culture.Language;

class Is extends Language {
	function new() {
		name = "is";
		english = "Icelandic";
		native = "íslenska";
		iso2 = "is";
		iso3 = "isl";
		pluralRule = 1;
		Language.add(this);
	}
	@:isVar public static var language(get_language, null) : Language; static function get_language() { if(null == language) language = new Is(); return language; }
	static function __init__() { get_language(); }
}