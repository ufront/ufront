package thx.cultures;

import thx.culture.Culture;

class ArTN extends Culture {
	function new() {
		language = thx.languages.Ar.language;
		name = "ar-TN";
		english = "Arabic (Tunisia)";
		native = "العربية (تونس)";
		date = new thx.culture.core.DateTimeInfo(
			["جانفي", "فيفري", "مارس", "افريل", "ماي", "جوان", "جويلية", "اوت", "سبتمبر", "اكتوبر", "نوفمبر", "ديسمبر", ""],
			["جانفي", "فيفري", "مارس", "افريل", "ماي", "جوان", "جويلية", "اوت", "سبتمبر", "اكتوبر", "نوفمبر", "ديسمبر", ""],
			["الاحد", "الاثنين", "الثلاثاء", "الاربعاء", "الخميس", "الجمعة", "السبت"],
			["الاحد", "الاثنين", "الثلاثاء", "الاربعاء", "الخميس", "الجمعة", "السبت"],
			["أ", "ا", "ث", "أ", "خ", "ج", "س"],
			"ص",
			"م",
			"-",
			":",
			1,
			"%B, %Y",
			"%d %B",
			"%d %B, %Y",
			"%d-%m-%Y",
			"%a, %d %b %Y %H:%M:%S GMT",
			"%d %B, %Y %k:%M:%S",
			"%Y-%m-%d %H:%M:%SZ",
			"%Y-%m-%dT%H:%M:%S",
			"%k:%M:%S",
			"%k:%M");
		symbolNaN = "ليس برقم";
		symbolPercent = "%";
		symbolPermille = "‰";
		signNeg = "-";
		signPos = "+";
		symbolNegInf = "-لا نهاية";
		symbolPosInf = "+لا نهاية";
		number = new thx.culture.core.NumberInfo(3, ".", [3], ",", "n-", "n");
		currency = new thx.culture.core.NumberInfo(3, ".", [3], ",", "$n-", "$ n");
		percent = new thx.culture.core.NumberInfo(3, ".", [3], ",", "-n %", "n %");
		pluralRule = 12;
		englishCurrency = "Tunisian Dinar";
		nativeCurrency = "دينار تونسي";
		currencySymbol = "د.ت.‏";
		currencyIso = "TND";
		englishRegion = "Tunisia";
		nativeRegion = "تونس";
		iso2 = "TN";
		iso3 = "TUN";
		isMetric = false;
		Culture.add(this);
	}
	@:isVar public static var culture(get, null) : Culture; static function get_culture() { if(null == culture) culture = new ArTN(); return culture; }
	static function __init__() { get_culture(); }
}