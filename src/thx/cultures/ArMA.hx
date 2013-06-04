package thx.cultures;

import thx.culture.Culture;

class ArMA extends Culture {
	function new() {
		language = thx.languages.Ar.language;
		name = "ar-MA";
		english = "Arabic (Morocco)";
		native = "العربية (المملكة المغربية)";
		date = new thx.culture.core.DateTimeInfo(
			["يناير", "فبراير", "مارس", "ابريل", "ماي", "يونيو", "يوليوز", "غشت", "شتنبر", "اكتوبر", "نونبر", "دجنبر", ""],
			["يناير", "فبراير", "مارس", "ابريل", "ماي", "يونيو", "يوليوز", "غشت", "شتنبر", "اكتوبر", "نونبر", "دجنبر", ""],
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
		number = new thx.culture.core.NumberInfo(2, ".", [3], ",", "n-", "n");
		currency = new thx.culture.core.NumberInfo(2, ".", [3], ",", "$n-", "$ n");
		percent = new thx.culture.core.NumberInfo(2, ".", [3], ",", "-n %", "n %");
		pluralRule = 12;
		englishCurrency = "Moroccan Dirham";
		nativeCurrency = "درهم مغربي";
		currencySymbol = "د.م.‏";
		currencyIso = "MAD";
		englishRegion = "Morocco";
		nativeRegion = "المملكة المغربية";
		iso2 = "MA";
		iso3 = "MAR";
		isMetric = false;
		Culture.add(this);
	}
	@:isVar public static var culture(get, null) : Culture; static function get_culture() { if(null == culture) culture = new ArMA(); return culture; }
	static function __init__() { get_culture(); }
}