package thx.cultures;

import thx.culture.Culture;

class SqAL extends Culture {
	function new() {
		language = thx.languages.Sq.language;
		name = "sq-AL";
		english = "Albanian (Albania)";
		native = "shqipe (Shqipëria)";
		date = new thx.culture.core.DateTimeInfo(
			["janar", "shkurt", "mars", "prill", "maj", "qershor", "korrik", "gusht", "shtator", "tetor", "nëntor", "dhjetor", ""],
			["Jan", "Shk", "Mar", "Pri", "Maj", "Qer", "Kor", "Gsh", "Sht", "Tet", "Nën", "Dhj", ""],
			["e diel", "e hënë", "e martë", "e mërkurë", "e enjte", "e premte", "e shtunë"],
			["Die", "Hën", "Mar", "Mër", "Enj", "Pre", "Sht"],
			["Di", "Hë", "Ma", "Më", "En", "Pr", "Sh"],
			"PD",
			"MD",
			"-",
			":",
			1,
			"%Y-%m",
			"%B %d",
			"%Y-%m-%d",
			"%Y-%m-%d",
			"%a, %d %b %Y %H:%M:%S GMT",
			"%Y-%m-%d %l:%M:%S.%p",
			"%Y-%m-%d %H:%M:%SZ",
			"%Y-%m-%dT%H:%M:%S",
			"%l:%M:%S.%p",
			"%l:%M.%p");
		symbolNaN = "NaN";
		symbolPercent = "%";
		symbolPermille = "‰";
		signNeg = "-";
		signPos = "+";
		symbolNegInf = "-Infinity";
		symbolPosInf = "Infinity";
		number = new thx.culture.core.NumberInfo(2, ",", [3], ".", "-n", "n");
		currency = new thx.culture.core.NumberInfo(2, ",", [3], ".", "-n$", "n$");
		percent = new thx.culture.core.NumberInfo(2, ",", [3], ".", "-n %", "n %");
		pluralRule = 1;
		englishCurrency = "Albanian Lek";
		nativeCurrency = "Lek";
		currencySymbol = "Lek";
		currencyIso = "ALL";
		englishRegion = "Albania";
		nativeRegion = "Shqipëria";
		iso2 = "AL";
		iso3 = "ALB";
		isMetric = false;
		Culture.add(this);
	}
	@:isVar public static var culture(get, null) : Culture; static function get_culture() { if(null == culture) culture = new SqAL(); return culture; }
	static function __init__() { get_culture(); }
}