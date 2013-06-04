package thx.cultures;

import thx.culture.Culture;

class CaES extends Culture {
	function new() {
		language = thx.languages.Ca.language;
		name = "ca-ES";
		english = "Catalan (Catalan)";
		native = "català (català)";
		date = new thx.culture.core.DateTimeInfo(
			["gener", "febrer", "març", "abril", "maig", "juny", "juliol", "agost", "setembre", "octubre", "novembre", "desembre", ""],
			["gen", "feb", "març", "abr", "maig", "juny", "jul", "ag", "set", "oct", "nov", "des", ""],
			["diumenge", "dilluns", "dimarts", "dimecres", "dijous", "divendres", "dissabte"],
			["dg.", "dl.", "dt.", "dc.", "dj.", "dv.", "ds."],
			["dg", "dl", "dt", "dc", "dj", "dv", "ds"],
			null,
			null,
			"/",
			":",
			1,
			"%B / %Y",
			"%d %B",
			"%A, %e / %B / %Y",
			"%d/%m/%Y",
			"%a, %d %b %Y %H:%M:%S GMT",
			"%A, %e / %B / %Y %H:%M:%S",
			"%Y-%m-%d %H:%M:%SZ",
			"%Y-%m-%dT%H:%M:%S",
			"%H:%M:%S",
			"%H:%M");
		symbolNaN = "NeuN";
		symbolPercent = "%";
		symbolPermille = "‰";
		signNeg = "-";
		signPos = "+";
		symbolNegInf = "-Infinit";
		symbolPosInf = "Infinit";
		number = new thx.culture.core.NumberInfo(2, ",", [3], ".", "-n", "n");
		currency = new thx.culture.core.NumberInfo(2, ",", [3], ".", "-n $", "n $");
		percent = new thx.culture.core.NumberInfo(2, ",", [3], ".", "-n %", "n %");
		pluralRule = 1;
		englishCurrency = "Euro";
		nativeCurrency = "euro";
		currencySymbol = "€";
		currencyIso = "EUR";
		englishRegion = "Spain";
		nativeRegion = "Espanya";
		iso2 = "ES";
		iso3 = "ESP";
		isMetric = false;
		Culture.add(this);
	}
	@:isVar public static var culture(get, null) : Culture; static function get_culture() { if(null == culture) culture = new CaES(); return culture; }
	static function __init__() { get_culture(); }
}