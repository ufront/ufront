package thx.cultures;

import thx.culture.Culture;

class ZhHK extends Culture {
	function new() {
		language = thx.languages.ZhHant.language;
		name = "zh-HK";
		english = "Chinese (Hong Kong S.A.R.)";
		native = "中文(香港特别行政區)";
		date = new thx.culture.core.DateTimeInfo(
			["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December", ""],
			["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec", ""],
			["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"],
			["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"],
			["Su", "Mo", "Tu", "We", "Th", "Fr", "Sa"],
			null,
			null,
			"/",
			":",
			0,
			"%B, %Y",
			"%e %B",
			"%A, %e %B, %Y",
			"%e/%f/%Y",
			"%a, %d %b %Y %H:%M:%S GMT",
			"%A, %e %B, %Y %k:%M:%S",
			"%Y-%m-%d %H:%M:%SZ",
			"%Y-%m-%dT%H:%M:%S",
			"%k:%M:%S",
			"%k:%M");
		symbolNaN = "NaN";
		symbolPercent = "%";
		symbolPermille = "‰";
		signNeg = "-";
		signPos = "+";
		symbolNegInf = "-Infinity";
		symbolPosInf = "Infinity";
		number = new thx.culture.core.NumberInfo(2, ".", [3], ",", "-n", "n");
		currency = new thx.culture.core.NumberInfo(2, ".", [3], ",", "($n)", "$n");
		percent = new thx.culture.core.NumberInfo(2, ".", [3], ",", "-n%", "n%");
		pluralRule = 1;
		englishCurrency = "Hong Kong Dollar";
		nativeCurrency = "港幣";
		currencySymbol = "HK$";
		currencyIso = "HKD";
		englishRegion = "Hong Kong S.A.R.";
		nativeRegion = "香港特别行政區";
		iso2 = "HK";
		iso3 = "HKG";
		isMetric = false;
		Culture.add(this);
	}
	@:isVar public static var culture(get, null) : Culture; static function get_culture() { if(null == culture) culture = new ZhHK(); return culture; }
	static function __init__() { get_culture(); }
}