package thx.languages;

import thx.culture.Language;

class Eu extends Language {
	function new() {
		name = "eu";
		english = "Basque";
		native = "euskara";
		iso2 = "eu";
		iso3 = "eus";
		pluralRule = 1;
		Language.add(this);
	}
	@:isVar public static var language(get_language, null) : Language; static function get_language() { if(null == language) language = new Eu(); return language; }
	static function __init__() { get_language(); }
}