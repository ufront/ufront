package thx.cultures;

import thx.culture.Culture;

class CsCZ extends Culture {
	function new() {
		language = thx.languages.Cs.language;
		name = "cs-CZ";
		english = "Czech (Czech Republic)";
		native = "čeština (Česká republika)";
		date = new thx.culture.core.DateTimeInfo(
			["leden", "únor", "březen", "duben", "květen", "červen", "červenec", "srpen", "září", "říjen", "listopad", "prosinec", ""],
			["I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX", "X", "XI", "XII", ""],
			["neděle", "pondělí", "úterý", "středa", "čtvrtek", "pátek", "sobota"],
			["ne", "po", "út", "st", "čt", "pá", "so"],
			["ne", "po", "út", "st", "čt", "pá", "so"],
			"dop.",
			"odp.",
			".",
			":",
			1,
			"%B %Y",
			"%d %B",
			"%e. %B %Y",
			"%e.%f.%Y",
			"%a, %d %b %Y %H:%M:%S GMT",
			"%e. %B %Y %k:%M:%S",
			"%Y-%m-%d %H:%M:%SZ",
			"%Y-%m-%dT%H:%M:%S",
			"%k:%M:%S",
			"%k:%M");
		symbolNaN = "Není číslo";
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
		englishCurrency = "Czech Koruna";
		nativeCurrency = "Koruna Česká";
		currencySymbol = "Kč";
		currencyIso = "CZK";
		englishRegion = "Czech Republic";
		nativeRegion = "Česká republika";
		iso2 = "CZ";
		iso3 = "CZE";
		isMetric = false;
		Culture.add(this);
	}
	@:isVar public static var culture(get, null) : Culture; static function get_culture() { if(null == culture) culture = new CsCZ(); return culture; }
	static function __init__() { get_culture(); }
}