package thx.cultures;

import thx.culture.Culture;

class FrCA extends Culture {
	function new() {
		language = thx.languages.Fr.language;
		name = "fr-CA";
		english = "French (Canada)";
		native = "français (Canada)";
		date = new thx.culture.core.DateTimeInfo(
			["janvier", "février", "mars", "avril", "mai", "juin", "juillet", "août", "septembre", "octobre", "novembre", "décembre", ""],
			["janv.", "févr.", "mars", "avr.", "mai", "juin", "juil.", "août", "sept.", "oct.", "nov.", "déc.", ""],
			["dimanche", "lundi", "mardi", "mercredi", "jeudi", "vendredi", "samedi"],
			["dim.", "lun.", "mar.", "mer.", "jeu.", "ven.", "sam."],
			["di", "lu", "ma", "me", "je", "ve", "sa"],
			null,
			null,
			"-",
			":",
			0,
			"%B, %Y",
			"%e %B",
			"%e %B %Y",
			"%Y-%m-%d",
			"%a, %d %b %Y %H:%M:%S GMT",
			"%e %B %Y %H:%M:%S",
			"%Y-%m-%d %H:%M:%SZ",
			"%Y-%m-%dT%H:%M:%S",
			"%H:%M:%S",
			"%H:%M");
		symbolNaN = "Non Numérique";
		symbolPercent = "%";
		symbolPermille = "‰";
		signNeg = "-";
		signPos = "+";
		symbolNegInf = "-Infini";
		symbolPosInf = "+Infini";
		number = new thx.culture.core.NumberInfo(2, ",", [3], " ", "-n", "n");
		currency = new thx.culture.core.NumberInfo(2, ",", [3], " ", "(n $)", "n $");
		percent = new thx.culture.core.NumberInfo(2, ",", [3], " ", "-n %", "n %");
		pluralRule = 2;
		englishCurrency = "Canadian Dollar";
		nativeCurrency = "Dollar canadien";
		currencySymbol = "$";
		currencyIso = "CAD";
		englishRegion = "Canada";
		nativeRegion = "Canada";
		iso2 = "CA";
		iso3 = "CAN";
		isMetric = false;
		Culture.add(this);
	}
	@:isVar public static var culture(get, null) : Culture; static function get_culture() { if(null == culture) culture = new FrCA(); return culture; }
	static function __init__() { get_culture(); }
}