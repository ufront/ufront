package thx.cultures;

import thx.culture.Culture;

class SiLK extends Culture {
	function new() {
		name = "si-LK";
		english = "Sinhala (Sri Lanka)";
		native = "සිංහ (ශ්‍රී ලංකා)";
		date = new thx.culture.core.DateTimeInfo(
			["ජනවාරි", "පෙබරවාරි", "මාර්තු", "අ‌ප්‍රේල්", "මැයි", "ජූනි", "ජූලි", "අ‌ගෝස්තු", "සැප්තැම්බර්", "ඔක්තෝබර්", "නොවැම්බර්", "දෙසැම්බර්", ""],
			["ජන.", "පෙබ.", "මාර්තු.", "අප්‍රේල්.", "මැයි.", "ජූනි.", "ජූලි.", "අගෝ.", "සැප්.", "ඔක්.", "නොවැ.", "දෙසැ.", ""],
			["ඉරිදා", "සඳුදා", "අඟහරුවාදා", "බදාදා", "බ්‍රහස්පතින්දා", "සිකුරාදා", "සෙනසුරාදා"],
			["ඉරිදා", "සඳුදා", "කුජදා", "බුදදා", "ගුරුදා", "කිවිදා", "ශනිදා"],
			["ඉ", "ස", "අ", "බ", "බ්‍ර", "සි", "සෙ"],
			"පෙ.ව.",
			"ප.ව.",
			"-",
			":",
			1,
			"%Y %B",
			"%B %d",
			"%Y %B මස %d වැනිදා %A",
			"%Y-%m-%d",
			"%a, %d %b %Y %H:%M:%S GMT",
			"%Y %B මස %d වැනිදා %A %l:%M:%S %p",
			"%Y-%m-%d %H:%M:%SZ",
			"%Y-%m-%dT%H:%M:%S",
			"%l:%M:%S %p",
			"%l:%M:%S %p");
		symbolNaN = "NaN";
		symbolPercent = "%";
		symbolPermille = "‰";
		signNeg = "-";
		signPos = "+";
		symbolNegInf = "-අනන්තය";
		symbolPosInf = "අනන්තය";
		currency = new thx.culture.core.NumberInfo(2, ".", [3], ",", "($ n)", "$ n");
		englishCurrency = "Sri Lanka Rupee";
		nativeCurrency = "රුපියල්";
		currencySymbol = "රු.";
		currencyIso = "LKR";
		englishRegion = "Sri Lanka";
		nativeRegion = "ශ්‍රී ලංකා";
		iso2 = "LK";
		iso3 = "LKA";
		isMetric = false;
		Culture.add(this);
	}
	@:isVar public static var culture(get, null) : Culture; static function get_culture() { if(null == culture) culture = new SiLK(); return culture; }
}