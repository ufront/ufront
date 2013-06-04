package thx.cultures;

import thx.culture.Culture;

class SrLatnCS extends Culture {
	function new() {
		language = thx.languages.Sr.language;
		name = "sr-Latn-CS";
		english = "Serbian (Latin, Serbia and Montenegro (Former))";
		native = "srpski (Srbija i Crna Gora (Prethodno))";
		date = new thx.culture.core.DateTimeInfo(
			["januar", "februar", "mart", "april", "maj", "jun", "jul", "avgust", "septembar", "oktobar", "novembar", "decembar", ""],
			["jan", "feb", "mar", "apr", "maj", "jun", "jul", "avg", "sep", "okt", "nov", "dec", ""],
			["nedelja", "ponedeljak", "utorak", "sreda", "četvrtak", "petak", "subota"],
			["ned", "pon", "uto", "sre", "čet", "pet", "sub"],
			["ne", "po", "ut", "sr", "če", "pe", "su"],
			null,
			null,
			".",
			":",
			1,
			"%B %Y",
			"%e. %B",
			"%e. %B %Y",
			"%e.%f.%Y",
			"%a, %d %b %Y %H:%M:%S GMT",
			"%e. %B %Y %k:%M:%S",
			"%Y-%m-%d %H:%M:%SZ",
			"%Y-%m-%dT%H:%M:%S",
			"%k:%M:%S",
			"%k:%M");
		symbolNaN = "NaN";
		symbolPercent = "%";
		symbolPermille = "‰";
		signNeg = "-";
		signPos = "+";
		symbolNegInf = "-beskonačnost";
		symbolPosInf = "+beskonačnost";
		number = new thx.culture.core.NumberInfo(2, ",", [3], ".", "-n", "n");
		currency = new thx.culture.core.NumberInfo(2, ",", [3], ".", "-n $", "n $");
		percent = new thx.culture.core.NumberInfo(2, ",", [3], ".", "-n%", "n%");
		pluralRule = 7;
		englishCurrency = "Serbian Dinar";
		nativeCurrency = "dinar";
		currencySymbol = "Din.";
		currencyIso = "CSD";
		englishRegion = "Serbia and Montenegro (Former)";
		nativeRegion = "Srbija i Crna Gora (Prethodno)";
		iso2 = "CS";
		iso3 = "SCG";
		isMetric = false;
		Culture.add(this);
	}
	@:isVar public static var culture(get, null) : Culture; static function get_culture() { if(null == culture) culture = new SrLatnCS(); return culture; }
	static function __init__() { get_culture(); }
}