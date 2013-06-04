package thx.cultures;

import thx.culture.Culture;

class SaIN extends Culture {
	function new() {
		language = thx.languages.Sa.language;
		name = "sa-IN";
		english = "Sanskrit (India)";
		native = "संस्कृत (भारतम्)";
		date = new thx.culture.core.DateTimeInfo(
			["जनवरी", "फरवरी", "मार्च", "अप्रैल", "मई", "जून", "जुलाई", "अगस्त", "सितम्बर", "अक्तूबर", "नवम्बर", "दिसम्बर", ""],
			["जनवरी", "फरवरी", "मार्च", "अप्रैल", "मई", "जून", "जुलाई", "अगस्त", "सितम्बर", "अक्तूबर", "नवम्बर", "दिसम्बर", ""],
			["रविवासरः", "सोमवासरः", "मङ्गलवासरः", "बुधवासरः", "गुरुवासरः", "शुक्रवासरः", "शनिवासरः"],
			["रविवासरः", "सोमवासरः", "मङ्गलवासरः", "बुधवासरः", "गुरुवासरः", "शुक्रवासरः", "शनिवासरः"],
			["र", "स", "म", "ब", "ग", "श", "श"],
			"पूर्वाह्न",
			"अपराह्न",
			"-",
			":",
			0,
			"%B, %Y",
			"%d %B",
			"%d %B %Y %A",
			"%d-%m-%Y",
			"%a, %d %b %Y %H:%M:%S GMT",
			"%d %B %Y %A %H:%M:%S",
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
		pluralRule = 4;
		englishCurrency = "Indian Rupee";
		nativeCurrency = "रु्यकम्";
		currencySymbol = "रु";
		currencyIso = "INR";
		englishRegion = "India";
		nativeRegion = "भारतम्";
		iso2 = "IN";
		iso3 = "IND";
		isMetric = false;
		Culture.add(this);
	}
	@:isVar public static var culture(get, null) : Culture; static function get_culture() { if(null == culture) culture = new SaIN(); return culture; }
	static function __init__() { get_culture(); }
}