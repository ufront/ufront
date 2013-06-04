package thx.cultures;

import thx.culture.Culture;

class EtEE extends Culture {
	function new() {
		language = thx.languages.Et.language;
		name = "et-EE";
		english = "Estonian (Estonia)";
		native = "eesti (Eesti)";
		date = new thx.culture.core.DateTimeInfo(
			["jaanuar", "veebruar", "märts", "aprill", "mai", "juuni", "juuli", "august", "september", "oktoober", "november", "detsember", ""],
			["jaan", "veebr", "märts", "apr", "mai", "juuni", "juuli", "aug", "sept", "okt", "nov", "dets", ""],
			["pühapäev", "esmaspäev", "teisipäev", "kolmapäev", "neljapäev", "reede", "laupäev"],
			["P", "E", "T", "K", "N", "R", "L"],
			["P", "E", "T", "K", "N", "R", "L"],
			"EL",
			"PL",
			".",
			":",
			1,
			"%B %Y. a.",
			"%e. %B",
			"%e. %B %Y. a.",
			"%e.%m.%Y",
			"%a, %d %b %Y %H:%M:%S GMT",
			"%e. %B %Y. a. %k:%M:%S",
			"%Y-%m-%d %H:%M:%SZ",
			"%Y-%m-%dT%H:%M:%S",
			"%k:%M:%S",
			"%k:%M");
		symbolNaN = "avaldamatu";
		symbolPercent = "%";
		symbolPermille = "‰";
		signNeg = "-";
		signPos = "+";
		symbolNegInf = "miinuslõpmatus";
		symbolPosInf = "plusslõpmatus";
		number = new thx.culture.core.NumberInfo(2, ",", [3], " ", "-n", "n");
		currency = new thx.culture.core.NumberInfo(2, ".", [3], " ", "-n $", "n $");
		percent = new thx.culture.core.NumberInfo(2, ",", [3], " ", "-n%", "n%");
		pluralRule = 1;
		englishCurrency = "Estonian Kroon";
		nativeCurrency = "Kroon";
		currencySymbol = "kr";
		currencyIso = "EEK";
		englishRegion = "Estonia";
		nativeRegion = "Eesti";
		iso2 = "EE";
		iso3 = "EST";
		isMetric = false;
		Culture.add(this);
	}
	@:isVar public static var culture(get, null) : Culture; static function get_culture() { if(null == culture) culture = new EtEE(); return culture; }
	static function __init__() { get_culture(); }
}