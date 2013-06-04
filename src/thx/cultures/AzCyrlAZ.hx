package thx.cultures;

import thx.culture.Culture;

class AzCyrlAZ extends Culture {
	function new() {
		language = thx.languages.Az.language;
		name = "az-Cyrl-AZ";
		english = "Azeri (Cyrillic, Azerbaijan)";
		native = "Азәрбајҹан (Азәрбајҹан)";
		date = new thx.culture.core.DateTimeInfo(
			["Јанвар", "Феврал", "Март", "Апрел", "Мај", "Ијун", "Ијул", "Август", "Сентјабр", "Октјабр", "Нојабр", "Декабр", ""],
			["Јан", "Фев", "Мар", "Апр", "Мај", "Ијун", "Ијул", "Авг", "Сен", "Окт", "Ноя", "Дек", ""],
			["Базар", "Базар ертәси", "Чәршәнбә ахшамы", "Чәршәнбә", "Ҹүмә ахшамы", "Ҹүмә", "Шәнбә"],
			["Б", "Бе", "Ча", "Ч", "Ҹа", "Ҹ", "Ш"],
			["Б", "Бе", "Ча", "Ч", "Ҹа", "Ҹ", "Ш"],
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
		pluralRule = 1;
		englishCurrency = "Azerbaijanian Manat";
		nativeCurrency = "рубль";
		currencySymbol = "ман.";
		currencyIso = "AZM";
		englishRegion = "Azerbaijan";
		nativeRegion = "Азәрбајҹан";
		iso2 = "AZ";
		iso3 = "AZE";
		isMetric = false;
		Culture.add(this);
	}
	@:isVar public static var culture(get, null) : Culture; static function get_culture() { if(null == culture) culture = new AzCyrlAZ(); return culture; }
	static function __init__() { get_culture(); }
}