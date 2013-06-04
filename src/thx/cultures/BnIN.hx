package thx.cultures;

import thx.culture.Culture;

class BnIN extends Culture {
	function new() {
		name = "bn-IN";
		english = "Bengali (India)";
		native = "বাংলা (ভারত)";
		date = new thx.culture.core.DateTimeInfo(
			["জানুয়ারী", "ফেব্রুয়ারী", "মার্চ", "এপ্রিল", "মে", "জুন", "জুলাই", "আগস্ট", "সেপ্টেম্বর", "অক্টোবর", "নভেম্বর", "ডিসেম্বর", ""],
			["জানু.", "ফেব্রু.", "মার্চ", "এপ্রিল", "মে", "জুন", "জুলাই", "আগ.", "সেপ্টে.", "অক্টো.", "নভে.", "ডিসে.", ""],
			["রবিবার", "সোমবার", "মঙ্গলবার", "বুধবার", "বৃহস্পতিবার", "শুক্রবার", "শনিবার"],
			["রবি.", "সোম.", "মঙ্গল.", "বুধ.", "বৃহস্পতি.", "শুক্র.", "শনি."],
			["র", "স", "ম", "ব", "ব", "শ", "শ"],
			"পুর্বাহ্ন",
			"অপরাহ্ন",
			"-",
			".",
			1,
			"%B, %Y",
			"%B %d",
			"%d %B %Y",
			"%d-%m-%y",
			"%a, %d %b %Y %H:%M:%S GMT",
			"%d %B %Y %H.%M.%S",
			"%Y-%m-%d %H:%M:%SZ",
			"%Y-%m-%dT%H:%M:%S",
			"%H.%M.%S",
			"%H.%M.%S");
		symbolNaN = "NaN";
		symbolPercent = "%";
		symbolPermille = "‰";
		signNeg = "-";
		signPos = "+";
		symbolNegInf = "-Infinity";
		symbolPosInf = "Infinity";
		digits = ["০", "১", "২", "৩", "৪", "৫", "৬", "৭", "৮", "৯"];
		currency = new thx.culture.core.NumberInfo(2, ".", [3, 2], ",", "$ -n", "$ n");
		englishCurrency = "Indian Rupee";
		nativeCurrency = "টাকা";
		currencySymbol = "টা";
		currencyIso = "INR";
		englishRegion = "India";
		nativeRegion = "ভারত";
		iso2 = "IN";
		iso3 = "IND";
		isMetric = false;
		Culture.add(this);
	}
	@:isVar public static var culture(get, null) : Culture; static function get_culture() { if(null == culture) culture = new BnIN(); return culture; }
}