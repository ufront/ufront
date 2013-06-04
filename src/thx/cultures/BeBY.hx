package thx.cultures;

import thx.culture.Culture;

class BeBY extends Culture {
	function new() {
		language = thx.languages.Be.language;
		name = "be-BY";
		english = "Belarusian (Belarus)";
		native = "Беларускі (Беларусь)";
		date = new thx.culture.core.DateTimeInfo(
			["Студзень", "Люты", "Сакавік", "Красавік", "Май", "Чэрвень", "Ліпень", "Жнівень", "Верасень", "Кастрычнік", "Лістапад", "Снежань", ""],
			["Сту", "Лют", "Сак", "Кра", "Май", "Чэр", "Ліп", "Жні", "Вер", "Кас", "Ліс", "Сне", ""],
			["нядзеля", "панядзелак", "аўторак", "серада", "чацвер", "пятніца", "субота"],
			["нд", "пн", "аў", "ср", "чц", "пт", "сб"],
			["нд", "пн", "аў", "ср", "чц", "пт", "сб"],
			null,
			null,
			".",
			":",
			1,
			"%B %Y",
			"%e %B",
			"%e %B %Y",
			"%d.%m.%Y",
			"%a, %d %b %Y %H:%M:%S GMT",
			"%e %B %Y %k:%M:%S",
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
		currency = new thx.culture.core.NumberInfo(2, ",", [3], " ", "-n $", "n $");
		percent = new thx.culture.core.NumberInfo(2, ",", [3], " ", "-n %", "n %");
		pluralRule = 7;
		englishCurrency = "Belarusian Ruble";
		nativeCurrency = "рубль";
		currencySymbol = "р.";
		currencyIso = "BYB";
		englishRegion = "Belarus";
		nativeRegion = "Беларусь";
		iso2 = "BY";
		iso3 = "BLR";
		isMetric = false;
		Culture.add(this);
	}
	@:isVar public static var culture(get, null) : Culture; static function get_culture() { if(null == culture) culture = new BeBY(); return culture; }
	static function __init__() { get_culture(); }
}