package thx.languages;

import thx.culture.Language;

class Ka extends Language {
	function new() {
		name = "ka";
		english = "Georgian";
		native = "ქართული";
		iso2 = "ka";
		iso3 = "kat";
		pluralRule = 0;
		Language.add(this);
	}
	@:isVar public static var language(get_language, null) : Language; static function get_language() { if(null == language) language = new Ka(); return language; }
	static function __init__() { get_language(); }
}