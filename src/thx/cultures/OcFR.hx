package thx.cultures;

import thx.culture.Culture;

class OcFR extends Culture {
	function new() {
		name = "oc-FR";
		english = "Occitan (France)";
		native = "Occitan (França)";
		date = new thx.culture.core.DateTimeInfo(
			["genier", "febrier", "març", "abril", "mai", "junh", "julh", "agost", "setembre", "octobre", "novembre", "desembre", ""],
			["gen.", "feb.", "mar.", "abr.", "mai.", "jun.", "jul.", "ag.", "set.", "oct.", "nov.", "des.", ""],
			["dimenge", "diluns", "dimars", "dimècres", "dijòus", "divendres", "dissabte"],
			["dim.", "lun.", "mar.", "mèc.", "jòu.", "ven.", "sab."],
			["di", "lu", "ma", "mè", "jò", "ve", "sa"],
			null,
			null,
			"/",
			":",
			1,
			"%B %Y",
			"%B %d",
			"%A, lo %e %B de %Y",
			"%d/%m/%Y",
			"%a, %d %b %Y %H:%M:%S GMT",
			"%A, lo %e %B de %Y %H:%M:%S",
			"%Y-%m-%d %H:%M:%SZ",
			"%Y-%m-%dT%H:%M:%S",
			"%H:%M:%S",
			"%H:%M:%S");
		symbolNaN = "Non Numeric";
		symbolPercent = "%";
		symbolPermille = "‰";
		signNeg = "-";
		signPos = "+";
		symbolNegInf = "-Infinit";
		symbolPosInf = "+Infinit";
		number = new thx.culture.core.NumberInfo(2, ",", [3], " ", "-n", "n");
		currency = new thx.culture.core.NumberInfo(2, ",", [3], " ", "-n $", "n $");
		percent = new thx.culture.core.NumberInfo(2, ",", [3], " ", "-n %", "n %");
		englishCurrency = "Euro";
		nativeCurrency = "euro";
		currencySymbol = "€";
		currencyIso = "EUR";
		englishRegion = "France";
		nativeRegion = "França";
		iso2 = "FR";
		iso3 = "FRA";
		isMetric = false;
		Culture.add(this);
	}
	@:isVar public static var culture(get, null) : Culture; static function get_culture() { if(null == culture) culture = new OcFR(); return culture; }
}