package thx.languages;

import thx.culture.Language;

class Sr extends Language {
	function new() {
		name = "sr";
		english = "Serbian";
		native = "srpski";
		iso2 = "sr";
		iso3 = "srp";
		pluralRule = 7;
		Language.add(this);
	}
	@:isVar public static var language(get_language, null) : Language; static function get_language() { if(null == language) language = new Sr(); return language; }
	static function __init__() { get_language(); }
}