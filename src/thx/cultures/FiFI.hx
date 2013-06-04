package thx.cultures;

import thx.culture.Culture;

class FiFI extends Culture {
	function new() {
		language = thx.languages.Fi.language;
		name = "fi-FI";
		english = "Finnish (Finland)";
		native = "suomi (Suomi)";
		date = new thx.culture.core.DateTimeInfo(
			["tammikuu", "helmikuu", "maaliskuu", "huhtikuu", "toukokuu", "kesäkuu", "heinäkuu", "elokuu", "syyskuu", "lokakuu", "marraskuu", "joulukuu", ""],
			["tammi", "helmi", "maalis", "huhti", "touko", "kesä", "heinä", "elo", "syys", "loka", "marras", "joulu", ""],
			["sunnuntai", "maanantai", "tiistai", "keskiviikko", "torstai", "perjantai", "lauantai"],
			["su", "ma", "ti", "ke", "to", "pe", "la"],
			["su", "ma", "ti", "ke", "to", "pe", "la"],
			null,
			null,
			".",
			":",
			1,
			"%B %Y",
			"%e. %Bta",
			"%e. %Bta %Y",
			"%e.%f.%Y",
			"%a, %d %b %Y %H:%M:%S GMT",
			"%e. %Bta %Y %k:%M:%S",
			"%Y-%m-%d %H:%M:%SZ",
			"%Y-%m-%dT%H:%M:%S",
			"%k:%M:%S",
			"%k:%M");
		symbolNaN = "NaN";
		symbolPercent = "%";
		symbolPermille = "‰";
		signNeg = "-";
		signPos = "+";
		symbolNegInf = "-INF";
		symbolPosInf = "INF";
		number = new thx.culture.core.NumberInfo(2, ",", [3], " ", "-n", "n");
		currency = new thx.culture.core.NumberInfo(2, ",", [3], " ", "-n $", "n $");
		percent = new thx.culture.core.NumberInfo(2, ",", [3], " ", "-n %", "n %");
		pluralRule = 1;
		englishCurrency = "Euro";
		nativeCurrency = "euro";
		currencySymbol = "€";
		currencyIso = "EUR";
		englishRegion = "Finland";
		nativeRegion = "Suomi";
		iso2 = "FI";
		iso3 = "FIN";
		isMetric = false;
		Culture.add(this);
	}
	@:isVar public static var culture(get, null) : Culture; static function get_culture() { if(null == culture) culture = new FiFI(); return culture; }
	static function __init__() { get_culture(); }
}