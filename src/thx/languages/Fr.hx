package thx.languages;

import thx.culture.Language;

class Fr extends Language {
	function new() {
		name = "fr";
		english = "French";
		native = "français";
		iso2 = "fr";
		iso3 = "fra";
		pluralRule = 2;
		Language.add(this);
	}
	@:isVar public static var language(get_language, null) : Language; static function get_language() { if(null == language) language = new Fr(); return language; }
	static function __init__() { get_language(); }
}