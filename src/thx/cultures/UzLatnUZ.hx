package thx.cultures;

import thx.culture.Culture;

class UzLatnUZ extends Culture {
	function new() {
		language = thx.languages.Uz.language;
		name = "uz-Latn-UZ";
		english = "Uzbek (Latin, Uzbekistan)";
		native = "U'zbek (U'zbekiston Respublikasi)";
		date = new thx.culture.core.DateTimeInfo(
			["yanvar", "fevral", "mart", "aprel", "may", "iyun", "iyul", "avgust", "sentyabr", "oktyabr", "noyabr", "dekabr", ""],
			["yanvar", "fevral", "mart", "aprel", "may", "iyun", "iyul", "avgust", "sentyabr", "oktyabr", "noyabr", "dekabr", ""],
			["yakshanba", "dushanba", "seshanba", "chorshanba", "payshanba", "juma", "shanba"],
			["yak.", "dsh.", "sesh.", "chr.", "psh.", "jm.", "sh."],
			["yak", "dsh", "sesh", "chr", "psh", "jm", "sh"],
			null,
			null,
			"/",
			":",
			1,
			"%B %Y",
			"%e-%B",
			"%Y yil %e-%B",
			"%d/%m %Y",
			"%a, %d %b %Y %H:%M:%S GMT",
			"%Y yil %e-%B %H:%M:%S",
			"%Y-%m-%d %H:%M:%SZ",
			"%Y-%m-%dT%H:%M:%S",
			"%H:%M:%S",
			"%H:%M");
		symbolNaN = "NaN";
		symbolPercent = "%";
		symbolPermille = "‰";
		signNeg = "-";
		signPos = "+";
		symbolNegInf = "-Infinity";
		symbolPosInf = "Infinity";
		number = new thx.culture.core.NumberInfo(2, ",", [3], " ", "-n", "n");
		currency = new thx.culture.core.NumberInfo(0, ",", [3], " ", "-n $", "n $");
		percent = new thx.culture.core.NumberInfo(2, ",", [3], " ", "-n%", "n%");
		pluralRule = 0;
		englishCurrency = "Uzbekistan Sum";
		nativeCurrency = "рубль";
		currencySymbol = "su'm";
		currencyIso = "UZS";
		englishRegion = "Uzbekistan";
		nativeRegion = "U'zbekiston Respublikasi";
		iso2 = "UZ";
		iso3 = "UZB";
		isMetric = false;
		Culture.add(this);
	}
	@:isVar public static var culture(get, null) : Culture; static function get_culture() { if(null == culture) culture = new UzLatnUZ(); return culture; }
	static function __init__() { get_culture(); }
}