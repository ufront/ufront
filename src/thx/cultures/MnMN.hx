package thx.cultures;

import thx.culture.Culture;

class MnMN extends Culture {
	function new() {
		language = thx.languages.Mn.language;
		name = "mn-MN";
		english = "Mongolian (Cyrillic, Mongolia)";
		native = "Монгол хэл (Монгол улс)";
		date = new thx.culture.core.DateTimeInfo(
			["1 дүгээр сар", "2 дугаар сар", "3 дугаар сар", "4 дүгээр сар", "5 дугаар сар", "6 дугаар сар", "7 дугаар сар", "8 дугаар сар", "9 дүгээр сар", "10 дугаар сар", "11 дүгээр сар", "12 дугаар сар", ""],
			["I", "II", "III", "IV", "V", "VI", "VII", "VШ", "IX", "X", "XI", "XII", ""],
			["Ням", "Даваа", "Мягмар", "Лхагва", "Пүрэв", "Баасан", "Бямба"],
			["Ня", "Да", "Мя", "Лх", "Пү", "Ба", "Бя"],
			["Ня", "Да", "Мя", "Лх", "Пү", "Ба", "Бя"],
			null,
			null,
			".",
			":",
			1,
			"%Y он %B",
			"%e %B",
			"%Y оны %B %e",
			"%y.%m.%d",
			"%a, %d %b %Y %H:%M:%S GMT",
			"%Y оны %B %e %k:%M:%S",
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
		currency = new thx.culture.core.NumberInfo(2, ",", [3], " ", "-n$", "n$");
		percent = new thx.culture.core.NumberInfo(2, ",", [3], " ", "-n %", "n %");
		pluralRule = 1;
		englishCurrency = "Tugrik";
		nativeCurrency = "Төгрөг";
		currencySymbol = "₮";
		currencyIso = "MNT";
		englishRegion = "Mongolia";
		nativeRegion = "Монгол улс";
		iso2 = "MN";
		iso3 = "MNG";
		isMetric = false;
		Culture.add(this);
	}
	@:isVar public static var culture(get, null) : Culture; static function get_culture() { if(null == culture) culture = new MnMN(); return culture; }
	static function __init__() { get_culture(); }
}