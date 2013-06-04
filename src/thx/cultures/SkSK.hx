package thx.cultures;

import thx.culture.Culture;

class SkSK extends Culture {
	function new() {
		language = thx.languages.Sk.language;
		name = "sk-SK";
		english = "Slovak (Slovakia)";
		native = "slovenčina (Slovenská republika)";
		date = new thx.culture.core.DateTimeInfo(
			["január", "február", "marec", "apríl", "máj", "jún", "júl", "august", "september", "október", "november", "december", ""],
			["I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX", "X", "XI", "XII", ""],
			["nedeľa", "pondelok", "utorok", "streda", "štvrtok", "piatok", "sobota"],
			["ne", "po", "ut", "st", "št", "pi", "so"],
			["ne", "po", "ut", "st", "št", "pi", "so"],
			null,
			null,
			". ",
			":",
			1,
			"%B %Y",
			"%d %B",
			"%e. %B %Y",
			"%e. %f. %Y",
			"%a, %d %b %Y %H:%M:%S GMT",
			"%e. %B %Y %k:%M:%S",
			"%Y-%m-%d %H:%M:%SZ",
			"%Y-%m-%dT%H:%M:%S",
			"%k:%M:%S",
			"%k:%M");
		symbolNaN = "Nie je číslo";
		symbolPercent = "%";
		symbolPermille = "‰";
		signNeg = "-";
		signPos = "+";
		symbolNegInf = "-nekonečno";
		symbolPosInf = "+nekonečno";
		number = new thx.culture.core.NumberInfo(2, ",", [3], " ", "-n", "n");
		currency = new thx.culture.core.NumberInfo(2, ",", [3], " ", "-n $", "n $");
		percent = new thx.culture.core.NumberInfo(2, ",", [3], " ", "-n%", "n%");
		pluralRule = 8;
		englishCurrency = "Euro";
		nativeCurrency = "euro";
		currencySymbol = "€";
		currencyIso = "EUR";
		englishRegion = "Slovakia";
		nativeRegion = "Slovenská republika";
		iso2 = "SK";
		iso3 = "SVK";
		isMetric = false;
		Culture.add(this);
	}
	@:isVar public static var culture(get, null) : Culture; static function get_culture() { if(null == culture) culture = new SkSK(); return culture; }
	static function __init__() { get_culture(); }
}