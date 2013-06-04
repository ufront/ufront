package thx.cultures;

import thx.culture.Culture;

class EnZW extends Culture {
	function new() {
		language = thx.languages.En.language;
		name = "en-ZW";
		english = "English (Zimbabwe)";
		native = "English (Zimbabwe)";
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
			"%B, %Y",
			"%B %d",
			"%A, %B %d, %Y",
			"%f/%e/%Y",
			"%a, %d %b %Y %H:%M:%S GMT",
			"%A, %B %d, %Y %l:%M:%S %p",
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
		number = new thx.culture.core.NumberInfo(2, ".", [3], ",", "-n", "n");
		currency = new thx.culture.core.NumberInfo(2, ".", [3], ",", "($n)", "$n");
		percent = new thx.culture.core.NumberInfo(2, ".", [3], ",", "-n %", "n %");
		pluralRule = 1;
		englishCurrency = "Zimbabwe Dollar";
		nativeCurrency = "Zimbabwe Dollar";
		currencySymbol = "Z$";
		currencyIso = "ZWD";
		englishRegion = "Zimbabwe";
		nativeRegion = "Zimbabwe";
		iso2 = "ZW";
		iso3 = "ZWE";
		isMetric = false;
		Culture.add(this);
	}
	@:isVar public static var culture(get, null) : Culture; static function get_culture() { if(null == culture) culture = new EnZW(); return culture; }
	static function __init__() { get_culture(); }
}