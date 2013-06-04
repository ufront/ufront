package thx.languages;

import thx.culture.Language;

class Nl extends Language {
	function new() {
		name = "nl";
		english = "Dutch";
		native = "Nederlands";
		iso2 = "nl";
		iso3 = "nld";
		pluralRule = 1;
		Language.add(this);
	}
	@:isVar public static var language(get_language, null) : Language; static function get_language() { if(null == language) language = new Nl(); return language; }
	static function __init__() { get_language(); }
}