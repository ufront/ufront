package thx.languages;

import thx.culture.Language;

class Uk extends Language {
	function new() {
		name = "uk";
		english = "Ukrainian";
		native = "україньска";
		iso2 = "uk";
		iso3 = "ukr";
		pluralRule = 7;
		Language.add(this);
	}
	@:isVar public static var language(get_language, null) : Language; static function get_language() { if(null == language) language = new Uk(); return language; }
	static function __init__() { get_language(); }
}