package thx.cultures;

import thx.culture.Culture;

class TaIN extends Culture {
	function new() {
		language = thx.languages.Ta.language;
		name = "ta-IN";
		english = "Tamil (India)";
		native = "தமிழ் (இந்தியா)";
		date = new thx.culture.core.DateTimeInfo(
			["ஜனவரி", "பெப்ரவரி", "மார்ச்", "ஏப்ரல்", "மே", "ஜூன்", "ஜூலை", "ஆகஸ்ட்", "செப்டம்பர்", "அக்டோபர்", "நவம்பர்", "டிசம்பர்", ""],
			["ஜன.", "பெப்.", "மார்.", "ஏப்.", "மே", "ஜூன்", "ஜூலை", "ஆக.", "செப்.", "அக்.", "நவ.", "டிச.", ""],
			["ஞாயிறு", "திங்கள்", "செவ்வாய்", "புதன்", "வியாழன்", "வெள்ளி", "சனி"],
			["ஞா", "தி", "செ", "பு", "வி", "வெ", "ச"],
			["ஞ", "த", "ச", "ப", "வ", "வ", "ச"],
			"காலை",
			"மாலை",
			"-",
			":",
			1,
			"%B %Y",
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
		digits = ["௦", "௧", "௨", "௩", "௪", "௫", "௬", "௭", "௮", "௯"];
		number = new thx.culture.core.NumberInfo(2, ".", [3, 2], ",", "-n", "n");
		currency = new thx.culture.core.NumberInfo(2, ".", [3, 2], ",", "$ -n", "$ n");
		percent = new thx.culture.core.NumberInfo(2, ".", [3, 2], ",", "-n %", "n %");
		pluralRule = 1;
		englishCurrency = "Indian Rupee";
		nativeCurrency = "ரூபாய்";
		currencySymbol = "ரூ";
		currencyIso = "INR";
		englishRegion = "India";
		nativeRegion = "இந்தியா";
		iso2 = "IN";
		iso3 = "IND";
		isMetric = false;
		Culture.add(this);
	}
	@:isVar public static var culture(get, null) : Culture; static function get_culture() { if(null == culture) culture = new TaIN(); return culture; }
	static function __init__() { get_culture(); }
}