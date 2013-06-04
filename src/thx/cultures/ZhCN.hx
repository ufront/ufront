package thx.cultures;

import thx.culture.Culture;

class ZhCN extends Culture {
	function new() {
		language = thx.languages.ZhHans.language;
		name = "zh-CN";
		english = "Chinese (People's Republic of China)";
		native = "中文(中华人民共和国)";
		date = new thx.culture.core.DateTimeInfo(
			["一月", "二月", "三月", "四月", "五月", "六月", "七月", "八月", "九月", "十月", "十一月", "十二月", ""],
			["一月", "二月", "三月", "四月", "五月", "六月", "七月", "八月", "九月", "十月", "十一月", "十二月", ""],
			["星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六"],
			["日", "一", "二", "三", "四", "五", "六"],
			["日", "一", "二", "三", "四", "五", "六"],
			"上午",
			"下午",
			"/",
			":",
			0,
			"%Y年%f月",
			"%f月%e日",
			"%Y年%f月%e日",
			"%Y/%f/%e",
			"%a, %d %b %Y %H:%M:%S GMT",
			"%Y年%f月%e日 %k:%M:%S",
			"%Y-%m-%d %H:%M:%SZ",
			"%Y-%m-%dT%H:%M:%S",
			"%k:%M:%S",
			"%k:%M");
		symbolNaN = "非数字";
		symbolPercent = "%";
		symbolPermille = "‰";
		signNeg = "-";
		signPos = "+";
		symbolNegInf = "负无穷大";
		symbolPosInf = "正无穷大";
		number = new thx.culture.core.NumberInfo(2, ".", [3], ",", "-n", "n");
		currency = new thx.culture.core.NumberInfo(2, ".", [3], ",", "$-n", "$n");
		percent = new thx.culture.core.NumberInfo(2, ".", [3], ",", "-n%", "n%");
		pluralRule = 1;
		englishCurrency = "PRC Yuan Renminbi";
		nativeCurrency = "人民币";
		currencySymbol = "￥";
		currencyIso = "CNY";
		englishRegion = "People's Republic of China";
		nativeRegion = "中华人民共和国";
		iso2 = "CN";
		iso3 = "CHN";
		isMetric = false;
		Culture.add(this);
	}
	@:isVar public static var culture(get, null) : Culture; static function get_culture() { if(null == culture) culture = new ZhCN(); return culture; }
	static function __init__() { get_culture(); }
}