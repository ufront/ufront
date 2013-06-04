package thx.cultures;

import thx.culture.Culture;

class RuRU extends Culture {
	function new() {
		language = thx.languages.Ru.language;
		name = "ru-RU";
		english = "Russian (Russia)";
		native = "русский (Россия)";
		date = new thx.culture.core.DateTimeInfo(
			["Январь", "Февраль", "Март", "Апрель", "Май", "Июнь", "Июль", "Август", "Сентябрь", "Октябрь", "Ноябрь", "Декабрь", ""],
			["янв", "фев", "мар", "апр", "май", "июн", "июл", "авг", "сен", "окт", "ноя", "дек", ""],
			["воскресенье", "понедельник", "вторник", "среда", "четверг", "пятница", "суббота"],
			["Вс", "Пн", "Вт", "Ср", "Чт", "Пт", "Сб"],
			["Вс", "Пн", "Вт", "Ср", "Чт", "Пт", "Сб"],
			null,
			null,
			".",
			":",
			1,
			"%B %Y г.",
			"%B %d",
			"%e %B %Y г.",
			"%d.%m.%Y",
			"%a, %d %b %Y %H:%M:%S GMT",
			"%e %B %Y г. %k:%M:%S",
			"%Y-%m-%d %H:%M:%SZ",
			"%Y-%m-%dT%H:%M:%S",
			"%k:%M:%S",
			"%k:%M");
		symbolNaN = "NaN";
		symbolPercent = "%";
		symbolPermille = "‰";
		signNeg = "-";
		signPos = "+";
		symbolNegInf = "-бесконечность";
		symbolPosInf = "бесконечность";
		number = new thx.culture.core.NumberInfo(2, ",", [3], " ", "-n", "n");
		currency = new thx.culture.core.NumberInfo(2, ",", [3], " ", "-n$", "n$");
		percent = new thx.culture.core.NumberInfo(2, ",", [3], " ", "-n%", "n%");
		pluralRule = 7;
		englishCurrency = "Russian Ruble";
		nativeCurrency = "рубль";
		currencySymbol = "р.";
		currencyIso = "RUR";
		englishRegion = "Russia";
		nativeRegion = "Россия";
		iso2 = "RU";
		iso3 = "RUS";
		isMetric = false;
		Culture.add(this);
	}
	@:isVar public static var culture(get, null) : Culture; static function get_culture() { if(null == culture) culture = new RuRU(); return culture; }
	static function __init__() { get_culture(); }
}