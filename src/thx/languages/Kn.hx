package thx.languages;

import thx.culture.Language;

class Kn extends Language {
	function new() {
		name = "kn";
		english = "Kannada";
		native = "ಕನ್ನಡ";
		iso2 = "kn";
		iso3 = "kan";
		pluralRule = 0;
		Language.add(this);
	}
	@:isVar public static var language(get_language, null) : Language; static function get_language() { if(null == language) language = new Kn(); return language; }
	static function __init__() { get_language(); }
}