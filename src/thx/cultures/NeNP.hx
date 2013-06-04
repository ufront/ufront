package thx.cultures;

import thx.culture.Culture;

class NeNP extends Culture {
	function new() {
		name = "ne-NP";
		english = "Nepali (Nepal)";
		native = "नेपाली (नेपाल)";
		date = new thx.culture.core.DateTimeInfo(
			["जनवरी", "फेब्रुअरी", "मार्च", "अप्रिल", "मे", "जून", "जुलाई", "अगस्त", "सेप्टेम्बर", "अक्टोबर", "नोभेम्बर", "डिसेम्बर", ""],
			["जन", "फेब", "मार्च", "अप्रिल", "मे", "जून", "जुलाई", "अग", "सेप्ट", "अक्ट", "नोभ", "डिस", ""],
			["आइतवार", "सोमवार", "मङ्गलवार", "बुधवार", "बिहीवार", "शुक्रवार", "शनिवार"],
			["आइत", "सोम", "मङ्गल", "बुध", "बिही", "शुक्र", "शनि"],
			["आ", "सो", "म", "बु", "बि", "शु", "श"],
			"विहानी",
			"बेलुकी",
			"/",
			":",
			0,
			"%B,%Y",
			"%B %d",
			"%A, %B %d, %Y",
			"%f/%e/%Y",
			"%a, %d %b %Y %H:%M:%S GMT",
			"%A, %B %d, %Y %l:%M:%S %p",
			"%Y-%m-%d %H:%M:%SZ",
			"%Y-%m-%dT%H:%M:%S",
			"%l:%M:%S %p",
			"%l:%M:%S %p");
		symbolNaN = "nan";
		symbolPercent = "%";
		symbolPermille = "‰";
		signNeg = "-";
		signPos = "+";
		symbolNegInf = "-infinity";
		symbolPosInf = "infinity";
		digits = ["०", "१", "२", "३", "४", "५", "६", "७", "८", "९"];
		currency = new thx.culture.core.NumberInfo(2, ".", [3], ",", "-$n", "$n");
		englishCurrency = "Nepalese Rupees";
		nativeCurrency = "रुपैयाँ";
		currencySymbol = "रु";
		currencyIso = "NPR";
		englishRegion = "Nepal";
		nativeRegion = "नेपाल";
		iso2 = "NP";
		iso3 = "NPL";
		isMetric = false;
		Culture.add(this);
	}
	@:isVar public static var culture(get, null) : Culture; static function get_culture() { if(null == culture) culture = new NeNP(); return culture; }
}