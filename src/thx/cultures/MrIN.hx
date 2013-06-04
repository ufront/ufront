package thx.cultures;

import thx.culture.Culture;

class MrIN extends Culture {
	function new() {
		language = thx.languages.Mr.language;
		name = "mr-IN";
		english = "Marathi (India)";
		native = "मराठी (भारत)";
		date = new thx.culture.core.DateTimeInfo(
			["जानेवारी", "फेब्रुवारी", "मार्च", "एप्रिल", "मे", "जून", "जुलै", "ऑगस्ट", "सप्टेंबर", "ऑक्टोबर", "नोव्हेंबर", "डिसेंबर", ""],
			["जाने.", "फेब्रु.", "मार्च", "एप्रिल", "मे", "जून", "जुलै", "ऑगस्ट", "सप्टें.", "ऑक्टो.", "नोव्हें.", "डिसें.", ""],
			["रविवार", "सोमवार", "मंगळवार", "बुधवार", "गुरुवार", "शुक्रवार", "शनिवार"],
			["रवि.", "सोम.", "मंगळ.", "बुध.", "गुरु.", "शुक्र.", "शनि."],
			["र", "स", "म", "ब", "ग", "श", "श"],
			"म.पू.",
			"म.नं.",
			"-",
			":",
			1,
			"%B, %Y",
			"%d %B",
			"%d %B %Y",
			"%d-%m-%Y",
			"%a, %d %b %Y %H:%M:%S GMT",
			"%d %B %Y %H:%M:%S",
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
		digits = ["०", "१", "२", "३", "४", "५", "६", "७", "८", "९"];
		number = new thx.culture.core.NumberInfo(2, ".", [3, 2], ",", "-n", "n");
		currency = new thx.culture.core.NumberInfo(2, ".", [3, 2], ",", "$ -n", "$ n");
		percent = new thx.culture.core.NumberInfo(2, ".", [3, 2], ",", "-n %", "n %");
		pluralRule = 1;
		englishCurrency = "Indian Rupee";
		nativeCurrency = "रुपया";
		currencySymbol = "रु";
		currencyIso = "INR";
		englishRegion = "India";
		nativeRegion = "भारत";
		iso2 = "IN";
		iso3 = "IND";
		isMetric = false;
		Culture.add(this);
	}
	@:isVar public static var culture(get, null) : Culture; static function get_culture() { if(null == culture) culture = new MrIN(); return culture; }
	static function __init__() { get_culture(); }
}