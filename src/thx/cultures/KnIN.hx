package thx.cultures;

import thx.culture.Culture;

class KnIN extends Culture {
	function new() {
		language = thx.languages.Kn.language;
		name = "kn-IN";
		english = "Kannada (India)";
		native = "ಕನ್ನಡ (ಭಾರತ)";
		date = new thx.culture.core.DateTimeInfo(
			["ಜನವರಿ", "ಫೆಬ್ರವರಿ", "ಮಾರ್ಚ್", "ಎಪ್ರಿಲ್", "ಮೇ", "ಜೂನ್", "ಜುಲೈ", "ಆಗಸ್ಟ್", "ಸೆಪ್ಟಂಬರ್", "ಅಕ್ಟೋಬರ್", "ನವೆಂಬರ್", "ಡಿಸೆಂಬರ್", ""],
			["ಜನವರಿ", "ಫೆಬ್ರವರಿ", "ಮಾರ್ಚ್", "ಎಪ್ರಿಲ್", "ಮೇ", "ಜೂನ್", "ಜುಲೈ", "ಆಗಸ್ಟ್", "ಸೆಪ್ಟಂಬರ್", "ಅಕ್ಟೋಬರ್", "ನವೆಂಬರ್", "ಡಿಸೆಂಬರ್", ""],
			["ಭಾನುವಾರ", "ಸೋಮವಾರ", "ಮಂಗಳವಾರ", "ಬುಧವಾರ", "ಗುರುವಾರ", "ಶುಕ್ರವಾರ", "ಶನಿವಾರ"],
			["ಭಾನು.", "ಸೋಮ.", "ಮಂಗಳ.", "ಬುಧ.", "ಗುರು.", "ಶುಕ್ರ.", "ಶನಿ."],
			["ರ", "ಸ", "ಮ", "ಬ", "ಗ", "ಶ", "ಶ"],
			"ಪೂರ್ವಾಹ್ನ",
			"ಅಪರಾಹ್ನ",
			"-",
			":",
			1,
			"%B, %Y",
			"%d %B",
			"%d %B %Y",
			"%d-%m-%y",
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
		digits = ["೦", "೧", "೨", "೩", "೪", "೫", "೬", "೭", "೮", "೯"];
		number = new thx.culture.core.NumberInfo(2, ".", [3, 2], ",", "-n", "n");
		currency = new thx.culture.core.NumberInfo(2, ".", [3, 2], ",", "$ -n", "$ n");
		percent = new thx.culture.core.NumberInfo(2, ".", [3, 2], ",", "-n %", "n %");
		pluralRule = 0;
		englishCurrency = "Indian Rupee";
		nativeCurrency = "ರೂಪಾಯಿ";
		currencySymbol = "ರೂ";
		currencyIso = "INR";
		englishRegion = "India";
		nativeRegion = "ಭಾರತ";
		iso2 = "IN";
		iso3 = "IND";
		isMetric = false;
		Culture.add(this);
	}
	@:isVar public static var culture(get, null) : Culture; static function get_culture() { if(null == culture) culture = new KnIN(); return culture; }
	static function __init__() { get_culture(); }
}