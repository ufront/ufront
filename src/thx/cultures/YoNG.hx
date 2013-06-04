package thx.cultures;

import thx.culture.Culture;

class YoNG extends Culture {
	function new() {
		name = "yo-NG";
		english = "Yoruba (Nigeria)";
		native = "Yoruba (Nigeria)";
		date = new thx.culture.core.DateTimeInfo(
			["Osu kinni", "Osu keji", "Osu keta", "Osu kerin", "Osu karun", "Osu kefa", "Osu keje", "Osu kejo", "Osu kesan", "Osu kewa", "Osu kokanla", "Osu keresi", ""],
			["kin.", "kej.", "ket.", "ker.", "kar.", "kef.", "kej.", "kej.", "kes.", "kew.", "kok.", "ker.", ""],
			["Aiku", "Aje", "Isegun", "Ojo'ru", "Ojo'bo", "Eti", "Abameta"],
			["Aik", "Aje", "Ise", "Ojo", "Ojo", "Eti", "Aba"],
			["A", "A", "I", "O", "O", "E", "A"],
			"Owuro",
			"Ale",
			"/",
			":",
			0,
			"%B, %Y",
			"%B %d",
			"%A, %B %d, %Y",
			"%e/%f/%Y",
			"%a, %d %b %Y %H:%M:%S GMT",
			"%A, %B %d, %Y %l:%M:%S %p",
			"%Y-%m-%d %H:%M:%SZ",
			"%Y-%m-%dT%H:%M:%S",
			"%l:%M:%S %p",
			"%l:%M:%S %p");
		currency = new thx.culture.core.NumberInfo(2, ".", [3], ",", "$-n", "$ n");
		englishCurrency = "Nigerian Naira";
		nativeCurrency = "Naira";
		currencySymbol = "N";
		currencyIso = "NIO";
		englishRegion = "Nigeria";
		nativeRegion = "Nigeria";
		iso2 = "NG";
		iso3 = "NGA";
		isMetric = false;
		Culture.add(this);
	}
	@:isVar public static var culture(get, null) : Culture; static function get_culture() { if(null == culture) culture = new YoNG(); return culture; }
}