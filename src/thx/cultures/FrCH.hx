package thx.cultures;

import thx.culture.Culture;

class FrCH extends Culture {
	function new() {
		language = thx.languages.Fr.language;
		name = "fr-CH";
		english = "French (Switzerland)";
		native = "français (Suisse)";
		date = new thx.culture.core.DateTimeInfo(
			["janvier", "février", "mars", "avril", "mai", "juin", "juillet", "août", "septembre", "octobre", "novembre", "décembre", ""],
			["janv.", "févr.", "mars", "avr.", "mai", "juin", "juil.", "août", "sept.", "oct.", "nov.", "déc.", ""],
			["dimanche", "lundi", "mardi", "mercredi", "jeudi", "vendredi", "samedi"],
			["dim.", "lun.", "mar.", "mer.", "jeu.", "ven.", "sam."],
			["di", "lu", "ma", "me", "je", "ve", "sa"],
			null,
			null,
			".",
			":",
			1,
			"%B %Y",
			"%e %B",
			"%A, %e. %B %Y",
			"%d.%m.%Y",
			"%a, %d %b %Y %H:%M:%S GMT",
			"%A, %e. %B %Y %H:%M:%S",
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
		number = new thx.culture.core.NumberInfo(2, ".", [3], "'", "-n", "n");
		currency = new thx.culture.core.NumberInfo(2, ".", [3], "'", "$-n", "$ n");
		percent = new thx.culture.core.NumberInfo(2, ".", [3], "'", "-n %", "n %");
		pluralRule = 2;
		englishCurrency = "Swiss Franc";
		nativeCurrency = "Franc suisse";
		currencySymbol = "SFr.";
		currencyIso = "CHF";
		englishRegion = "Switzerland";
		nativeRegion = "Suisse";
		iso2 = "CH";
		iso3 = "CHE";
		isMetric = false;
		Culture.add(this);
	}
	@:isVar public static var culture(get, null) : Culture; static function get_culture() { if(null == culture) culture = new FrCH(); return culture; }
	static function __init__() { get_culture(); }
}