package thx.cultures;

import thx.culture.Culture;

class MnMongCN extends Culture {
	function new() {
		name = "mn-Mong-CN";
		english = "Mongolian (Traditional Mongolian) (People's Republic of China)";
		native = "ᠮᠤᠨᠭᠭᠤᠯ ᠬᠡᠯᠡ (ᠪᠦᠭᠦᠳᠡ ᠨᠠᠢᠷᠠᠮᠳᠠᠬᠤ ᠳᠤᠮᠳᠠᠳᠤ ᠠᠷᠠᠳ ᠣᠯᠣᠰ)";
		date = new thx.culture.core.DateTimeInfo(
			["ᠨᠢᠭᠡᠳᠦᠭᠡᠷ ᠰᠠᠷ᠎ᠠ", "ᠬᠤᠶ᠋ᠠᠳᠤᠭᠠᠷ ᠰᠠᠷ᠎ᠠ", "ᠭᠤᠷᠪᠠᠳᠤᠭᠠᠷ ᠰᠠᠷ᠎ᠠ", "ᠲᠦᠷᠪᠡᠳᠦᠭᠡᠷ ᠰᠠᠷ᠎ᠠ", "ᠲᠠᠪᠤᠳᠤᠭᠠᠷ ᠰᠠᠷ᠎ᠠ", "ᠵᠢᠷᠭᠤᠳᠤᠭᠠᠷ ᠰᠠᠷ᠎ᠠ", "ᠲᠤᠯᠤᠳᠤᠭᠠᠷ ᠰᠠᠷ᠎ᠠ", "ᠨᠠᠢᠮᠠᠳᠤᠭᠠᠷ ᠰᠠᠷ᠎ᠠ", "ᠶᠢᠰᠦᠳᠦᠭᠡᠷ ᠰᠠᠷ᠎ᠠ", "ᠠᠷᠪᠠᠳᠤᠭᠠᠷ ᠰᠠᠷ᠎ᠠ", "ᠠᠷᠪᠠᠨ ᠨᠢᠭᠡᠳᠦᠭᠡᠷ ᠰᠠᠷ᠎ᠠ", "ᠠᠷᠪᠠᠨ ᠬᠤᠶ᠋ᠠᠳᠤᠭᠠᠷ ᠰᠠᠷ᠎ᠠ", ""],
			["ᠨᠢᠭᠡᠳᠦᠭᠡᠷ ᠰᠠᠷ᠎ᠠ", "ᠬᠤᠶ᠋ᠠᠳᠤᠭᠠᠷ ᠰᠠᠷ᠎ᠠ", "ᠭᠤᠷᠪᠠᠳᠤᠭᠠᠷ ᠰᠠᠷ᠎ᠠ", "ᠲᠦᠷᠪᠡᠳᠦᠭᠡᠷ ᠰᠠᠷ᠎ᠠ", "ᠲᠠᠪᠤᠳᠤᠭᠠᠷ ᠰᠠᠷ᠎ᠠ", "ᠵᠢᠷᠭᠤᠳᠤᠭᠠᠷ ᠰᠠᠷ᠎ᠠ", "ᠲᠤᠯᠤᠳᠤᠭᠠᠷ ᠰᠠᠷ᠎ᠠ", "ᠨᠠᠢᠮᠠᠳᠤᠭᠠᠷ ᠰᠠᠷ᠎ᠠ", "ᠶᠢᠰᠦᠳᠦᠭᠡᠷ ᠰᠠᠷ᠎ᠠ", "ᠠᠷᠪᠠᠳᠤᠭᠠᠷ ᠰᠠᠷ᠎ᠠ", "ᠠᠷᠪᠠᠨ ᠨᠢᠭᠡᠳᠦᠭᠡᠷ ᠰᠠᠷ᠎ᠠ", "ᠠᠷᠪᠠᠨ ᠬᠤᠶ᠋ᠠᠳᠤᠭᠠᠷ ᠰᠠᠷ᠎ᠠ", ""],
			["ᠭᠠᠷᠠᠭ ᠤᠨ ᠡᠳᠦᠷ", "ᠭᠠᠷᠠᠭ ᠤᠨ ᠨᠢᠭᠡᠨ", "ᠭᠠᠷᠠᠭ ᠤᠨ ᠬᠣᠶᠠᠷ", "ᠭᠠᠷᠠᠭ ᠤᠨ ᠭᠤᠷᠪᠠᠨ", "ᠭᠠᠷᠠᠭ ᠤᠨ ᠳᠥᠷᠪᠡᠨ", "ᠭᠠᠷᠠᠭ ᠤᠨ ᠲᠠᠪᠤᠨ", "ᠭᠠᠷᠠᠭ ᠤᠨ ᠵᠢᠷᠭᠤᠭᠠᠨ"],
			["ᠭᠠᠷᠠᠭ ᠤᠨ ᠡᠳᠦᠷ", "ᠭᠠᠷᠠᠭ ᠤᠨ ᠨᠢᠭᠡᠨ", "ᠭᠠᠷᠠᠭ ᠤᠨ ᠬᠣᠶᠠᠷ", "ᠭᠠᠷᠠᠭ ᠤᠨ ᠭᠤᠷᠪᠠᠨ", "ᠭᠠᠷᠠᠭ ᠤᠨ ᠳᠥᠷᠪᠡᠨ", "ᠭᠠᠷᠠᠭ ᠤᠨ ᠲᠠᠪᠤᠨ", "ᠭᠠᠷᠠᠭ ᠤᠨ ᠵᠢᠷᠭᠤᠭᠠᠨ"],
			["ᠡ‍", "ᠨᠢ‍", "ᠬᠣ‍", "ᠭᠤ‍", "ᠳᠥ‍", "ᠲᠠ‍", "ᠵᠢ‍"],
			null,
			null,
			"/",
			":",
			1,
			"%Yᠣᠨ %fᠰᠠᠷ᠎ᠠ",
			"%B %d",
			"%Yᠣᠨ ᠤ᠋ %fᠰᠠᠷ᠎ᠠ  ᠢᠢᠨ %e ᠤ᠋ ᠡᠳᠦᠷ",
			"%Y/%f/%e",
			"%a, %d %b %Y %H:%M:%S GMT",
			"%Yᠣᠨ ᠤ᠋ %fᠰᠠᠷ᠎ᠠ  ᠢᠢᠨ %e ᠤ᠋ ᠡᠳᠦᠷ %k:%M:%S",
			"%Y-%m-%d %H:%M:%SZ",
			"%Y-%m-%dT%H:%M:%S",
			"%k:%M:%S",
			"%k:%M:%S");
		symbolNaN = "ᠲᠤᠭᠠᠠ ᠪᠤᠰᠤ";
		symbolPercent = "%";
		symbolPermille = "‰";
		signNeg = "-";
		signPos = "+";
		symbolNegInf = "ᠰᠦᠬᠡᠷᠬᠦ ᠬᠢᠵᠠᠭᠠᠷᠭᠦᠢ ᠶᠡᠬᠡ";
		symbolPosInf = "ᠡᠶ᠋ᠡᠷᠬᠦ ᠬᠢᠵᠠᠭᠠᠷᠭᠦᠢ ᠶᠠᠬᠡ";
		currency = new thx.culture.core.NumberInfo(2, ".", [3, 0], ",", "$-n", "$n");
		englishCurrency = "PRC Renminbi";
		nativeCurrency = "ᠠᠷᠠᠳ  ᠤᠨ ᠵᠤᠭᠤᠰ";
		currencySymbol = "¥";
		currencyIso = "CNY";
		englishRegion = "People's Republic of China";
		nativeRegion = "ᠪᠦᠭᠦᠳᠡ ᠨᠠᠢᠷᠠᠮᠳᠠᠬᠤ ᠳᠤᠮᠳᠠᠳᠤ ᠠᠷᠠᠳ ᠣᠯᠣᠰ";
		iso2 = "CN";
		iso3 = "CHN";
		isMetric = false;
		Culture.add(this);
	}
	@:isVar public static var culture(get, null) : Culture; static function get_culture() { if(null == culture) culture = new MnMongCN(); return culture; }
}