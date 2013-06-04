package thx.cultures;

import thx.culture.Culture;

class SvFI extends Culture {
	function new() {
		language = thx.languages.Sv.language;
		name = "sv-FI";
		english = "Swedish (Finland)";
		native = "svenska (Finland)";
		date = new thx.culture.core.DateTimeInfo(
			["januari", "februari", "mars", "april", "maj", "juni", "juli", "augusti", "september", "oktober", "november", "december", ""],
			["jan", "feb", "mar", "apr", "maj", "jun", "jul", "aug", "sep", "okt", "nov", "dec", ""],
			["söndag", "måndag", "tisdag", "onsdag", "torsdag", "fredag", "lördag"],
			["sö", "må", "ti", "on", "to", "fr", "lö"],
			["sö", "må", "ti", "on", "to", "fr", "lö"],
			null,
			null,
			".",
			":",
			1,
			"%B %Y",
			"den %e %B",
			"den %e %B %Y",
			"%e.%f.%Y",
			"%a, %d %b %Y %H:%M:%S GMT",
			"den %e %B %Y %H:%M:%S",
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
		number = new thx.culture.core.NumberInfo(2, ",", [3], " ", "-n", "n");
		currency = new thx.culture.core.NumberInfo(2, ",", [3], " ", "-n $", "n $");
		percent = new thx.culture.core.NumberInfo(2, ",", [3], " ", "-n %", "n %");
		pluralRule = 1;
		englishCurrency = "Euro";
		nativeCurrency = "euro";
		currencySymbol = "€";
		currencyIso = "EUR";
		englishRegion = "Finland";
		nativeRegion = "Finland";
		iso2 = "FI";
		iso3 = "FIN";
		isMetric = false;
		Culture.add(this);
	}
	@:isVar public static var culture(get, null) : Culture; static function get_culture() { if(null == culture) culture = new SvFI(); return culture; }
	static function __init__() { get_culture(); }
}