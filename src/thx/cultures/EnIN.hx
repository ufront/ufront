package thx.cultures;

import thx.culture.Culture;

class EnIN extends Culture {
	function new() {
		language = thx.languages.En.language;
		name = "en-IN";
		english = "English (India)";
		native = "English (India)";
		date = new thx.culture.core.DateTimeInfo(
			["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December", ""],
			["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec", ""],
			["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"],
			["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"],
			["Su", "Mo", "Tu", "We", "Th", "Fr", "Sa"],
			"AM",
			"PM",
			"-",
			":",
			1,
			"%B, %Y",
			"%B %d",
			"%d %B %Y",
			"%d-%m-%Y",
			"%a, %d %b %Y %H:%M:%S GMT",
			"%d %B %Y %H:%M:%S",
			"%Y-%m-%d %H:%M:%SZ",
			"%Y-%m-%dT%H:%M:%S",
			"%H:%M:%S",
			"%H:%M:%S");
		symbolNaN = "NaN";
		symbolPercent = "%";
		symbolPermille = "‰";
		signNeg = "-";
		signPos = "+";
		symbolNegInf = "-Infinity";
		symbolPosInf = "Infinity";
		number = new thx.culture.core.NumberInfo(2, ".", [3, 2], ",", "-n", "n");
		currency = new thx.culture.core.NumberInfo(2, ".", [3, 2], ",", "$ -n", "$ n");
		percent = new thx.culture.core.NumberInfo(2, ".", [3, 2], ",", "-n %", "n %");
		pluralRule = 1;
		englishCurrency = "Indian Rupee;";
		nativeCurrency = "Rupee;";
		currencySymbol = "Rs.";
		currencyIso = "INR";
		englishRegion = "India";
		nativeRegion = "India";
		iso2 = "IN";
		iso3 = "IND";
		isMetric = false;
		Culture.add(this);
	}
	@:isVar public static var culture(get, null) : Culture; static function get_culture() { if(null == culture) culture = new EnIN(); return culture; }
	static function __init__() { get_culture(); }
}