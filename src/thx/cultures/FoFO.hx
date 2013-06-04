package thx.cultures;

import thx.culture.Culture;

class FoFO extends Culture {
	function new() {
		language = thx.languages.Fo.language;
		name = "fo-FO";
		english = "Faroese (Faroe Islands)";
		native = "føroyskt (Føroyar)";
		date = new thx.culture.core.DateTimeInfo(
			["januar", "februar", "mars", "apríl", "mai", "juni", "juli", "august", "september", "oktober", "november", "desember", ""],
			["jan", "feb", "mar", "apr", "mai", "jun", "jul", "aug", "sep", "okt", "nov", "des", ""],
			["sunnudagur", "mánadagur", "týsdagur", "mikudagur", "hósdagur", "fríggjadagur", "leygardagur"],
			["sun", "mán", "týs", "mik", "hós", "frí", "leyg"],
			["su", "má", "tý", "mi", "hó", "fr", "ley"],
			null,
			null,
			"-",
			".",
			1,
			"%B %Y",
			"%e. %B",
			"%e. %B %Y",
			"%d-%m-%Y",
			"%a, %d %b %Y %H:%M:%S GMT",
			"%e. %B %Y %H.%M.%S",
			"%Y-%m-%d %H:%M:%SZ",
			"%Y-%m-%dT%H:%M:%S",
			"%H.%M.%S",
			"%H.%M");
		symbolNaN = "NaN";
		symbolPercent = "%";
		symbolPermille = "‰";
		signNeg = "-";
		signPos = "+";
		symbolNegInf = "-INF";
		symbolPosInf = "INF";
		number = new thx.culture.core.NumberInfo(2, ",", [3], ".", "-n", "n");
		currency = new thx.culture.core.NumberInfo(2, ",", [3], ".", "$ -n", "$ n");
		percent = new thx.culture.core.NumberInfo(2, ",", [3], ".", "-n%", "n%");
		pluralRule = 1;
		englishCurrency = "Danish Krone";
		nativeCurrency = "Dansk krone";
		currencySymbol = "kr";
		currencyIso = "DKK";
		englishRegion = "Faroe Islands";
		nativeRegion = "Føroyar";
		iso2 = "FO";
		iso3 = "FRO";
		isMetric = false;
		Culture.add(this);
	}
	@:isVar public static var culture(get, null) : Culture; static function get_culture() { if(null == culture) culture = new FoFO(); return culture; }
	static function __init__() { get_culture(); }
}