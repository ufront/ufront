package thx.languages;

import thx.culture.Language;

class Pa extends Language {
	function new() {
		name = "pa";
		english = "Punjabi";
		native = "ਪੰਜਾਬੀ";
		iso2 = "pa";
		iso3 = "pan";
		pluralRule = 1;
		Language.add(this);
	}
	@:isVar public static var language(get_language, null) : Language; static function get_language() { if(null == language) language = new Pa(); return language; }
	static function __init__() { get_language(); }
}