package thx.cultures;

import thx.culture.Culture;

class TtRU extends Culture {
	function new() {
		language = thx.languages.Tt.language;
		name = "tt-RU";
		english = "Tatar (Russia)";
		native = "Татар (Россия)";
		date = new thx.culture.core.DateTimeInfo(
			["Гыйнварь", "Февраль", "Март", "Апрель", "Май", "Июнь", "Июль", "Август", "Сентябрь", "Октябрь", "Ноябрь", "Декабрь", ""],
			["Гыйнв", "Фев", "Мар", "Апр", "Май", "Июн", "Июл", "Авг", "Сен", "Окт", "Ноя", "Дек", ""],
			["Якшәмбе", "Дүшәмбе", "Сишәмбе", "Чәршәмбе", "Пәнҗешәмбе", "Җомга", "Шимбә"],
			["Якш", "Дүш", "Сиш", "Чәрш", "Пәнҗ", "Җом", "Шим"],
			["Якш", "Дүш", "Сиш", "Чәрш", "Пәнҗ", "Җом", "Шим"],
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
		percent = new thx.culture.core.NumberInfo(2, ",", [3], " ", "-n%", "n%");
		pluralRule = 0;
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
	@:isVar public static var culture(get, null) : Culture; static function get_culture() { if(null == culture) culture = new TtRU(); return culture; }
	static function __init__() { get_culture(); }
}