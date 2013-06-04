package thx.cultures;

import thx.culture.Culture;

class FrBE extends Culture {
	function new() {
		language = thx.languages.Fr.language;
		name = "fr-BE";
		english = "French (Belgium)";
		native = "français (Belgique)";
		date = new thx.culture.core.DateTimeInfo(
			["janvier", "février", "mars", "avril", "mai", "juin", "juillet", "août", "septembre", "octobre", "novembre", "décembre", ""],
			["janv.", "févr.", "mars", "avr.", "mai", "juin", "juil.", "août", "sept.", "oct.", "nov.", "déc.", ""],
			["dimanche", "lundi", "mardi", "mercredi", "jeudi", "vendredi", "samedi"],
			["dim.", "lun.", "mar.", "mer.", "jeu.", "ven.", "sam."],
			["di", "lu", "ma", "me", "je", "ve", "sa"],
			null,
			null,
			"/",
			":",
			1,
			"%B %Y",
			"%e %B",
			"%A %e %B %Y",
			"%e/%m/%Y",
			"%a, %d %b %Y %H:%M:%S GMT",
			"%A %e %B %Y %k:%M:%S",
			"%Y-%m-%d %H:%M:%SZ",
			"%Y-%m-%dT%H:%M:%S",
			"%k:%M:%S",
			"%k:%M");
		symbolNaN = "Non Numérique";
		symbolPercent = "%";
		symbolPermille = "‰";
		signNeg = "-";
		signPos = "+";
		symbolNegInf = "-Infini";
		symbolPosInf = "+Infini";
		number = new thx.culture.core.NumberInfo(2, ",", [3], ".", "-n", "n");
		currency = new thx.culture.core.NumberInfo(2, ",", [3], ".", "$ -n", "$ n");
		percent = new thx.culture.core.NumberInfo(2, ",", [3], ".", "-n %", "n %");
		pluralRule = 2;
		englishCurrency = "Euro";
		nativeCurrency = "euro";
		currencySymbol = "€";
		currencyIso = "EUR";
		englishRegion = "Belgium";
		nativeRegion = "Belgique";
		iso2 = "BE";
		iso3 = "BEL";
		isMetric = false;
		Culture.add(this);
	}
	@:isVar public static var culture(get, null) : Culture; static function get_culture() { if(null == culture) culture = new FrBE(); return culture; }
	static function __init__() { get_culture(); }
}