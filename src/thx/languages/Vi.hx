package thx.languages;

import thx.culture.Language;

class Vi extends Language {
	function new() {
		name = "vi";
		english = "Vietnamese";
		native = "Tiếng Việt";
		iso2 = "vi";
		iso3 = "vie";
		pluralRule = 0;
		Language.add(this);
	}
	@:isVar public static var language(get_language, null) : Language; static function get_language() { if(null == language) language = new Vi(); return language; }
	static function __init__() { get_language(); }
}