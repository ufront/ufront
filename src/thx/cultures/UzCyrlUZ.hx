package thx.cultures;

import thx.culture.Culture;

class UzCyrlUZ extends Culture {
	function new() {
		language = thx.languages.Uz.language;
		name = "uz-Cyrl-UZ";
		english = "Uzbek (Cyrillic, Uzbekistan)";
		native = "Ўзбек (Ўзбекистон)";
		date = new thx.culture.core.DateTimeInfo(
			["Январ", "Феврал", "Март", "Апрел", "Май", "Июн", "Июл", "Август", "Сентябр", "Октябр", "Ноябр", "Декабр", ""],
			["Янв", "Фев", "Мар", "Апр", "Май", "Июн", "Июл", "Авг", "Сен", "Окт", "Ноя", "Дек", ""],
			["якшанба", "душанба", "сешанба", "чоршанба", "пайшанба", "жума", "шанба"],
			["якш", "дш", "сш", "чш", "пш", "ж", "ш"],
			["якш", "дш", "сш", "чш", "пш", "ж", "ш"],
			null,
			null,
			".",
			":",
			1,
			"%B %Y",
			"%e-%B",
			"%Y йил %e-%B",
			"%d.%m.%Y",
			"%a, %d %b %Y %H:%M:%S GMT",
			"%Y йил %e-%B %H:%M:%S",
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
		percent = new thx.culture.core.NumberInfo(2, ",", [3], " ", "-n%", "n%");
		pluralRule = 0;
		englishCurrency = "Uzbekistan Sum";
		nativeCurrency = "рубль";
		currencySymbol = "сўм";
		currencyIso = "UZS";
		englishRegion = "Uzbekistan";
		nativeRegion = "Ўзбекистон Республикаси";
		iso2 = "UZ";
		iso3 = "UZB";
		isMetric = false;
		Culture.add(this);
	}
	@:isVar public static var culture(get, null) : Culture; static function get_culture() { if(null == culture) culture = new UzCyrlUZ(); return culture; }
	static function __init__() { get_culture(); }
}