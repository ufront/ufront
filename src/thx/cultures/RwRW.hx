package thx.cultures;

import thx.culture.Culture;

class RwRW extends Culture {
	function new() {
		name = "rw-RW";
		english = "Kinyarwanda (Rwanda)";
		native = "Kinyarwanda (Rwanda)";
		date = new thx.culture.core.DateTimeInfo(
			["Mutarama", "Gashyantare", "Werurwe", "Mata", "Gicurasi", "Kamena", "Nyakanga", "Kanama", "Nzeli", "Ukwakira", "Ugushyingo", "Ukuboza", ""],
			["Mut", "Gas", "Wer", "Mat", "Gic", "Kam", "Nya", "Kan", "Nze", "Ukwa", "Ugu", "Uku", ""],
			["Ku wa mbere", "Ku wa kabiri", "Ku wa gatatu", "Ku wa kane", "Ku wa gatanu", "Ku wa gatandatu", "Ku cyumweru"],
			["mbe.", "kab.", "gat.", "kan.", "gat.", "gat.", "cyu."],
			["mb", "ka", "ga", "ka", "ga", "ga", "cy"],
			"saa moya z.m.",
			"saa moya z.n.",
			"/",
			":",
			0,
			"%B, %Y",
			"%B %d",
			"%A, %B %d, %Y",
			"%f/%e/%Y",
			"%a, %d %b %Y %H:%M:%S GMT",
			"%A, %B %d, %Y %l:%M:%S %p",
			"%Y-%m-%d %H:%M:%SZ",
			"%Y-%m-%dT%H:%M:%S",
			"%l:%M:%S %p",
			"%l:%M:%S %p");
		number = new thx.culture.core.NumberInfo(2, ",", [3], " ", "-n", "n");
		currency = new thx.culture.core.NumberInfo(2, ",", [3], " ", "$-n", "$ n");
		percent = new thx.culture.core.NumberInfo(2, ",", [3], " ", "-n %", "n %");
		englishCurrency = "Rwandan Franc";
		nativeCurrency = "Ifaranga";
		currencySymbol = "RWF";
		currencyIso = "RWF";
		englishRegion = "Rwanda";
		nativeRegion = "Rwanda";
		iso2 = "RW";
		iso3 = "RWA";
		isMetric = false;
		Culture.add(this);
	}
	@:isVar public static var culture(get, null) : Culture; static function get_culture() { if(null == culture) culture = new RwRW(); return culture; }
}