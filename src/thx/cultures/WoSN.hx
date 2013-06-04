package thx.cultures;

import thx.culture.Culture;

class WoSN extends Culture {
	function new() {
		name = "wo-SN";
		english = "Wolof (Senegal)";
		native = "Wolof (Sénégal)";
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
			"%B %d",
			"%A %e %B %Y",
			"%d/%m/%Y",
			"%a, %d %b %Y %H:%M:%S GMT",
			"%A %e %B %Y %H:%M:%S",
			"%Y-%m-%d %H:%M:%SZ",
			"%Y-%m-%dT%H:%M:%S",
			"%H:%M:%S",
			"%H:%M:%S");
		symbolNaN = "Non Numérique";
		symbolPercent = "%";
		symbolPermille = "‰";
		signNeg = "-";
		signPos = "+";
		symbolNegInf = "-Infini";
		symbolPosInf = "+Infini";
		number = new thx.culture.core.NumberInfo(2, ",", [3], " ", "-n", "n");
		currency = new thx.culture.core.NumberInfo(2, ",", [3], " ", "-n $", "n $");
		percent = new thx.culture.core.NumberInfo(2, ",", [3], " ", "-n %", "n %");
		englishCurrency = "XOF Senegal";
		nativeCurrency = "XOF Senegal";
		currencySymbol = "XOF";
		currencyIso = "XOF";
		englishRegion = "Senegal";
		nativeRegion = "Sénégal";
		iso2 = "SN";
		iso3 = "SEN";
		isMetric = false;
		Culture.add(this);
	}
	@:isVar public static var culture(get, null) : Culture; static function get_culture() { if(null == culture) culture = new WoSN(); return culture; }
}