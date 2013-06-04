package thx.cultures;

import thx.culture.Culture;

class EuES extends Culture {
	function new() {
		language = thx.languages.Eu.language;
		name = "eu-ES";
		english = "Basque (Basque)";
		native = "euskara (euskara)";
		date = new thx.culture.core.DateTimeInfo(
			["urtarrila", "otsaila", "martxoa", "apirila", "maiatza", "ekaina", "uztaila", "abuztua", "iraila", "urria", "azaroa", "abendua", ""],
			["urt.", "ots.", "mar.", "api.", "mai.", "eka.", "uzt.", "abu.", "ira.", "urr.", "aza.", "abe.", ""],
			["igandea", "astelehena", "asteartea", "asteazkena", "osteguna", "ostirala", "larunbata"],
			["ig.", "al.", "as.", "az.", "og.", "or.", "lr."],
			["ig", "al", "as", "az", "og", "or", "lr"],
			null,
			null,
			"/",
			":",
			1,
			"%Y.eko %B",
			"%B %d",
			"%A, %Y.eko %Bk %e",
			"%Y/%m/%d",
			"%a, %d %b %Y %H:%M:%S GMT",
			"%A, %Y.eko %Bk %e %H:%M:%S",
			"%Y-%m-%d %H:%M:%SZ",
			"%Y-%m-%dT%H:%M:%S",
			"%H:%M:%S",
			"%H:%M");
		symbolNaN = "EdZ";
		symbolPercent = "%";
		symbolPermille = "‰";
		signNeg = "-";
		signPos = "+";
		symbolNegInf = "-Infinitu";
		symbolPosInf = "Infinitu";
		number = new thx.culture.core.NumberInfo(2, ",", [3], ".", "-n", "n");
		currency = new thx.culture.core.NumberInfo(2, ",", [3], ".", "-n $", "n $");
		percent = new thx.culture.core.NumberInfo(2, ",", [3], ".", "-n %", "n %");
		pluralRule = 1;
		englishCurrency = "Euro";
		nativeCurrency = "euro";
		currencySymbol = "€";
		currencyIso = "EUR";
		englishRegion = "Spain";
		nativeRegion = "Espainia";
		iso2 = "ES";
		iso3 = "ESP";
		isMetric = false;
		Culture.add(this);
	}
	@:isVar public static var culture(get, null) : Culture; static function get_culture() { if(null == culture) culture = new EuES(); return culture; }
	static function __init__() { get_culture(); }
}