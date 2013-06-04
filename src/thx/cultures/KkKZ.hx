package thx.cultures;

import thx.culture.Culture;

class KkKZ extends Culture {
	function new() {
		language = thx.languages.Kk.language;
		name = "kk-KZ";
		english = "Kazakh (Kazakhstan)";
		native = "Қазақ (Қазақстан)";
		date = new thx.culture.core.DateTimeInfo(
			["қаңтар", "ақпан", "наурыз", "сәуір", "мамыр", "маусым", "шілде", "тамыз", "қыркүйек", "қазан", "қараша", "желтоқсан", ""],
			["Қаң", "Ақп", "Нау", "Сәу", "Мам", "Мау", "Шіл", "Там", "Қыр", "Қаз", "Қар", "Жел", ""],
			["Жексенбі", "Дүйсенбі", "Сейсенбі", "Сәрсенбі", "Бейсенбі", "Жұма", "Сенбі"],
			["Жк", "Дс", "Сс", "Ср", "Бс", "Жм", "Сн"],
			["Жк", "Дс", "Сс", "Ср", "Бс", "Жм", "Сн"],
			null,
			null,
			".",
			":",
			1,
			"%B %Y",
			"%e %B",
			"%e %B %Y ж.",
			"%d.%m.%Y",
			"%a, %d %b %Y %H:%M:%S GMT",
			"%e %B %Y ж. %k:%M:%S",
			"%Y-%m-%d %H:%M:%SZ",
			"%Y-%m-%dT%H:%M:%S",
			"%k:%M:%S",
			"%k:%M");
		symbolNaN = "NaN";
		symbolPercent = "%";
		symbolPermille = "‰";
		signNeg = "-";
		signPos = "+";
		symbolNegInf = "-Infinity";
		symbolPosInf = "Infinity";
		number = new thx.culture.core.NumberInfo(2, ",", [3], " ", "-n", "n");
		currency = new thx.culture.core.NumberInfo(2, "-", [3], " ", "-$n", "$n");
		percent = new thx.culture.core.NumberInfo(2, ",", [3], " ", "-n%", "n%");
		pluralRule = 1;
		englishCurrency = "Tenge";
		nativeCurrency = "Т";
		currencySymbol = "Т";
		currencyIso = "KZT";
		englishRegion = "Kazakhstan";
		nativeRegion = "Қазақстан";
		iso2 = "KZ";
		iso3 = "KAZ";
		isMetric = false;
		Culture.add(this);
	}
	@:isVar public static var culture(get, null) : Culture; static function get_culture() { if(null == culture) culture = new KkKZ(); return culture; }
	static function __init__() { get_culture(); }
}