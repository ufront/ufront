package thx.cultures;

import thx.culture.Culture;

class SrLatnRS extends Culture {
	function new() {
		name = "sr-Latn-RS";
		english = "Serbian (Latin) (Serbia)";
		native = "srpski (Srbija)";
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
			"%B %d",
			"%e. %B %Y",
			"%e.%f.%Y",
			"%a, %d %b %Y %H:%M:%S GMT",
			"%e. %B %Y %k:%M:%S",
			"%Y-%m-%d %H:%M:%SZ",
			"%Y-%m-%dT%H:%M:%S",
			"%k:%M:%S",
			"%k:%M:%S");
		symbolNaN = "NaN";
		symbolPercent = "%";
		symbolPermille = "‰";
		signNeg = "-";
		signPos = "+";
		symbolNegInf = "-beskonačnost";
		symbolPosInf = "+beskonačnost";
		number = new thx.culture.core.NumberInfo(2, ",", [3], ".", "-n", "n");
		currency = new thx.culture.core.NumberInfo(2, ",", [3], ".", "-n $", "n $");
		percent = new thx.culture.core.NumberInfo(2, ",", [3], ".", "-n %", "n %");
		englishCurrency = "Serbian Dinar";
		nativeCurrency = "dinar";
		currencySymbol = "Din.";
		currencyIso = "RSD";
		englishRegion = "Serbia";
		nativeRegion = "Srbija";
		iso2 = "RS";
		iso3 = "SRB";
		isMetric = false;
		Culture.add(this);
	}
	@:isVar public static var culture(get, null) : Culture; static function get_culture() { if(null == culture) culture = new SrLatnRS(); return culture; }
}