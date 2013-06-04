package thx.cultures;

import thx.culture.Culture;

class HrHR extends Culture {
	function new() {
		language = thx.languages.Hr.language;
		name = "hr-HR";
		english = "Croatian (Croatia)";
		native = "hrvatski (Hrvatska)";
		date = new thx.culture.core.DateTimeInfo(
			["siječanj", "veljača", "ožujak", "travanj", "svibanj", "lipanj", "srpanj", "kolovoz", "rujan", "listopad", "studeni", "prosinac", ""],
			["sij", "vlj", "ožu", "tra", "svi", "lip", "srp", "kol", "ruj", "lis", "stu", "pro", ""],
			["nedjelja", "ponedjeljak", "utorak", "srijeda", "četvrtak", "petak", "subota"],
			["ned", "pon", "uto", "sri", "čet", "pet", "sub"],
			["ne", "po", "ut", "sr", "če", "pe", "su"],
			null,
			null,
			".",
			":",
			1,
			"%B, %Y",
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
		symbolNegInf = "-Infinity";
		symbolPosInf = "Infinity";
		number = new thx.culture.core.NumberInfo(2, ",", [3], ".", "- n", "n");
		currency = new thx.culture.core.NumberInfo(2, ",", [3], ".", "-n $", "n $");
		percent = new thx.culture.core.NumberInfo(2, ",", [3], ".", "-n%", "n%");
		pluralRule = 7;
		englishCurrency = "Croatian Kuna";
		nativeCurrency = "hrvatska kuna";
		currencySymbol = "kn";
		currencyIso = "HRK";
		englishRegion = "Croatia";
		nativeRegion = "Hrvatska";
		iso2 = "HR";
		iso3 = "HRV";
		isMetric = false;
		Culture.add(this);
	}
	@:isVar public static var culture(get, null) : Culture; static function get_culture() { if(null == culture) culture = new HrHR(); return culture; }
	static function __init__() { get_culture(); }
}