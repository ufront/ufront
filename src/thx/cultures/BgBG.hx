package thx.cultures;

import thx.culture.Culture;

class BgBG extends Culture {
	function new() {
		language = thx.languages.Bg.language;
		name = "bg-BG";
		english = "Bulgarian (Bulgaria)";
		native = "български (България)";
		date = new thx.culture.core.DateTimeInfo(
			["Януари", "Февруари", "Март", "Април", "Май", "Юни", "Юли", "Август", "Септември", "Октомври", "Ноември", "Декември", ""],
			["Януари", "Февруари", "Март", "Април", "Май", "Юни", "Юли", "Август", "Септември", "Октомври", "Ноември", "Декември", ""],
			["неделя", "понеделник", "вторник", "сряда", "четвъртък", "петък", "събота"],
			["Нд", "Пн", "Вт", "Ср", "Чт", "Пт", "Сб"],
			["не", "по", "вт", "ср", "че", "пе", "съ"],
			null,
			null,
			".",
			":",
			1,
			"%B %Y г.",
			"%d %B",
			"%d %B %Y г.",
			"%d.%f.%Y г.",
			"%a, %d %b %Y %H:%M:%S GMT",
			"%d %B %Y г. %H:%M:%S",
			"%Y-%m-%d %H:%M:%SZ",
			"%Y-%m-%dT%H:%M:%S",
			"%H:%M:%S",
			"%H:%M");
		symbolNaN = "NaN";
		symbolPercent = "%";
		symbolPermille = "‰";
		signNeg = "-";
		signPos = "+";
		symbolNegInf = "-Infinity";
		symbolPosInf = "Infinity";
		number = new thx.culture.core.NumberInfo(2, ",", [3], " ", "-n", "n");
		currency = new thx.culture.core.NumberInfo(2, ",", [3], " ", "-n $", "n $");
		percent = new thx.culture.core.NumberInfo(2, ",", [3], " ", "-n %", "n %");
		pluralRule = 1;
		englishCurrency = "Bulgarian Lev";
		nativeCurrency = "лв.";
		currencySymbol = "лв";
		currencyIso = "BGL";
		englishRegion = "Bulgaria";
		nativeRegion = "България";
		iso2 = "BG";
		iso3 = "BGR";
		isMetric = false;
		Culture.add(this);
	}
	@:isVar public static var culture(get, null) : Culture; static function get_culture() { if(null == culture) culture = new BgBG(); return culture; }
	static function __init__() { get_culture(); }
}