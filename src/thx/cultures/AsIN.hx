package thx.cultures;

import thx.culture.Culture;

class AsIN extends Culture {
	function new() {
		name = "as-IN";
		english = "Assamese (India)";
		native = "অসমীয়া (ভাৰত)";
		date = new thx.culture.core.DateTimeInfo(
			["জানুৱাৰী", "ফেব্রুৱাৰী", "মার্চ", "এপ্রিল", "মে", "জুন", "জুলাই", "আগষ্ট", "চেপ্টেম্বর", "অক্টোবর", "নবেম্বর", "ডিচেম্বর", ""],
			["জানু", "ফেব্রু", "মার্চ", "এপ্রিল", "মে", "জুন", "জুলাই", "আগষ্ট", "চেপ্টে", "অক্টো", "নবে", "ডিচে", ""],
			["সোমবাৰ", "মঙ্গলবাৰ", "বুধবাৰ", "বৃহস্পতিবাৰ", "শুক্রবাৰ", "শনিবাৰ", "ৰবিবাৰ"],
			["সোম.", "মঙ্গল.", "বুধ.", "বৃহ.", "শুক্র.", "শনি.", "ৰবি."],
			["সো", "ম", "বু", "বৃ", "শু", "শ", "র"],
			"ৰাতিপু",
			"আবেলি",
			"-",
			":",
			1,
			"%B,%y",
			"%B %d",
			"%Y,%B %d, %A",
			"%d-%m-%Y",
			"%a, %d %b %Y %H:%M:%S GMT",
			"%Y,%B %d, %A %p %l:%M:%S",
			"%Y-%m-%d %H:%M:%SZ",
			"%Y-%m-%dT%H:%M:%S",
			"%p %l:%M:%S",
			"%p %l:%M:%S");
		symbolNaN = "nan";
		symbolPercent = "%";
		symbolPermille = "‰";
		signNeg = "-";
		signPos = "+";
		symbolNegInf = "-infinity";
		symbolPosInf = "infinity";
		digits = ["০", "১", "২", "৩", "৪", "৫", "৬", "৭", "৮", "৯"];
		currency = new thx.culture.core.NumberInfo(2, ".", [3, 2], ",", "$ -n", "n$");
		englishCurrency = "Indian Rupee";
		nativeCurrency = "টকা";
		currencySymbol = "ট";
		currencyIso = "INR";
		englishRegion = "India";
		nativeRegion = "ভাৰত";
		iso2 = "IN";
		iso3 = "IND";
		isMetric = false;
		Culture.add(this);
	}
	@:isVar public static var culture(get, null) : Culture; static function get_culture() { if(null == culture) culture = new AsIN(); return culture; }
}