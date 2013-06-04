package thx.cultures;

import thx.culture.Culture;

class TkTM extends Culture {
	function new() {
		name = "tk-TM";
		english = "Turkmen (Turkmenistan)";
		native = "türkmençe (Türkmenistan)";
		date = new thx.culture.core.DateTimeInfo(
			["Ýanwar", "Fewral", "Mart", "Aprel", "Maý", "lýun", "lýul", "Awgust", "Sentýabr", "Oktýabr", "Noýabr", "Dekabr", ""],
			["Ýan", "Few", "Mart", "Apr", "Maý", "lýun", "lýul", "Awg", "Sen", "Okt", "Not", "Dek", ""],
			["Duşenbe", "Sişenbe", "Çarşenbe", "Penşenbe", "Anna", "Şenbe", "Ýekşenbe"],
			["Db", "Sb", "Çb", "Pb", "An", "Şb", "Ýb"],
			["D", "S", "Ç", "P", "A", "Ş", "Ý"],
			null,
			null,
			".",
			":",
			1,
			"%Y ý. %B",
			"%B %d",
			"%Y ý. %B %e",
			"%d.%m.%y",
			"%a, %d %b %Y %H:%M:%S GMT",
			"%Y ý. %B %e %k:%M:%S",
			"%Y-%m-%d %H:%M:%SZ",
			"%Y-%m-%dT%H:%M:%S",
			"%k:%M:%S",
			"%k:%M:%S");
		symbolNaN = "NaN";
		symbolPercent = "%";
		symbolPermille = "‰";
		signNeg = "-";
		signPos = "+";
		symbolNegInf = "-üznüksizlik";
		symbolPosInf = "üznüksizlik";
		number = new thx.culture.core.NumberInfo(2, ",", [3], " ", "-n", "n");
		currency = new thx.culture.core.NumberInfo(2, ",", [3], " ", "-n$", "n$");
		percent = new thx.culture.core.NumberInfo(2, ",", [3], " ", "-n %", "n %");
		englishCurrency = "Turkmen manat";
		nativeCurrency = "manat";
		currencySymbol = "m.";
		currencyIso = "TMT";
		englishRegion = "Turkmenistan";
		nativeRegion = "Türkmenistan";
		iso2 = "TM";
		iso3 = "TKM";
		isMetric = false;
		Culture.add(this);
	}
	@:isVar public static var culture(get, null) : Culture; static function get_culture() { if(null == culture) culture = new TkTM(); return culture; }
}