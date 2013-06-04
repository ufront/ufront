package thx.cultures;

import thx.culture.Culture;

class ArBH extends Culture {
	function new() {
		language = thx.languages.Ar.language;
		name = "ar-BH";
		english = "Arabic (Bahrain)";
		native = "العربية (البحرين)";
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
		digits = ["٠", "١", "٢", "٣", "٤", "٥", "٦", "٧", "٨", "٩"];
		number = new thx.culture.core.NumberInfo(3, ".", [3], ",", "n-", "n");
		currency = new thx.culture.core.NumberInfo(3, ".", [3], ",", "$n-", "$ n");
		percent = new thx.culture.core.NumberInfo(3, ".", [3], ",", "-n %", "n %");
		pluralRule = 12;
		englishCurrency = "Bahraini Dinar";
		nativeCurrency = "دينار بحريني";
		currencySymbol = "د.ب.‏";
		currencyIso = "BHD";
		englishRegion = "Bahrain";
		nativeRegion = "البحرين";
		iso2 = "BH";
		iso3 = "BHR";
		isMetric = false;
		Culture.add(this);
	}
	@:isVar public static var culture(get, null) : Culture; static function get_culture() { if(null == culture) culture = new ArBH(); return culture; }
	static function __init__() { get_culture(); }
}