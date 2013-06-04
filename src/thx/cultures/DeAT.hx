package thx.cultures;

import thx.culture.Culture;

class DeAT extends Culture {
	function new() {
		language = thx.languages.De.language;
		name = "de-AT";
		english = "German (Austria)";
		native = "Deutsch (Österreich)";
		date = new thx.culture.core.DateTimeInfo(
			["Jänner", "Februar", "März", "April", "Mai", "Juni", "Juli", "August", "September", "Oktober", "November", "Dezember", ""],
			["Jän", "Feb", "Mär", "Apr", "Mai", "Jun", "Jul", "Aug", "Sep", "Okt", "Nov", "Dez", ""],
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
			"%A, %d. %B %Y",
			"%d.%m.%Y",
			"%a, %d %b %Y %H:%M:%S GMT",
			"%A, %d. %B %Y %H:%M:%S",
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
		number = new thx.culture.core.NumberInfo(2, ",", [3], ".", "-n", "n");
		currency = new thx.culture.core.NumberInfo(2, ",", [3], ".", "-$ n", "$ n");
		percent = new thx.culture.core.NumberInfo(2, ",", [3], ".", "-n%", "n%");
		pluralRule = 1;
		englishCurrency = "Euro";
		nativeCurrency = "Euro";
		currencySymbol = "€";
		currencyIso = "EUR";
		englishRegion = "Austria";
		nativeRegion = "Österreich";
		iso2 = "AT";
		iso3 = "AUT";
		isMetric = false;
		Culture.add(this);
	}
	@:isVar public static var culture(get, null) : Culture; static function get_culture() { if(null == culture) culture = new DeAT(); return culture; }
	static function __init__() { get_culture(); }
}