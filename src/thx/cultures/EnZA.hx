package thx.cultures;

import thx.culture.Culture;

class EnZA extends Culture {
	function new() {
		language = thx.languages.En.language;
		name = "en-ZA";
		english = "English (South Africa)";
		native = "English (South Africa)";
		date = new thx.culture.core.DateTimeInfo(
			["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December", ""],
			["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec", ""],
			["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"],
			["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"],
			["Su", "Mo", "Tu", "We", "Th", "Fr", "Sa"],
			"AM",
			"PM",
			"/",
			":",
			0,
			"%B %Y",
			"%d %B",
			"%d %B %Y",
			"%Y/%m/%d",
			"%a, %d %b %Y %H:%M:%S GMT",
			"%d %B %Y %I:%M:%S %p",
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
		number = new thx.culture.core.NumberInfo(2, ".", [3], ",", "-n", "n");
		currency = new thx.culture.core.NumberInfo(2, ".", [3], ",", "$-n", "$ n");
		percent = new thx.culture.core.NumberInfo(2, ".", [3], ",", "-n%", "n%");
		pluralRule = 1;
		englishCurrency = "South African Rand";
		nativeCurrency = "Rand";
		currencySymbol = "R";
		currencyIso = "ZAR";
		englishRegion = "South Africa";
		nativeRegion = "South Africa";
		iso2 = "ZA";
		iso3 = "ZAF";
		isMetric = false;
		Culture.add(this);
	}
	@:isVar public static var culture(get, null) : Culture; static function get_culture() { if(null == culture) culture = new EnZA(); return culture; }
	static function __init__() { get_culture(); }
}