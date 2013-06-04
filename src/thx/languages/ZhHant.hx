package thx.languages;

import thx.culture.Language;

class ZhHant extends Language {
	function new() {
		name = "zh-Hant";
		english = "Chinese (Traditional)";
		native = "中文(繁體)";
		iso2 = "zh";
		iso3 = "zho";
		pluralRule = 1;
		Language.add(this);
	}
	@:isVar public static var language(get_language, null) : Language; static function get_language() { if(null == language) language = new ZhHant(); return language; }
	static function __init__() { get_language(); }
}