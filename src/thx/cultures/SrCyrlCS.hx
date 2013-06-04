package thx.cultures;

import thx.culture.Culture;

class SrCyrlCS extends Culture {
	function new() {
		language = thx.languages.Sr.language;
		name = "sr-Cyrl-CS";
		english = "Serbian (Cyrillic, Serbia and Montenegro (Former))";
		native = "српски (Србија и Црна Гора (Претходно))";
		date = new thx.culture.core.DateTimeInfo(
			["јануар", "фебруар", "март", "април", "мај", "јун", "јул", "август", "септембар", "октобар", "новембар", "децембар", ""],
			["јан", "феб", "мар", "апр", "мај", "јун", "јул", "авг", "сеп", "окт", "нов", "дец", ""],
			["недеља", "понедељак", "уторак", "среда", "четвртак", "петак", "субота"],
			["нед", "пон", "уто", "сре", "чет", "пет", "суб"],
			["не", "по", "ут", "ср", "че", "пе", "су"],
			null,
			null,
			".",
			":",
			1,
			"%B %Y",
			"%e. %B",
			"%e. %B %Y",
			"%e.%f.%Y",
			"%a, %d %b %Y %H:%M:%S GMT",
			"%e. %B %Y %k:%M:%S",
			"%Y-%m-%d %H:%M:%SZ",
			"%Y-%m-%dT%H:%M:%S",
			"%k:%M:%S",
			"%k:%M");
		symbolNaN = "NaN";
		symbolPercent = "%";
		symbolPermille = "‰";
		signNeg = "-";
		signPos = "+";
		symbolNegInf = "-бесконачност";
		symbolPosInf = "+бесконачност";
		number = new thx.culture.core.NumberInfo(2, ",", [3], ".", "-n", "n");
		currency = new thx.culture.core.NumberInfo(2, ",", [3], ".", "-n $", "n $");
		percent = new thx.culture.core.NumberInfo(2, ",", [3], ".", "-n%", "n%");
		pluralRule = 7;
		englishCurrency = "Serbian Dinar";
		nativeCurrency = "динар";
		currencySymbol = "Дин.";
		currencyIso = "CSD";
		englishRegion = "Serbia and Montenegro (Former)";
		nativeRegion = "Србија и Црна Гора (Претходно)";
		iso2 = "CS";
		iso3 = "SCG";
		isMetric = false;
		Culture.add(this);
	}
	@:isVar public static var culture(get, null) : Culture; static function get_culture() { if(null == culture) culture = new SrCyrlCS(); return culture; }
	static function __init__() { get_culture(); }
}