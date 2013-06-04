package thx.cultures;

import thx.culture.Culture;

class TgCyrlTJ extends Culture {
	function new() {
		name = "tg-Cyrl-TJ";
		english = "Tajik (Cyrillic) (Tajikistan)";
		native = "Тоҷикӣ (Тоҷикистон)";
		date = new thx.culture.core.DateTimeInfo(
			["Январ", "Феврал", "Март", "Апрел", "Май", "Июн", "Июл", "Август", "Сентябр", "Октябр", "Ноябр", "Декабр", ""],
			["Янв", "Фев", "Мар", "Апр", "Май", "Июн", "Июл", "Авг", "Сен", "Окт", "Ноя", "Дек", ""],
			["Яш", "Душанбе", "Сешанбе", "Чоршанбе", "Панҷшанбе", "Ҷумъа", "Шанбе"],
			["Яш", "Дш", "Сш", "Чш", "Пш", "Ҷм", "Шн"],
			["Яш", "Дш", "Сш", "Чш", "Пш", "Ҷм", "Шн"],
			null,
			null,
			".",
			":",
			0,
			"%B %Y",
			"%B %d",
			"%e %B %Y",
			"%d.%m.%y",
			"%a, %d %b %Y %H:%M:%S GMT",
			"%e %B %Y %k:%M:%S",
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
		currency = new thx.culture.core.NumberInfo(2, ";", [3, 0], " ", "-n $", "n $");
		percent = new thx.culture.core.NumberInfo(2, ",", [3, 0], " ", "-n %", "n %");
		englishCurrency = "Ruble";
		nativeCurrency = "рубл";
		currencySymbol = "т.р.";
		currencyIso = "TJS";
		englishRegion = "Tajikistan";
		nativeRegion = "Тоҷикистон";
		iso2 = "TJ";
		iso3 = "TAJ";
		isMetric = false;
		Culture.add(this);
	}
	@:isVar public static var culture(get, null) : Culture; static function get_culture() { if(null == culture) culture = new TgCyrlTJ(); return culture; }
}