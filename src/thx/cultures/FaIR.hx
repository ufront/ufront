package thx.cultures;

import thx.culture.Culture;

class FaIR extends Culture {
	function new() {
		language = thx.languages.Fa.language;
		name = "fa-IR";
		english = "Persian (Iran)";
		native = "فارسى (ايران)";
		date = new thx.culture.core.DateTimeInfo(
			["جانفييه", "فيفرييه", "مارس", "أفريل", "مي", "جوان", "جوييه", "أوت", "سبتمبر", "اكتوبر", "نوفمبر", "ديسمبر", ""],
			["جانفييه", "فيفرييه", "مارس", "أفريل", "مي", "جوان", "جوييه", "أوت", "سبتمبر", "اكتوبر", "نوفمبر", "ديسمبر", ""],
			["الاحد", "الاثنين", "الثلاثاء", "الاربعاء", "الخميس", "الجمعة", "السبت"],
			["الاحد", "الاثنين", "الثلاثاء", "الاربعاء", "الخميس", "الجمعة", "السبت"],
			["أ", "ا", "ث", "أ", "خ", "ج", "س"],
			"ق.ظ",
			"ب.ظ",
			"/",
			":",
			0,
			"%B, %Y",
			"%B %d",
			"%A, %B %d, %Y",
			"%m/%d/%Y",
			"%a, %d %b %Y %H:%M:%S GMT",
			"%A, %B %d, %Y %I:%M:%S %p",
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
		digits = ["۰", "۱", "۲", "۳", "۴", "۵", "۶", "۷", "۸", "۹"];
		number = new thx.culture.core.NumberInfo(2, ".", [3], ",", "n-", "n");
		currency = new thx.culture.core.NumberInfo(2, "/", [3], ",", "$n-", "$ n");
		percent = new thx.culture.core.NumberInfo(2, ".", [3], ",", "-n %", "n %");
		pluralRule = 1;
		englishCurrency = "Iranian Rial";
		nativeCurrency = "رىال";
		currencySymbol = "ريال";
		currencyIso = "IRR";
		englishRegion = "Iran";
		nativeRegion = "ايران";
		iso2 = "IR";
		iso3 = "IRN";
		isMetric = false;
		Culture.add(this);
	}
	@:isVar public static var culture(get, null) : Culture; static function get_culture() { if(null == culture) culture = new FaIR(); return culture; }
	static function __init__() { get_culture(); }
}