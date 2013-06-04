package thx.cultures;

import thx.culture.Culture;

class MlIN extends Culture {
	function new() {
		name = "ml-IN";
		english = "Malayalam (India)";
		native = "മലയാളം (ഭാരതം)";
		date = new thx.culture.core.DateTimeInfo(
			["ജനുവരി", "ഫെബ്റുവരി", "മാറ്ച്ച്", "ഏപ്റില്", "മെയ്", "ജൂണ്", "ജൂലൈ", "ഓഗസ്ററ്", "സെപ്ററംബറ്", "ഒക്ടോബറ്", "നവംബറ്", "ഡിസംബറ്", ""],
			["ജനുവരി", "ഫെബ്റുവരി", "മാറ്ച്ച്", "ഏപ്റില്", "മെയ്", "ജൂണ്", "ജൂലൈ", "ഓഗസ്ററ്", "സെപ്ററംബറ്", "ഒക്ടോബറ്", "നവംബറ്", "ഡിസംബറ്", ""],
			["ഞായറാഴ്ച", "തിങ്കളാഴ്ച", "ചൊവ്വാഴ്ച", "ബുധനാഴ്ച", "വ്യാഴാഴ്ച", "വെള്ളിയാഴ്ച", "ശനിയാഴ്ച"],
			["ഞായർ.", "തിങ്കൾ.", "ചൊവ്വ.", "ബുധൻ.", "വ്യാഴം.", "വെള്ളി.", "ശനി."],
			["ഞ", "ത", "ച", "ബ", "വ", "വെ", "ശ"],
			"AM",
			"PM",
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
		digits = ["൦", "൧", "൨", "൩", "൪", "൫", "൬", "൭", "൮", "൯"];
		currency = new thx.culture.core.NumberInfo(2, ".", [3, 2], ",", "$ -n", "$ n");
		englishCurrency = "Indian Rupee";
		nativeCurrency = "രൂപ";
		currencySymbol = "ക";
		currencyIso = "INR";
		englishRegion = "India";
		nativeRegion = "ഭാരതം";
		iso2 = "IN";
		iso3 = "IND";
		isMetric = false;
		Culture.add(this);
	}
	@:isVar public static var culture(get, null) : Culture; static function get_culture() { if(null == culture) culture = new MlIN(); return culture; }
}