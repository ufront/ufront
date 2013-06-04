package thx.cultures;

import thx.culture.Culture;

class EnNZ extends Culture {
	function new() {
		language = thx.languages.En.language;
		name = "en-NZ";
		english = "English (New Zealand)";
		native = "English (New Zealand)";
		date = new thx.culture.core.DateTimeInfo(
			["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December", ""],
			["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec", ""],
			["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"],
			["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"],
			["Su", "Mo", "Tu", "We", "Th", "Fr", "Sa"],
			"a.m.",
			"p.m.",
			"/",
			":",
			1,
			"%B %Y",
			"%d %B",
			"%A, %e %B %Y",
			"%e/%m/%Y",
			"%a, %d %b %Y %H:%M:%S GMT",
			"%A, %e %B %Y %l:%M:%S %p",
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
		currency = new thx.culture.core.NumberInfo(2, ".", [3], ",", "-$n", "$n");
		percent = new thx.culture.core.NumberInfo(2, ".", [3], ",", "-n %", "n %");
		pluralRule = 1;
		englishCurrency = "New Zealand Dollar";
		nativeCurrency = "New Zealand Dollar";
		currencySymbol = "$";
		currencyIso = "NZD";
		englishRegion = "New Zealand";
		nativeRegion = "New Zealand";
		iso2 = "NZ";
		iso3 = "NZL";
		isMetric = true;
		Culture.add(this);
	}
	@:isVar public static var culture(get, null) : Culture; static function get_culture() { if(null == culture) culture = new EnNZ(); return culture; }
	static function __init__() { get_culture(); }
}