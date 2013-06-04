package thx.languages;

import thx.culture.Language;

class Hr extends Language {
	function new() {
		name = "hr";
		english = "Croatian";
		native = "hrvatski";
		iso2 = "hr";
		iso3 = "hrv";
		pluralRule = 7;
		Language.add(this);
	}
	@:isVar public static var language(get_language, null) : Language; static function get_language() { if(null == language) language = new Hr(); return language; }
	static function __init__() { get_language(); }
}