package thx.cultures;

import thx.culture.Culture;

class ZhTW extends Culture {
	function new() {
		language = thx.languages.ZhHant.language;
		name = "zh-TW";
		english = "Chinese (Taiwan)";
		native = "中文(台灣)";
		date = new thx.culture.core.DateTimeInfo(
			["一月", "二月", "三月", "四月", "五月", "六月", "七月", "八月", "九月", "十月", "十一月", "十二月", ""],
			["一月", "二月", "三月", "四月", "五月", "六月", "七月", "八月", "九月", "十月", "十一月", "十二月", ""],
			["星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六"],
			["星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六"],
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
			"%Y年%f月%e日 %p %I:%M:%S",
			"%Y-%m-%d %H:%M:%SZ",
			"%Y-%m-%dT%H:%M:%S",
			"%p %I:%M:%S",
			"%p %I:%M");
		symbolNaN = "不是一個數字";
		symbolPercent = "%";
		symbolPermille = "‰";
		signNeg = "-";
		signPos = "+";
		symbolNegInf = "負無窮大";
		symbolPosInf = "正無窮大";
		number = new thx.culture.core.NumberInfo(2, ".", [3], ",", "-n", "n");
		currency = new thx.culture.core.NumberInfo(2, ".", [3], ",", "-$n", "$n");
		percent = new thx.culture.core.NumberInfo(2, ".", [3], ",", "-n%", "n%");
		pluralRule = 1;
		englishCurrency = "New Taiwan Dollar";
		nativeCurrency = "新台幣";
		currencySymbol = "NT$";
		currencyIso = "TWD";
		englishRegion = "Taiwan";
		nativeRegion = "台灣";
		iso2 = "TW";
		iso3 = "TWN";
		isMetric = false;
		Culture.add(this);
	}
	@:isVar public static var culture(get, null) : Culture; static function get_culture() { if(null == culture) culture = new ZhTW(); return culture; }
	static function __init__() { get_culture(); }
}