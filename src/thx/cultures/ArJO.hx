package thx.cultures;

import thx.culture.Culture;

class ArJO extends Culture {
	function new() {
		language = thx.languages.Ar.language;
		name = "ar-JO";
		english = "Arabic (Jordan)";
		native = "العربية (الأردن)";
		date = new thx.culture.core.DateTimeInfo(
			["كانون الثاني", "شباط", "آذار", "نيسان", "أيار", "حزيران", "تموز", "آب", "أيلول", "تشرين الأول", "تشرين الثاني", "كانون الأول", ""],
			["كانون الثاني", "شباط", "آذار", "نيسان", "أيار", "حزيران", "تموز", "آب", "أيلول", "تشرين الأول", "تشرين الثاني", "كانون الأول", ""],
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
		englishCurrency = "Jordanian Dinar";
		nativeCurrency = "دينار اردني";
		currencySymbol = "د.ا.‏";
		currencyIso = "JOD";
		englishRegion = "Jordan";
		nativeRegion = "الأردن";
		iso2 = "JO";
		iso3 = "JOR";
		isMetric = false;
		Culture.add(this);
	}
	@:isVar public static var culture(get, null) : Culture; static function get_culture() { if(null == culture) culture = new ArJO(); return culture; }
	static function __init__() { get_culture(); }
}