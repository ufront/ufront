package thx.languages;

import thx.culture.Language;

class Mk extends Language {
	function new() {
		name = "mk";
		english = "Macedonian";
		native = "македонски јазик";
		iso2 = "mk";
		iso3 = "mkd";
		pluralRule = 14;
		Language.add(this);
	}
	@:isVar public static var language(get_language, null) : Language; static function get_language() { if(null == language) language = new Mk(); return language; }
	static function __init__() { get_language(); }
}