package thx.cultures;

import thx.culture.Culture;

class AmET extends Culture {
	function new() {
		name = "am-ET";
		english = "Amharic (Ethiopia)";
		native = "አማርኛ (ኢትዮጵያ)";
		date = new thx.culture.core.DateTimeInfo(
			["ጃንዩወሪ", "ፌብሩወሪ", "ማርች", "ኤፕረል", "ሜይ", "ጁን", "ጁላይ", "ኦገስት", "ሴፕቴምበር", "ኦክተውበር", "ኖቬምበር", "ዲሴምበር", ""],
			["ጃንዩ", "ፌብሩ", "ማርች", "ኤፕረ", "ሜይ", "ጁን", "ጁላይ", "ኦገስ", "ሴፕቴ", "ኦክተ", "ኖቬም", "ዲሴም", ""],
			["እሑድ", "ሰኞ", "ማክሰኞ", "ረቡዕ", "ሐሙስ", "ዓርብ", "ቅዳሜ"],
			["እሑድ", "ሰኞ", "ማክሰ", "ረቡዕ", "ሐሙስ", "ዓርብ", "ቅዳሜ"],
			["እ", "ሰ", "ማ", "ረ", "ሐ", "ዓ", "ቅ"],
			"ጡዋት",
			"ከሰዓት",
			"/",
			":",
			0,
			"%B %Y",
			"%B %d",
			"%A ፣ %B %e ቀን %Y",
			"%e/%f/%Y",
			"%a, %d %b %Y %H:%M:%S GMT",
			"%A ፣ %B %e ቀን %Y %l:%M:%S %p",
			"%Y-%m-%d %H:%M:%SZ",
			"%Y-%m-%dT%H:%M:%S",
			"%l:%M:%S %p",
			"%l:%M:%S %p");
		symbolNaN = "NAN";
		symbolPercent = "%";
		symbolPermille = "‰";
		signNeg = "-";
		signPos = "+";
		symbolNegInf = "-Infinity";
		symbolPosInf = "Infinity";
		number = new thx.culture.core.NumberInfo(1, ".", [3, 0], ",", "-n", "n");
		currency = new thx.culture.core.NumberInfo(2, ".", [3, 0], ",", "-$n", "$n");
		percent = new thx.culture.core.NumberInfo(1, ".", [3, 0], ",", "-n %", "n %");
		englishCurrency = "Ethiopian Birr";
		nativeCurrency = "ብር";
		currencySymbol = "ETB";
		currencyIso = "ETB";
		englishRegion = "Ethiopia";
		nativeRegion = "ኢትዮጵያ";
		iso2 = "ET";
		iso3 = "ETH";
		isMetric = false;
		Culture.add(this);
	}
	@:isVar public static var culture(get, null) : Culture; static function get_culture() { if(null == culture) culture = new AmET(); return culture; }
}