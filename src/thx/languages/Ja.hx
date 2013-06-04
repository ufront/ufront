package thx.languages;

import thx.culture.Language;

class Ja extends Language {
	function new() {
		name = "ja";
		english = "Japanese";
		native = "日本語";
		iso2 = "ja";
		iso3 = "jpn";
		pluralRule = 0;
		Language.add(this);
	}
	@:isVar public static var language(get_language, null) : Language; static function get_language() { if(null == language) language = new Ja(); return language; }
	static function __init__() { get_language(); }
}