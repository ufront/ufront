package thx.cultures;

import thx.culture.Culture;

class LtLT extends Culture {
	function new() {
		language = thx.languages.Lt.language;
		name = "lt-LT";
		english = "Lithuanian (Lithuania)";
		native = "lietuvių (Lietuva)";
		date = new thx.culture.core.DateTimeInfo(
			["sausis", "vasaris", "kovas", "balandis", "gegužė", "birželis", "liepa", "rugpjūtis", "rugsėjis", "spalis", "lapkritis", "gruodis", ""],
			["Sau", "Vas", "Kov", "Bal", "Geg", "Bir", "Lie", "Rgp", "Rgs", "Spl", "Lap", "Grd", ""],
			["sekmadienis", "pirmadienis", "antradienis", "trečiadienis", "ketvirtadienis", "penktadienis", "šeštadienis"],
			["Sk", "Pr", "An", "Tr", "Kt", "Pn", "Št"],
			["S", "P", "A", "T", "K", "Pn", "Š"],
			null,
			null,
			".",
			":",
			1,
			"%Y m. %B",
			"%B %e d.",
			"%Y m. %B %e d.",
			"%Y.%m.%d",
			"%a, %d %b %Y %H:%M:%S GMT",
			"%Y m. %B %e d. %H:%M:%S",
			"%Y-%m-%d %H:%M:%SZ",
			"%Y-%m-%dT%H:%M:%S",
			"%H:%M:%S",
			"%H:%M");
		symbolNaN = "NaN";
		symbolPercent = "%";
		symbolPermille = "‰";
		signNeg = "-";
		signPos = "+";
		symbolNegInf = "-begalybė";
		symbolPosInf = "begalybė";
		number = new thx.culture.core.NumberInfo(2, ",", [3], ".", "-n", "n");
		currency = new thx.culture.core.NumberInfo(2, ",", [3], ".", "-n $", "n $");
		percent = new thx.culture.core.NumberInfo(2, ",", [3], ".", "-n%", "n%");
		pluralRule = 1;
		englishCurrency = "Lithuanian Litas";
		nativeCurrency = "Litas";
		currencySymbol = "Lt";
		currencyIso = "LTL";
		englishRegion = "Lithuania";
		nativeRegion = "Lietuva";
		iso2 = "LT";
		iso3 = "LTU";
		isMetric = false;
		Culture.add(this);
	}
	@:isVar public static var culture(get, null) : Culture; static function get_culture() { if(null == culture) culture = new LtLT(); return culture; }
	static function __init__() { get_culture(); }
}