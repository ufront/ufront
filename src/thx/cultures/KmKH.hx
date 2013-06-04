package thx.cultures;

import thx.culture.Culture;

class KmKH extends Culture {
	function new() {
		name = "km-KH";
		english = "Khmer (Cambodia)";
		native = "ខ្មែរ (កម្ពុជា)";
		date = new thx.culture.core.DateTimeInfo(
			["មករា", "កុម្ភៈ", "មិនា", "មេសា", "ឧសភា", "មិថុនា", "កក្កដា", "សីហា", "កញ្ញា", "តុលា", "វិច្ឆិកា", "ធ្នូ", ""],
			["១", "២", "៣", "៤", "៥", "៦", "៧", "៨", "៩", "១០", "១១", "១២", ""],
			["ថ្ងៃអាទិត្យ", "ថ្ងៃច័ន្ទ", "ថ្ងៃអង្គារ", "ថ្ងៃពុធ", "ថ្ងៃព្រហស្បតិ៍", "ថ្ងៃសុក្រ", "ថ្ងៃសៅរ៍"],
			["អាទិ.", "ច.", "អ.", "ពុ", "ព្រហ.", "សុ.", "ស."],
			["អា", "ច", "អ", "ពុ", "ព្", "សុ", "ស"],
			"ព្រឹក",
			"ល្ងាច",
			"-",
			":",
			0,
			"ខែ %m ឆ្នាំ %Y",
			"%B %d",
			"%e %B %Y",
			"%Y-%m-%d",
			"%a, %d %b %Y %H:%M:%S GMT",
			"%e %B %Y %H:%M:%S",
			"%Y-%m-%d %H:%M:%SZ",
			"%Y-%m-%dT%H:%M:%S",
			"%H:%M:%S",
			"%H:%M:%S");
		symbolNaN = "NAN";
		symbolPercent = "%";
		symbolPermille = "‰";
		signNeg = "-";
		signPos = "+";
		symbolNegInf = "-- អនន្ត";
		symbolPosInf = "អនន្ត";
		digits = ["០", "១", "២", "៣", "៤", "៥", "៦", "៧", "៨", "៩"];
		number = new thx.culture.core.NumberInfo(2, ".", [3, 0], ",", "- n", "n");
		currency = new thx.culture.core.NumberInfo(2, ".", [3], ",", "-n$", "n$");
		englishCurrency = "Riel";
		nativeCurrency = "x179Aៀល";
		currencySymbol = "៛";
		currencyIso = "KHR";
		englishRegion = "Cambodia";
		nativeRegion = "កម្ពុជា";
		iso2 = "KH";
		iso3 = "KHM";
		isMetric = false;
		Culture.add(this);
	}
	@:isVar public static var culture(get, null) : Culture; static function get_culture() { if(null == culture) culture = new KmKH(); return culture; }
}