package thx.cultures;

import thx.culture.Culture;

class AfZA extends Culture {
	function new() {
		language = thx.languages.Af.language;
		name = "af-ZA";
		english = "Afrikaans (South Africa)";
		native = "Afrikaans (Suid Afrika)";
		date = new thx.culture.core.DateTimeInfo(
			["Januarie", "Februarie", "Maart", "April", "Mei", "Junie", "Julie", "Augustus", "September", "Oktober", "November", "Desember", ""],
			["Jan", "Feb", "Mar", "Apr", "Mei", "Jun", "Jul", "Aug", "Sep", "Okt", "Nov", "Des", ""],
			["Sondag", "Maandag", "Dinsdag", "Woensdag", "Donderdag", "Vrydag", "Saterdag"],
			["Son", "Maan", "Dins", "Woen", "Dond", "Vry", "Sat"],
			["So", "Ma", "Di", "Wo", "Do", "Vr", "Sa"],
			null,
			"nm",
			"/",
			":",
			0,
			"%B %Y",
			"%d %B",
			"%d %B %Y",
			"%Y/%m/%d",
			"%a, %d %b %Y %H:%M:%S GMT",
			"%d %B %Y %I:%M:%S %p",
			"%Y-%m-%d %H:%M:%SZ",
			"%Y-%m-%dT%H:%M:%S",
			"%I:%M:%S %p",
			"%I:%M %p");
		symbolNaN = "NaN";
		symbolPercent = "%";
		symbolPermille = "‰";
		signNeg = "-";
		signPos = "+";
		symbolNegInf = "-Infinity";
		symbolPosInf = "Infinity";
		number = new thx.culture.core.NumberInfo(2, ".", [3], ",", "-n", "n");
		currency = new thx.culture.core.NumberInfo(2, ".", [3], ",", "$-n", "$ n");
		percent = new thx.culture.core.NumberInfo(2, ".", [3], ",", "-n%", "n%");
		pluralRule = 1;
		englishCurrency = "South African Rand";
		nativeCurrency = "Rand";
		currencySymbol = "R";
		currencyIso = "ZAR";
		englishRegion = "South Africa";
		nativeRegion = "Suid Afrika";
		iso2 = "ZA";
		iso3 = "ZAF";
		isMetric = false;
		Culture.add(this);
	}
	@:isVar public static var culture(get, null) : Culture; static function get_culture() { if(null == culture) culture = new AfZA(); return culture; }
	static function __init__() { get_culture(); }
}