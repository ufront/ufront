package thx.cultures;

import thx.culture.Culture;

class AzLatnAZ extends Culture {
	function new() {
		language = thx.languages.Az.language;
		name = "az-Latn-AZ";
		english = "Azeri (Latin, Azerbaijan)";
		native = "Azərbaycan­ılı (Azərbaycanca)";
		date = new thx.culture.core.DateTimeInfo(
			["Yanvar", "Fevral", "Mart", "Aprel", "May", "İyun", "İyul", "Avgust", "Sentyabr", "Oktyabr", "Noyabr", "Dekabr", ""],
			["Yan", "Fev", "Mar", "Apr", "May", "İyun", "İyul", "Avg", "Sen", "Okt", "Noy", "Dek", ""],
			["Bazar", "Bazar ertəsi", "Çərşənbə axşamı", "Çərşənbə", "Cümə axşamı", "Cümə", "Şənbə"],
			["B", "Be", "Ça", "Ç", "Ca", "C", "Ş"],
			["B", "Be", "Ça", "Ç", "Ca", "C", "Ş"],
			null,
			null,
			".",
			":",
			1,
			"%B %Y",
			"%e %B",
			"%e %B %Y",
			"%d.%m.%Y",
			"%a, %d %b %Y %H:%M:%S GMT",
			"%e %B %Y %k:%M:%S",
			"%Y-%m-%d %H:%M:%SZ",
			"%Y-%m-%dT%H:%M:%S",
			"%k:%M:%S",
			"%k:%M");
		symbolNaN = "NaN";
		symbolPercent = "%";
		symbolPermille = "‰";
		signNeg = "-";
		signPos = "+";
		symbolNegInf = "-Infinity";
		symbolPosInf = "Infinity";
		number = new thx.culture.core.NumberInfo(2, ",", [3], " ", "-n", "n");
		currency = new thx.culture.core.NumberInfo(2, ",", [3], " ", "-n $", "n $");
		percent = new thx.culture.core.NumberInfo(2, ",", [3], " ", "-n%", "n%");
		pluralRule = 1;
		englishCurrency = "Azerbaijanian Manat";
		nativeCurrency = "manat";
		currencySymbol = "man.";
		currencyIso = "AZM";
		englishRegion = "Azerbaijan";
		nativeRegion = "Azərbaycanca";
		iso2 = "AZ";
		iso3 = "AZE";
		isMetric = false;
		Culture.add(this);
	}
	@:isVar public static var culture(get, null) : Culture; static function get_culture() { if(null == culture) culture = new AzLatnAZ(); return culture; }
	static function __init__() { get_culture(); }
}