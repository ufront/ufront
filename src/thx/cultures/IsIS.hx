package thx.cultures;

import thx.culture.Culture;

class IsIS extends Culture {
	function new() {
		language = thx.languages.Is.language;
		name = "is-IS";
		english = "Icelandic (Iceland)";
		native = "íslenska (Ísland)";
		date = new thx.culture.core.DateTimeInfo(
			["janúar", "febrúar", "mars", "apríl", "maí", "júní", "júlí", "ágúst", "september", "október", "nóvember", "desember", ""],
			["jan.", "feb.", "mar.", "apr.", "maí", "jún.", "júl.", "ágú.", "sep.", "okt.", "nóv.", "des.", ""],
			["sunnudagur", "mánudagur", "þriðjudagur", "miðvikudagur", "fimmtudagur", "föstudagur", "laugardagur"],
			["sun.", "mán.", "þri.", "mið.", "fim.", "fös.", "lau."],
			["su", "má", "þr", "mi", "fi", "fö", "la"],
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
			"%e. %B %Y %H:%M:%S",
			"%Y-%m-%d %H:%M:%SZ",
			"%Y-%m-%dT%H:%M:%S",
			"%H:%M:%S",
			"%H:%M");
		symbolNaN = "NaN";
		symbolPercent = "%";
		symbolPermille = "‰";
		signNeg = "-";
		signPos = "+";
		symbolNegInf = "-INF";
		symbolPosInf = "INF";
		number = new thx.culture.core.NumberInfo(2, ",", [3], ".", "-n", "n");
		currency = new thx.culture.core.NumberInfo(0, ",", [3], ".", "-n $", "n $");
		percent = new thx.culture.core.NumberInfo(2, ",", [3], ".", "-n%", "n%");
		pluralRule = 1;
		englishCurrency = "Icelandic Krona";
		nativeCurrency = "Króna";
		currencySymbol = "kr.";
		currencyIso = "ISK";
		englishRegion = "Iceland";
		nativeRegion = "Ísland";
		iso2 = "IS";
		iso3 = "ISL";
		isMetric = false;
		Culture.add(this);
	}
	@:isVar public static var culture(get, null) : Culture; static function get_culture() { if(null == culture) culture = new IsIS(); return culture; }
	static function __init__() { get_culture(); }
}