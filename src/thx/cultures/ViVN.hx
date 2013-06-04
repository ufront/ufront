package thx.cultures;

import thx.culture.Culture;

class ViVN extends Culture {
	function new() {
		language = thx.languages.Vi.language;
		name = "vi-VN";
		english = "Vietnamese (Vietnam)";
		native = "Tiếng Việt (Việt Nam)";
		date = new thx.culture.core.DateTimeInfo(
			["Tháng Giêng", "Tháng Hai", "Tháng Ba", "Tháng Tư", "Tháng Năm", "Tháng Sáu", "Tháng Bảy", "Tháng Tám", "Tháng Chín", "Tháng Mười", "Tháng Mười Một", "Tháng Mười Hai", ""],
			["Thg1", "Thg2", "Thg3", "Thg4", "Thg5", "Thg6", "Thg7", "Thg8", "Thg9", "Thg10", "Thg11", "Thg12", ""],
			["Chủ Nhật", "Thứ Hai", "Thứ Ba", "Thứ Tư", "Thứ Năm", "Thứ Sáu", "Thứ Bảy"],
			["CN", "Hai", "Ba", "Tư", "Năm", "Sáu", "Bảy"],
			["C", "H", "B", "T", "N", "S", "B"],
			"SA",
			"CH",
			"/",
			":",
			1,
			"%B %Y",
			"%d %B",
			"%d %B %Y",
			"%d/%m/%Y",
			"%a, %d %b %Y %H:%M:%S GMT",
			"%d %B %Y %l:%M:%S %p",
			"%Y-%m-%d %H:%M:%SZ",
			"%Y-%m-%dT%H:%M:%S",
			"%l:%M:%S %p",
			"%l:%M %p");
		symbolNaN = "NaN";
		symbolPercent = "%";
		symbolPermille = "‰";
		signNeg = "-";
		signPos = "+";
		symbolNegInf = "-Infinity";
		symbolPosInf = "Infinity";
		number = new thx.culture.core.NumberInfo(2, ",", [3], ".", "-n", "n");
		currency = new thx.culture.core.NumberInfo(2, ",", [3], ".", "-n $", "n $");
		percent = new thx.culture.core.NumberInfo(2, ",", [3], ".", "-n %", "n %");
		pluralRule = 0;
		englishCurrency = "Vietnamese Dong";
		nativeCurrency = "Đồng";
		currencySymbol = "₫";
		currencyIso = "VND";
		englishRegion = "Vietnam";
		nativeRegion = "Việt Nam";
		iso2 = "VN";
		iso3 = "VNM";
		isMetric = false;
		Culture.add(this);
	}
	@:isVar public static var culture(get, null) : Culture; static function get_culture() { if(null == culture) culture = new ViVN(); return culture; }
	static function __init__() { get_culture(); }
}