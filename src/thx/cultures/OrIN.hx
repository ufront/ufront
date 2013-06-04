package thx.cultures;

import thx.culture.Culture;

class OrIN extends Culture {
	function new() {
		name = "or-IN";
		english = "Oriya (India)";
		native = "ଓଡ଼ିଆ (ଭାରତ)";
		date = new thx.culture.core.DateTimeInfo(
			["ଜାନୁୟାରୀ", "ଫ୍ରେବୃୟାରୀ", "ମାର୍ଚ୍ଚ", "ଏପ୍ରିଲ୍‌", "ମେ", "ଜୁନ୍‌", "ଜୁଲାଇ", "ଅଗଷ୍ଟ", "ସେପ୍ଟେମ୍ବର", "ଅକ୍ଟୋବର", "ନଭେମ୍ବର", "(ଡିସେମ୍ବର", ""],
			["ଜାନୁୟାରୀ", "ଫ୍ରେବୃୟାରୀ", "ମାର୍ଚ୍ଚ", "ଏପ୍ରିଲ୍‌", "ମେ", "ଜୁନ୍‌", "ଜୁଲାଇ", "ଅଗଷ୍ଟ", "ସେପ୍ଟେମ୍ବର", "ଅକ୍ଟୋବର", "ନଭେମ୍ବର", "(ଡିସେମ୍ବର", ""],
			["ରବିବାର", "ସୋମବାର", "ମଙ୍ଗଳବାର", "ବୁଧବାର", "ଗୁରୁବାର", "ଶୁକ୍ରବାର", "ଶନିବାର"],
			["ରବି.", "ସୋମ.", "ମଙ୍ଗଳ.", "ବୁଧ.", "ଗୁରୁ.", "ଶୁକ୍ର.", "ଶନି."],
			["ର", "ସୋ", "ମ", "ବୁ", "ଗୁ", "ଶୁ", "ଶ"],
			"AM",
			"PM",
			"-",
			":",
			0,
			"%B, %Y",
			"%B %d",
			"%d %B %Y",
			"%d-%m-%y",
			"%a, %d %b %Y %H:%M:%S GMT",
			"%d %B %Y %H:%M:%S",
			"%Y-%m-%d %H:%M:%SZ",
			"%Y-%m-%dT%H:%M:%S",
			"%H:%M:%S",
			"%H:%M:%S");
		symbolNaN = "NaN";
		symbolPercent = "%";
		symbolPermille = "‰";
		signNeg = "-";
		signPos = "+";
		symbolNegInf = "-Infinity";
		symbolPosInf = "Infinity";
		digits = ["୦", "୧", "୨", "୩", "୪", "୫", "୬", "୭", "୮", "୯"];
		currency = new thx.culture.core.NumberInfo(2, ".", [3, 2], ",", "$ -n", "$ n");
		englishCurrency = "Indian Rupee";
		nativeCurrency = "ଟଙ୍କା";
		currencySymbol = "ଟ";
		currencyIso = "INR";
		englishRegion = "India";
		nativeRegion = "ଭାରତ";
		iso2 = "IN";
		iso3 = "IND";
		isMetric = false;
		Culture.add(this);
	}
	@:isVar public static var culture(get, null) : Culture; static function get_culture() { if(null == culture) culture = new OrIN(); return culture; }
}