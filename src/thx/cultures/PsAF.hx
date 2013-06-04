package thx.cultures;

import thx.culture.Culture;

class PsAF extends Culture {
	function new() {
		name = "ps-AF";
		english = "Pashto (Afghanistan)";
		native = "پښتو (افغانستان)";
		date = new thx.culture.core.DateTimeInfo(
			["محرم", "صفر", "ربيع الأول", "ربيع الثاني", "جمادى الأولى", "جمادى الثانية", "رجب", "شعبان", "رمضان", "شوال", "ذو القعدة", "ذو الحجة", ""],
			["محرم", "صفر", "ربيع الاول", "ربيع الثاني", "جمادى الاولى", "جمادى الثانية", "رجب", "شعبان", "رمضان", "شوال", "ذو القعدة", "ذو الحجة", ""],
			["الاحد", "الاثنين", "الثلاثاء", "الاربعاء", "الخميس", "الجمعة", "السبت"],
			["الاحد", "الاثنين", "الثلاثاء", "الاربعاء", "الخميس", "الجمعة", "السبت"],
			["ح", "ن", "ث", "ر", "خ", "ج", "س"],
			"غ.م",
			"غ.و",
			"/",
			":",
			6,
			"%B, %Y",
			"%d %B",
			"%d/%B/%Y",
			"%d/%m/%y",
			"%a, %d %b %Y %H:%M:%S GMT",
			"%d/%B/%Y %l:%M:%S %p",
			"%Y-%m-%d %H:%M:%SZ",
			"%Y-%m-%dT%H:%M:%S",
			"%l:%M:%S %p",
			"%l:%M:%S %p");
		symbolNaN = "غ ع";
		symbolPercent = "%";
		symbolPermille = "‰";
		signNeg = "-";
		signPos = "+";
		symbolNegInf = "-∞";
		symbolPosInf = "∞";
		digits = ["٠", "١", "٢", "٣", "٤", "٥", "٦", "٧", "٨", "٩"];
		number = new thx.culture.core.NumberInfo(2, ",", [3], "،", "n-", "n");
		currency = new thx.culture.core.NumberInfo(2, "٫", [3], "٬", "$n-", "$n");
		percent = new thx.culture.core.NumberInfo(2, ",", [3], "،", "-n %", "n %");
		englishCurrency = "Afghani";
		nativeCurrency = "افغانى";
		currencySymbol = "؋";
		currencyIso = "AFN";
		englishRegion = "Afghanistan";
		nativeRegion = "افغانستان";
		iso2 = "AF";
		iso3 = "AFG";
		isMetric = false;
		Culture.add(this);
	}
	@:isVar public static var culture(get, null) : Culture; static function get_culture() { if(null == culture) culture = new PsAF(); return culture; }
}