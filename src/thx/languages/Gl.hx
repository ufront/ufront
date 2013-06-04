package thx.languages;

import thx.culture.Language;

class Gl extends Language {
	function new() {
		name = "gl";
		english = "Galician";
		native = "galego";
		iso2 = "gl";
		iso3 = "glg";
		pluralRule = 1;
		Language.add(this);
	}
	@:isVar public static var language(get_language, null) : Language; static function get_language() { if(null == language) language = new Gl(); return language; }
	static function __init__() { get_language(); }
}