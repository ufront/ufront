package thx.cultures;

import thx.culture.Culture;

class KlGL extends Culture {
	function new() {
		name = "kl-GL";
		english = "Greenlandic (Greenland)";
		native = "kalaallisut (Kalaallit Nunaat)";
		date = new thx.culture.core.DateTimeInfo(
			["januari", "februari", "martsi", "apriili", "maaji", "juni", "juli", "aggusti", "septembari", "oktobari", "novembari", "decembari", ""],
			["jan", "feb", "mar", "apr", "mai", "jun", "jul", "aug", "sep", "okt", "nov", "dec", ""],
			["sapaat", "ataasinngorneq", "marlunngorneq", "pingasunngorneq", "sisamanngorneq", "tallimanngorneq", "arfininngorneq"],
			["sap", "ata", "mar", "ping", "sis", "tal", "arf"],
			["sa", "at", "ma", "pi", "si", "ta", "ar"],
			null,
			null,
			"-",
			":",
			1,
			"%B %Y",
			"%B %d",
			"%e. %B %Y",
			"%d-%m-%Y",
			"%a, %d %b %Y %H:%M:%S GMT",
			"%e. %B %Y %H:%M:%S",
			"%Y-%m-%d %H:%M:%SZ",
			"%Y-%m-%dT%H:%M:%S",
			"%H:%M:%S",
			"%H:%M:%S");
		symbolNaN = "NaN";
		symbolPercent = "%";
		symbolPermille = "‰";
		signNeg = "-";
		signPos = "+";
		symbolNegInf = "-INF";
		symbolPosInf = "INF";
		number = new thx.culture.core.NumberInfo(2, ",", [3, 0], ".", "-n", "n");
		currency = new thx.culture.core.NumberInfo(2, ",", [3, 0], ".", "$ -n", "$ n");
		percent = new thx.culture.core.NumberInfo(2, ",", [3, 0], ".", "-n %", "n %");
		englishCurrency = "Danish Krone";
		nativeCurrency = "korunni";
		currencySymbol = "kr.";
		currencyIso = "DKK";
		englishRegion = "Greenland";
		nativeRegion = "Kalaallit Nunaat";
		iso2 = "GL";
		iso3 = "GRL";
		isMetric = false;
		Culture.add(this);
	}
	@:isVar public static var culture(get, null) : Culture; static function get_culture() { if(null == culture) culture = new KlGL(); return culture; }
}