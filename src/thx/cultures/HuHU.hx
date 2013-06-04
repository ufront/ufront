package thx.cultures;

import thx.culture.Culture;

class HuHU extends Culture {
	function new() {
		language = thx.languages.Hu.language;
		name = "hu-HU";
		english = "Hungarian (Hungary)";
		native = "magyar (Magyarország)";
		date = new thx.culture.core.DateTimeInfo(
			["január", "február", "március", "április", "május", "június", "július", "augusztus", "szeptember", "október", "november", "december", ""],
			["jan.", "febr.", "márc.", "ápr.", "máj.", "jún.", "júl.", "aug.", "szept.", "okt.", "nov.", "dec.", ""],
			["vasárnap", "hétfő", "kedd", "szerda", "csütörtök", "péntek", "szombat"],
			["V", "H", "K", "Sze", "Cs", "P", "Szo"],
			["V", "H", "K", "Sze", "Cs", "P", "Szo"],
			"de.",
			"du.",
			". ",
			":",
			1,
			"%Y. %B",
			"%B %e.",
			"%Y. %B %e.",
			"%Y. %m. %d.",
			"%a, %d %b %Y %H:%M:%S GMT",
			"%Y. %B %e. %k:%M:%S",
			"%Y-%m-%d %H:%M:%SZ",
			"%Y-%m-%dT%H:%M:%S",
			"%k:%M:%S",
			"%k:%M");
		symbolNaN = "nem szám";
		symbolPercent = "%";
		symbolPermille = "‰";
		signNeg = "-";
		signPos = "+";
		symbolNegInf = "negatív végtelen";
		symbolPosInf = "végtelen";
		number = new thx.culture.core.NumberInfo(2, ",", [3], " ", "-n", "n");
		currency = new thx.culture.core.NumberInfo(2, ",", [3], " ", "-n $", "n $");
		percent = new thx.culture.core.NumberInfo(2, ",", [3], " ", "-n %", "n %");
		pluralRule = 1;
		englishCurrency = "Hungarian Forint";
		nativeCurrency = "forint";
		currencySymbol = "Ft";
		currencyIso = "HUF";
		englishRegion = "Hungary";
		nativeRegion = "Magyarország";
		iso2 = "HU";
		iso3 = "HUN";
		isMetric = false;
		Culture.add(this);
	}
	@:isVar public static var culture(get, null) : Culture; static function get_culture() { if(null == culture) culture = new HuHU(); return culture; }
	static function __init__() { get_culture(); }
}