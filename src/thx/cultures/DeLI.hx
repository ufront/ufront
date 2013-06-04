package thx.cultures;

import thx.culture.Culture;

class DeLI extends Culture {
	function new() {
		language = thx.languages.De.language;
		name = "de-LI";
		english = "German (Liechtenstein)";
		native = "Deutsch (Liechtenstein)";
		date = new thx.culture.core.DateTimeInfo(
			["Januar", "Februar", "März", "April", "Mai", "Juni", "Juli", "August", "September", "Oktober", "November", "Dezember", ""],
			["Jan", "Feb", "Mrz", "Apr", "Mai", "Jun", "Jul", "Aug", "Sep", "Okt", "Nov", "Dez", ""],
			["Sonntag", "Montag", "Dienstag", "Mittwoch", "Donnerstag", "Freitag", "Samstag"],
			["So", "Mo", "Di", "Mi", "Do", "Fr", "Sa"],
			["So", "Mo", "Di", "Mi", "Do", "Fr", "Sa"],
			null,
			null,
			".",
			":",
			1,
			"%B %Y",
			"%d %B",
			"%A, %e. %B %Y",
			"%d.%m.%Y",
			"%a, %d %b %Y %H:%M:%S GMT",
			"%A, %e. %B %Y %H:%M:%S",
			"%Y-%m-%d %H:%M:%SZ",
			"%Y-%m-%dT%H:%M:%S",
			"%H:%M:%S",
			"%H:%M");
		symbolNaN = "n. def.";
		symbolPercent = "%";
		symbolPermille = "‰";
		signNeg = "-";
		signPos = "+";
		symbolNegInf = "-unendlich";
		symbolPosInf = "+unendlich";
		number = new thx.culture.core.NumberInfo(2, ".", [3], "'", "-n", "n");
		currency = new thx.culture.core.NumberInfo(2, ".", [3], "'", "$-n", "$ n");
		percent = new thx.culture.core.NumberInfo(2, ".", [3], "'", "-n%", "n%");
		pluralRule = 1;
		englishCurrency = "Swiss Franc";
		nativeCurrency = "Schweizer Franken";
		currencySymbol = "CHF";
		currencyIso = "CHF";
		englishRegion = "Liechtenstein";
		nativeRegion = "Liechtenstein";
		iso2 = "LI";
		iso3 = "LIE";
		isMetric = false;
		Culture.add(this);
	}
	@:isVar public static var culture(get, null) : Culture; static function get_culture() { if(null == culture) culture = new DeLI(); return culture; }
	static function __init__() { get_culture(); }
}