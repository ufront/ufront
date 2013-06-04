package thx.cultures;

import thx.culture.Culture;

class IgNG extends Culture {
	function new() {
		name = "ig-NG";
		english = "Igbo (Nigeria)";
		native = "Igbo (Nigeria)";
		date = new thx.culture.core.DateTimeInfo(
			["Onwa mbu", "Onwa ibua", "Onwa ato", "Onwa ano", "Onwa ise", "Onwa isi", "Onwa asa", "Onwa asato", "Onwa itolu", "Onwa iri", "Onwa iri n'ofu", "Onwa iri n'ibua", ""],
			["mbu.", "ibu.", "ato.", "ano.", "ise", "isi", "asa", "asa.", "ito.", "iri.", "n'of.", "n'ib.", ""],
			["Aiku", "Aje", "Isegun", "Ojo'ru", "Ojo'bo", "Eti", "Abameta"],
			["Aik", "Aje", "Ise", "Ojo", "Ojo", "Eti", "Aba"],
			["A", "A", "I", "O", "O", "E", "A"],
			"Ututu",
			"Efifie",
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
	@:isVar public static var culture(get, null) : Culture; static function get_culture() { if(null == culture) culture = new IgNG(); return culture; }
}