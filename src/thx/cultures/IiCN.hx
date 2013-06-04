package thx.cultures;

import thx.culture.Culture;

class IiCN extends Culture {
	function new() {
		name = "ii-CN";
		english = "Yi (People's Republic of China)";
		native = "ꆈꌠꁱꂷ (ꍏꉸꏓꂱꇭꉼꇩ)";
		date = new thx.culture.core.DateTimeInfo(
			["ꋍꆪ", "ꑍꆪ", "ꌕꆪ", "ꇖꆪ", "ꉬꆪ", "ꃘꆪ", "ꏃꆪ", "ꉆꆪ", "ꈬꆪ", "ꊰꆪ", "ꊯꊪꆪ", "ꊰꑋꆪ", ""],
			["ꋍꆪ", "ꑍꆪ", "ꌕꆪ", "ꇖꆪ", "ꉬꆪ", "ꃘꆪ", "ꏃꆪ", "ꉆꆪ", "ꈬꆪ", "ꊰꆪ", "ꊯꊪꆪ", "ꊰꑋꆪ", ""],
			["ꑭꆏꑍ", "ꆏꊂ꒔", "ꆏꊂꑍ", "ꆏꊂꌕ", "ꆏꊂꇖ", "ꆏꊂꉬ", "ꆏꊂꃘ"],
			["ꑭꆏ", "ꆏ꒔", "ꆏꑍ", "ꆏꌕ", "ꆏꇖ", "ꆏꉬ", "ꆏꃘ"],
			["ꆏ", "꒔", "ꑍ", "ꌕ", "ꇖ", "ꉬ", "ꃘ"],
			"ꂵꆪꈌꈐ",
			"ꂵꆪꈌꉈ",
			"/",
			":",
			1,
			"%Yꈎ %fꆪ",
			"%B %d",
			"%Yꈎ %fꆪ %eꑍ",
			"%Y/%f/%e",
			"%a, %d %b %Y %H:%M:%S GMT",
			"%Yꈎ %fꆪ %eꑍ %k:%M:%S",
			"%Y-%m-%d %H:%M:%SZ",
			"%Y-%m-%dT%H:%M:%S",
			"%k:%M:%S",
			"%k:%M:%S");
		symbolNaN = "ꌗꂷꀋꉬ";
		symbolPercent = "%";
		symbolPermille = "‰";
		signNeg = "-";
		signPos = "+";
		symbolNegInf = "ꀄꊭꌐꀋꉆ";
		symbolPosInf = "ꈤꇁꑖꀋꉬ";
		currency = new thx.culture.core.NumberInfo(2, ".", [3], ",", "$-n", "$n");
		englishCurrency = "PRC Renminbi";
		nativeCurrency = "ꎆꃀ";
		currencySymbol = "¥";
		currencyIso = "CNY";
		englishRegion = "People's Republic of China";
		nativeRegion = "ꍏꉸꏓꂱꇭꉼꇩ";
		iso2 = "CN";
		iso3 = "CHN";
		isMetric = false;
		Culture.add(this);
	}
	@:isVar public static var culture(get, null) : Culture; static function get_culture() { if(null == culture) culture = new IiCN(); return culture; }
}