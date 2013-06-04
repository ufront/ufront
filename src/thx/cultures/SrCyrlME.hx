package thx.cultures;

import thx.culture.Culture;

class SrCyrlME extends Culture {
	function new() {
		name = "sr-Cyrl-ME";
		english = "Serbian (Cyrillic) (Montenegro)";
		native = "српски (Црна Гора)";
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
			"%B %d",
			"%e. %B %Y",
			"%e.%f.%Y",
			"%a, %d %b %Y %H:%M:%S GMT",
			"%e. %B %Y %k:%M:%S",
			"%Y-%m-%d %H:%M:%SZ",
			"%Y-%m-%dT%H:%M:%S",
			"%k:%M:%S",
			"%k:%M:%S");
		symbolNaN = "NaN";
		symbolPercent = "%";
		symbolPermille = "‰";
		signNeg = "-";
		signPos = "+";
		symbolNegInf = "-бесконачност";
		symbolPosInf = "+бесконачност";
		number = new thx.culture.core.NumberInfo(2, ",", [3], ".", "-n", "n");
		currency = new thx.culture.core.NumberInfo(2, ",", [3], ".", "-n $", "n $");
		percent = new thx.culture.core.NumberInfo(2, ",", [3], ".", "-n %", "n %");
		englishCurrency = "Euro";
		nativeCurrency = "Еуро";
		currencySymbol = "€";
		currencyIso = "EUR";
		englishRegion = "Montenegro";
		nativeRegion = "Црна Гора";
		iso2 = "ME";
		iso3 = "MNE";
		isMetric = false;
		Culture.add(this);
	}
	@:isVar public static var culture(get, null) : Culture; static function get_culture() { if(null == culture) culture = new SrCyrlME(); return culture; }
}