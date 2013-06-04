package thx.cultures;

import thx.culture.Culture;

class CoFR extends Culture {
	function new() {
		name = "co-FR";
		english = "Corsican (France)";
		native = "Corsu (France)";
		date = new thx.culture.core.DateTimeInfo(
			["ghjennaghju", "ferraghju", "marzu", "aprile", "maghju", "ghjunghju", "lugliu", "aostu", "settembre", "ottobre", "nuvembre", "dicembre", ""],
			["ghje", "ferr", "marz", "apri", "magh", "ghju", "lugl", "aost", "sett", "otto", "nuve", "dice", ""],
			["dumenica", "luni", "marti", "mercuri", "ghjovi", "venderi", "sabbatu"],
			["dum.", "lun.", "mar.", "mer.", "ghj.", "ven.", "sab."],
			["du", "lu", "ma", "me", "gh", "ve", "sa"],
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
		symbolNaN = "Mica numericu";
		symbolPercent = "%";
		symbolPermille = "‰";
		signNeg = "-";
		signPos = "+";
		symbolNegInf = "-Infinitu";
		symbolPosInf = "+Infinitu";
		number = new thx.culture.core.NumberInfo(2, ",", [3], " ", "-n", "n");
		currency = new thx.culture.core.NumberInfo(2, ",", [3], " ", "-n $", "n $");
		percent = new thx.culture.core.NumberInfo(2, ",", [3], " ", "-n %", "n %");
		englishCurrency = "Euro";
		nativeCurrency = "euro";
		currencySymbol = "€";
		currencyIso = "EUR";
		englishRegion = "France";
		nativeRegion = "France";
		iso2 = "FR";
		iso3 = "FRA";
		isMetric = false;
		Culture.add(this);
	}
	@:isVar public static var culture(get, null) : Culture; static function get_culture() { if(null == culture) culture = new CoFR(); return culture; }
}