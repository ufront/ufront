package thx.cultures;

import thx.culture.Culture;

class ArSA extends Culture {
	function new() {
		language = thx.languages.Ar.language;
		name = "ar-SA";
		english = "Arabic (Saudi Arabia)";
		native = "العربية (المملكة العربية السعودية)";
		date = new thx.culture.core.DateTimeInfo(
			["محرم", "صفر", "ربيع الأول", "ربيع الثاني", "جمادى الأولى", "جمادى الثانية", "رجب", "شعبان", "رمضان", "شوال", "ذو القعدة", "ذو الحجة", ""],
			["محرم", "صفر", "ربيع الاول", "ربيع الثاني", "جمادى الاولى", "جمادى الثانية", "رجب", "شعبان", "رمضان", "شوال", "ذو القعدة", "ذو الحجة", ""],
			["الاحد", "الاثنين", "الثلاثاء", "الاربعاء", "الخميس", "الجمعة", "السبت"],
			["الاحد", "الاثنين", "الثلاثاء", "الاربعاء", "الخميس", "الجمعة", "السبت"],
			["ح", "ن", "ث", "ر", "خ", "ج", "س"],
			"ص",
			"م",
			"/",
			":",
			6,
			"%B, %Y",
			"%d %B",
			"%d/%B/%Y",
			"%d/%m/%y",
			"%a, %d %b %Y %H:%M:%S GMT",
			"%d/%B/%Y %I:%M:%S %p",
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
		number = new thx.culture.core.NumberInfo(2, ".", [3], ",", "n-", "n");
		currency = new thx.culture.core.NumberInfo(2, ".", [3], ",", "$n-", "$ n");
		percent = new thx.culture.core.NumberInfo(2, ".", [3], ",", "-n %", "n %");
		pluralRule = 12;
		englishCurrency = "Saudi Riyal";
		nativeCurrency = "ريال سعودي";
		currencySymbol = "ر.س.‏";
		currencyIso = "SAR";
		englishRegion = "Saudi Arabia";
		nativeRegion = "المملكة العربية السعودية";
		iso2 = "SA";
		iso3 = "SAU";
		isMetric = false;
		Culture.add(this);
	}
	@:isVar public static var culture(get, null) : Culture; static function get_culture() { if(null == culture) culture = new ArSA(); return culture; }
	static function __init__() { get_culture(); }
}