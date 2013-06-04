package thx.cultures;

import thx.culture.Culture;

class UgCN extends Culture {
	function new() {
		name = "ug-CN";
		english = "Uyghur (People's Republic of China)";
		native = "ئۇيغۇرچە (جۇڭخۇا خەلق جۇمھۇرىيىتى)";
		date = new thx.culture.core.DateTimeInfo(
			["1-ئاي", "2-ئاي", "3-ئاي", "4-ئاي", "5-ئاي", "6-ئاي", "7-ئاي", "8-ئاي", "9-ئاي", "10-ئاي", "11-ئاي", "12-ئاي", ""],
			["1-ئاي", "2-ئاي", "3-ئاي", "4-ئاي", "5-ئاي", "6-ئاي", "7-ئاي", "8-ئاي", "9-ئاي", "10-ئاي", "11-ئاي", "12-ئاي", ""],
			["يەكشەنبە", "دۈشەنبە", "سەيشەنبە", "چارشەنبە", "پەيشەنبە", "جۈمە", "شەنبە"],
			["يە", "دۈ", "سە", "چا", "پە", "جۈ", "شە"],
			["ي", "د", "س", "چ", "پ", "ج", "ش"],
			"چۈشتىن بۇرۇن",
			"چۈشتىن كېيىن",
			"-",
			":",
			0,
			"%Y-يىلى %B",
			"%B %d",
			"%Y-يىلى %B %e-كۈنى،",
			"%Y-%f-%e",
			"%a, %d %b %Y %H:%M:%S GMT",
			"%Y-يىلى %B %e-كۈنى، %k:%M:%S",
			"%Y-%m-%d %H:%M:%SZ",
			"%Y-%m-%dT%H:%M:%S",
			"%k:%M:%S",
			"%k:%M:%S");
		symbolNaN = "سان ئەمەس";
		symbolPercent = "%";
		symbolPermille = "‰";
		signNeg = "-";
		signPos = "+";
		symbolNegInf = "مەنپىي چەكسىزلىك";
		symbolPosInf = "مۇسبەت چەكسىزلىك";
		currency = new thx.culture.core.NumberInfo(2, ".", [3], ",", "$-n", "$n");
		englishCurrency = "PRC Renminbi";
		nativeCurrency = "خەلق پۇلى";
		currencySymbol = "¥";
		currencyIso = "CNY";
		englishRegion = "People's Republic of China";
		nativeRegion = "جۇڭخۇا خەلق جۇمھۇرىيىتى";
		iso2 = "CN";
		iso3 = "CHN";
		isMetric = false;
		Culture.add(this);
	}
	@:isVar public static var culture(get, null) : Culture; static function get_culture() { if(null == culture) culture = new UgCN(); return culture; }
}