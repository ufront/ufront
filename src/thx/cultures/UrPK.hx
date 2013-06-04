package thx.cultures;

import thx.culture.Culture;

class UrPK extends Culture {
	function new() {
		language = thx.languages.Ur.language;
		name = "ur-PK";
		english = "Urdu (Islamic Republic of Pakistan)";
		native = "اُردو (پاکستان)";
		date = new thx.culture.core.DateTimeInfo(
			["جنورى", "فرورى", "مارچ", "اپريل", "مئ", "جون", "جولاٸ", "اگست", "ستمبر", "اکتوبر", "نومبر", "دسمبر", ""],
			["جنورى", "فرورى", "مارچ", "اپريل", "مئ", "جون", "جولاٸ", "اگست", "ستمبر", "اکتوبر", "نومبر", "دسمبر", ""],
			["اتوار", "پير", "منگل", "بدھ", "جمعرات", "جمعه", "هفته"],
			["اتوار", "پير", "منگل", "بدھ", "جمعرات", "جمعه", "هفته"],
			["ا", "پ", "م", "ب", "ج", "ج", "ه"],
			"AM",
			"PM",
			"/",
			":",
			1,
			"%B, %Y",
			"%d %B",
			"%d %B, %Y",
			"%d/%m/%Y",
			"%a, %d %b %Y %H:%M:%S GMT",
			"%d %B, %Y %l:%M:%S %p",
			"%Y-%m-%d %H:%M:%SZ",
			"%Y-%m-%dT%H:%M:%S",
			"%l:%M:%S %p",
			"%l:%M %p");
		symbolNaN = "NaN";
		symbolPercent = "%";
		symbolPermille = "‰";
		signNeg = "-";
		signPos = "+";
		symbolNegInf = "-Infinity";
		symbolPosInf = "Infinity";
		digits = ["۰", "۱", "۲", "۳", "۴", "۵", "۶", "۷", "۸", "۹"];
		number = new thx.culture.core.NumberInfo(2, ".", [3], ",", "-n", "n");
		currency = new thx.culture.core.NumberInfo(2, ".", [3], ",", "$n-", "$n");
		percent = new thx.culture.core.NumberInfo(2, ".", [3], ",", "-n %", "n %");
		pluralRule = 1;
		englishCurrency = "Pakistan Rupee";
		nativeCurrency = "روپيه";
		currencySymbol = "Rs";
		currencyIso = "PKR";
		englishRegion = "Islamic Republic of Pakistan";
		nativeRegion = "پاکستان";
		iso2 = "PK";
		iso3 = "PAK";
		isMetric = false;
		Culture.add(this);
	}
	@:isVar public static var culture(get, null) : Culture; static function get_culture() { if(null == culture) culture = new UrPK(); return culture; }
	static function __init__() { get_culture(); }
}