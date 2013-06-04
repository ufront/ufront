package thx.cultures;

import thx.culture.Culture;

class LoLA extends Culture {
	function new() {
		name = "lo-LA";
		english = "Lao (Lao P.D.R.)";
		native = "ລາວ (ສ.ປ.ປ. ລາວ)";
		date = new thx.culture.core.DateTimeInfo(
			["ມັງກອນ", "ກຸມພາ", "ມີນາ", "ເມສາ", "ພຶດສະພາ", "ມິຖຸນາ", "ກໍລະກົດ", "ສິງຫາ", "ກັນຍາ", "ຕຸລາ", "ພະຈິກ", "ທັນວາ", ""],
			["ມັງກອນ", "ກຸມພາ", "ມີນາ", "ເມສາ", "ພຶດສະພາ", "ມິຖຸນາ", "ກໍລະກົດ", "ສິງຫາ", "ກັນຍາ", "ຕຸລາ", "ພະຈິກ", "ທັນວາ", ""],
			["ວັນອາທິດ", "ວັນຈັນ", "ວັນອັງຄານ", "ວັນພຸດ", "ວັນພະຫັດ", "ວັນສຸກ", "ວັນເສົາ"],
			["ອາທິດ", "ຈັນ", "ອັງຄານ", "ພຸດ", "ພະຫັດ", "ສຸກ", "ເສົາ"],
			["ອ", "ຈ", "ອ", "ພ", "ພ", "ສ", "ເ"],
			"ເຊົ້າ",
			"ແລງ",
			"/",
			":",
			0,
			"%B %Y",
			"%B %d",
			"%d %B %Y",
			"%d/%m/%Y",
			"%a, %d %b %Y %H:%M:%S GMT",
			"%d %B %Y %H:%M:%S",
			"%Y-%m-%d %H:%M:%SZ",
			"%Y-%m-%dT%H:%M:%S",
			"%H:%M:%S",
			"%H:%M:%S");
		symbolNaN = "NaN";
		symbolPercent = "%";
		symbolPermille = "‰";
		signNeg = "-";
		signPos = "+";
		symbolNegInf = "-Infinity";
		symbolPosInf = "Infinity";
		digits = ["໐", "໑", "໒", "໓", "໔", "໕", "໖", "໗", "໘", "໙"];
		number = new thx.culture.core.NumberInfo(2, ".", [3, 0], ",", "(n)", "n");
		currency = new thx.culture.core.NumberInfo(2, ".", [3, 0], ",", "($n)", "n$");
		englishCurrency = "Kip";
		nativeCurrency = "ກີບ";
		currencySymbol = "₭";
		currencyIso = "LAK";
		englishRegion = "Lao P.D.R.";
		nativeRegion = "ສ.ປ.ປ. ລາວ";
		iso2 = "LA";
		iso3 = "LAO";
		isMetric = false;
		Culture.add(this);
	}
	@:isVar public static var culture(get, null) : Culture; static function get_culture() { if(null == culture) culture = new LoLA(); return culture; }
}