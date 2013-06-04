package thx.cultures;

import thx.culture.Culture;

class BaRU extends Culture {
	function new() {
		name = "ba-RU";
		english = "Bashkir (Russia)";
		native = "Башҡорт (Россия)";
		date = new thx.culture.core.DateTimeInfo(
			["ғинуар", "февраль", "март", "апрель", "май", "июнь", "июль", "август", "сентябрь", "октябрь", "ноябрь", "декабрь", ""],
			["ғин", "фев", "мар", "апр", "май", "июн", "июл", "авг", "сен", "окт", "ноя", "дек", ""],
			["Йәкшәмбе", "Дүшәмбе", "Шишәмбе", "Шаршамбы", "Кесаҙна", "Йома", "Шәмбе"],
			["Йш", "Дш", "Шш", "Шр", "Кс", "Йм", "Шб"],
			["Йш", "Дш", "Шш", "Шр", "Кс", "Йм", "Шб"],
			null,
			null,
			".",
			":",
			1,
			"%B %Y",
			"%B %d",
			"%e %B %Y й",
			"%d.%m.%y",
			"%a, %d %b %Y %H:%M:%S GMT",
			"%e %B %Y й %k:%M:%S",
			"%Y-%m-%d %H:%M:%SZ",
			"%Y-%m-%dT%H:%M:%S",
			"%k:%M:%S",
			"%k:%M:%S");
		symbolNaN = "NaN";
		symbolPercent = "%";
		symbolPermille = "‰";
		signNeg = "-";
		signPos = "+";
		symbolNegInf = "-бесконечность";
		symbolPosInf = "бесконечность";
		number = new thx.culture.core.NumberInfo(2, ",", [3, 0], " ", "-n", "n");
		currency = new thx.culture.core.NumberInfo(2, ",", [3, 0], " ", "-n $", "n $");
		percent = new thx.culture.core.NumberInfo(2, ",", [3, 0], " ", "-n %", "n %");
		englishCurrency = "Russian Ruble";
		nativeCurrency = "һум";
		currencySymbol = "һ.";
		currencyIso = "RUB";
		englishRegion = "Russia";
		nativeRegion = "Россия";
		iso2 = "RU";
		iso3 = "RUS";
		isMetric = false;
		Culture.add(this);
	}
	@:isVar public static var culture(get, null) : Culture; static function get_culture() { if(null == culture) culture = new BaRU(); return culture; }
}