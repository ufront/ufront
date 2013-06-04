package thx.cultures;

import thx.culture.Culture;

class MsMY extends Culture {
	function new() {
		language = thx.languages.Ms.language;
		name = "ms-MY";
		english = "Malay (Malaysia)";
		native = "Bahasa Malaysia (Malaysia)";
		date = new thx.culture.core.DateTimeInfo(
			["Januari", "Februari", "Mac", "April", "Mei", "Jun", "Julai", "Ogos", "September", "Oktober", "November", "Disember", ""],
			["Jan", "Feb", "Mac", "Apr", "Mei", "Jun", "Jul", "Ogos", "Sept", "Okt", "Nov", "Dis", ""],
			["Ahad", "Isnin", "Selasa", "Rabu", "Khamis", "Jumaat", "Sabtu"],
			["Ahad", "Isnin", "Sel", "Rabu", "Khamis", "Jumaat", "Sabtu"],
			["A", "I", "S", "R", "K", "J", "S"],
			null,
			null,
			"/",
			":",
			1,
			"%B %Y",
			"%d %B",
			"%d %B %Y",
			"%d/%m/%Y",
			"%a, %d %b %Y %H:%M:%S GMT",
			"%d %B %Y %k:%M:%S",
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
		number = new thx.culture.core.NumberInfo(2, ",", [3], ".", "-n", "n");
		currency = new thx.culture.core.NumberInfo(0, ",", [3], ".", "($n)", "$n");
		percent = new thx.culture.core.NumberInfo(2, ",", [3], ".", "-n %", "n %");
		pluralRule = 0;
		englishCurrency = "Malaysian Ringgit";
		nativeCurrency = "Ringgit Malaysia";
		currencySymbol = "R";
		currencyIso = "MYR";
		englishRegion = "Malaysia";
		nativeRegion = "Malaysia";
		iso2 = "MY";
		iso3 = "MYS";
		isMetric = false;
		Culture.add(this);
	}
	@:isVar public static var culture(get, null) : Culture; static function get_culture() { if(null == culture) culture = new MsMY(); return culture; }
	static function __init__() { get_culture(); }
}