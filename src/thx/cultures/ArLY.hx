package thx.cultures;

import thx.culture.Culture;

class ArLY extends Culture {
	function new() {
		language = thx.languages.Ar.language;
		name = "ar-LY";
		english = "Arabic (Libya)";
		native = "العربية (ليبيا)";
		date = new thx.culture.core.DateTimeInfo(
			["يناير", "فبراير", "مارس", "ابريل", "مايو", "يونيو", "يوليو", "اغسطس", "سبتمبر", "اكتوبر", "نوفمبر", "ديسمبر", ""],
			["يناير", "فبراير", "مارس", "ابريل", "مايو", "يونيو", "يوليو", "اغسطس", "سبتمبر", "اكتوبر", "نوفمبر", "ديسمبر", ""],
			["الاحد", "الاثنين", "الثلاثاء", "الاربعاء", "الخميس", "الجمعة", "السبت"],
			["الاحد", "الاثنين", "الثلاثاء", "الاربعاء", "الخميس", "الجمعة", "السبت"],
			["أ", "ا", "ث", "أ", "خ", "ج", "س"],
			"ص",
			"م",
			"/",
			":",
			6,
			"%B, %Y",
			"%d %B",
			"%d %B, %Y",
			"%d/%m/%Y",
			"%a, %d %b %Y %H:%M:%S GMT",
			"%d %B, %Y %I:%M:%S %p",
			"%Y-%m-%d %H:%M:%SZ",
			"%Y-%m-%dT%H:%M:%S",
			"%I:%M:%S %p",
			"%I:%M %p");
		symbolNaN = "ليس برقم";
		symbolPercent = "%";
		symbolPermille = "‰";
		signNeg = "-";
		signPos = "+";
		symbolNegInf = "-لا نهاية";
		symbolPosInf = "+لا نهاية";
		number = new thx.culture.core.NumberInfo(2, ".", [3], ",", "n-", "n");
		currency = new thx.culture.core.NumberInfo(2, ".", [3], ",", "$n-", "$ n");
		percent = new thx.culture.core.NumberInfo(2, ".", [3], ",", "-n %", "n %");
		pluralRule = 12;
		englishCurrency = "Libyan Dinar";
		nativeCurrency = "دينار ليبي";
		currencySymbol = "د.ل.‏";
		currencyIso = "LYD";
		englishRegion = "Libya";
		nativeRegion = "ليبيا";
		iso2 = "LY";
		iso3 = "LBY";
		isMetric = false;
		Culture.add(this);
	}
	@:isVar public static var culture(get, null) : Culture; static function get_culture() { if(null == culture) culture = new ArLY(); return culture; }
	static function __init__() { get_culture(); }
}