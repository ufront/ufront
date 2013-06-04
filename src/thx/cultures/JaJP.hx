package thx.cultures;

import thx.culture.Culture;

class JaJP extends Culture {
	function new() {
		language = thx.languages.Ja.language;
		name = "ja-JP";
		english = "Japanese (Japan)";
		native = "日本語 (日本)";
		date = new thx.culture.core.DateTimeInfo(
			["1月", "2月", "3月", "4月", "5月", "6月", "7月", "8月", "9月", "10月", "11月", "12月", ""],
			["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", ""],
			["日曜日", "月曜日", "火曜日", "水曜日", "木曜日", "金曜日", "土曜日"],
			["日", "月", "火", "水", "木", "金", "土"],
			["日", "月", "火", "水", "木", "金", "土"],
			"午前",
			"午後",
			"/",
			":",
			0,
			"%Y年%f月",
			"%f月%e日",
			"%Y年%f月%e日",
			"%Y/%m/%d",
			"%a, %d %b %Y %H:%M:%S GMT",
			"%Y年%f月%e日 %k:%M:%S",
			"%Y-%m-%d %H:%M:%SZ",
			"%Y-%m-%dT%H:%M:%S",
			"%k:%M:%S",
			"%k:%M");
		symbolNaN = "NaN (非数値)";
		symbolPercent = "%";
		symbolPermille = "‰";
		signNeg = "-";
		signPos = "+";
		symbolNegInf = "-∞";
		symbolPosInf = "+∞";
		number = new thx.culture.core.NumberInfo(2, ".", [3], ",", "-n", "n");
		currency = new thx.culture.core.NumberInfo(0, ".", [3], ",", "-$n", "$n");
		percent = new thx.culture.core.NumberInfo(2, ".", [3], ",", "-n%", "n%");
		pluralRule = 0;
		englishCurrency = "Japanese Yen";
		nativeCurrency = "円";
		currencySymbol = "¥";
		currencyIso = "JPY";
		englishRegion = "Japan";
		nativeRegion = "日本";
		iso2 = "JP";
		iso3 = "JPN";
		isMetric = false;
		Culture.add(this);
	}
	@:isVar public static var culture(get, null) : Culture; static function get_culture() { if(null == culture) culture = new JaJP(); return culture; }
	static function __init__() { get_culture(); }
}