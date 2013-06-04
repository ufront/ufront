package thx.cultures;

import thx.culture.Culture;

class MkMK extends Culture {
	function new() {
		language = thx.languages.Mk.language;
		name = "mk-MK";
		english = "Macedonian (Former Yugoslav Republic of Macedonia)";
		native = "македонски јазик (Македонија)";
		date = new thx.culture.core.DateTimeInfo(
			["јануари", "февруари", "март", "април", "мај", "јуни", "јули", "август", "септември", "октомври", "ноември", "декември", ""],
			["јан", "фев", "мар", "апр", "мај", "јун", "јул", "авг", "сеп", "окт", "ное", "дек", ""],
			["недела", "понеделник", "вторник", "среда", "четврток", "петок", "сабота"],
			["нед", "пон", "втр", "срд", "чет", "пет", "саб"],
			["не", "по", "вт", "ср", "че", "пе", "са"],
			null,
			null,
			".",
			":",
			1,
			"%B %Y",
			"%d %B",
			"%A, %d %B %Y",
			"%d.%m.%Y",
			"%a, %d %b %Y %H:%M:%S GMT",
			"%A, %d %B %Y %H:%M:%S",
			"%Y-%m-%d %H:%M:%SZ",
			"%Y-%m-%dT%H:%M:%S",
			"%H:%M:%S",
			"%H:%M");
		symbolNaN = "NaN";
		symbolPercent = "%";
		symbolPermille = "‰";
		signNeg = "-";
		signPos = "+";
		symbolNegInf = "-Infinity";
		symbolPosInf = "Infinity";
		number = new thx.culture.core.NumberInfo(2, ",", [3], ".", "-n", "n");
		currency = new thx.culture.core.NumberInfo(2, ",", [3], ".", "-n $", "n $");
		percent = new thx.culture.core.NumberInfo(2, ",", [3], ".", "-n %", "n %");
		pluralRule = 14;
		englishCurrency = "Macedonian Denar";
		nativeCurrency = "денар";
		currencySymbol = "ден.";
		currencyIso = "MKD";
		englishRegion = "Macedonia (FYROM)";
		nativeRegion = "Македонија";
		iso2 = "MK";
		iso3 = "MKD";
		isMetric = false;
		Culture.add(this);
	}
	@:isVar public static var culture(get, null) : Culture; static function get_culture() { if(null == culture) culture = new MkMK(); return culture; }
	static function __init__() { get_culture(); }
}