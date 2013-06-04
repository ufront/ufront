package thx.cultures;

import thx.culture.Culture;

class BoCN extends Culture {
	function new() {
		name = "bo-CN";
		english = "Tibetan (People's Republic of China)";
		native = "བོད་ཡིག (ཀྲུང་ཧྭ་མི་དམངས་སྤྱི་མཐུན་རྒྱལ་ཁབ།)";
		date = new thx.culture.core.DateTimeInfo(
			["སྤྱི་ཟླ་དང་པོ།", "སྤྱི་ཟླ་གཉིས་པ།", "སྤྱི་ཟླ་གསུམ་པ།", "སྤྱི་ཟླ་བཞི་པ།", "སྤྱི་ཟླ་ལྔ་པ།", "སྤྱི་ཟླ་དྲུག་པ།", "སྤྱི་ཟླ་བདུན་པ།", "སྤྱི་ཟླ་བརྒྱད་པ།", "སྤྱི་ཟླ་དགུ་པ།", "སྤྱི་ཟླ་བཅུ་པོ།", "སྤྱི་ཟླ་བཅུ་གཅིག་པ།", "སྤྱི་ཟླ་བཅུ་གཉིས་པ།", ""],
			["ཟླ་ ༡", "ཟླ་ ༢", "ཟླ་ ༣", "ཟླ་ ༤", "ཟླ་ ༥", "ཟླ་ ༦", "ཟླ་ ༧", "ཟླ་ ༨", "ཟླ་ ༩", "ཟླ་ ༡༠", "ཟླ་ ༡༡", "ཟླ་ ༡༢", ""],
			["གཟའ་ཉི་མ།", "གཟའ་ཟླ་བ།", "གཟའ་མིག་དམར།", "གཟའ་ལྷག་པ།", "གཟའ་ཕུར་བུ།", "གཟའ་པ་སངས།", "གཟའ་སྤེན་པ།"],
			["ཉི་མ།", "ཟླ་བ།", "མིག་དམར།", "ལྷག་པ།", "ཕུར་བུ།", "པ་སངས།", "སྤེན་པ།"],
			["༧", "༡", "༢", "༣", "༤", "༥", "༦"],
			"སྔ་དྲོ",
			"ཕྱི་དྲོ",
			"/",
			":",
			1,
			"%Y.%f",
			"%B %d",
			"%Yལོའི་ཟླ %fཚེས %e",
			"%Y/%f/%e",
			"%a, %d %b %Y %H:%M:%S GMT",
			"%Yལོའི་ཟླ %fཚེས %e %H:%M:%S",
			"%Y-%m-%d %H:%M:%SZ",
			"%Y-%m-%dT%H:%M:%S",
			"%H:%M:%S",
			"%H:%M:%S");
		symbolNaN = "ཨང་ཀི་མིན་པ།";
		symbolPercent = "%";
		symbolPermille = "‰";
		signNeg = "-";
		signPos = "+";
		symbolNegInf = "མོ་གྲངས་ཚད་མེད་ཆུང་བ།";
		symbolPosInf = "ཕོ་གྲངས་ཚད་མེད་ཆེ་བ།";
		currency = new thx.culture.core.NumberInfo(2, ".", [3, 0], ",", "$-n", "$n");
		englishCurrency = "PRC Renminbi";
		nativeCurrency = "མི་དམངས་ཤོག་སྒོཪ།";
		currencySymbol = "¥";
		currencyIso = "CNY";
		englishRegion = "People's Republic of China";
		nativeRegion = "ཀྲུང་ཧྭ་མི་དམངས་སྤྱི་མཐུན་རྒྱལ་ཁབ།";
		iso2 = "CN";
		iso3 = "CHN";
		isMetric = false;
		Culture.add(this);
	}
	@:isVar public static var culture(get, null) : Culture; static function get_culture() { if(null == culture) culture = new BoCN(); return culture; }
}