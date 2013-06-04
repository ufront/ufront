package thx.cultures;

import thx.culture.Culture;

class EsUS extends Culture {
	function new() {
		language = thx.languages.Es.language;
		name = "es-US";
		english = "Spanish (United States)";
		native = "Español (Estados Unidos)";
		date = new thx.culture.core.DateTimeInfo(
			["enero", "febrero", "marzo", "abril", "mayo", "junio", "julio", "agosto", "septiembre", "octubre", "noviembre", "diciembre", ""],
			["ene", "feb", "mar", "abr", "may", "jun", "jul", "ago", "sep", "oct", "nov", "dic", ""],
			["domingo", "lunes", "martes", "miércoles", "jueves", "viernes", "sábado"],
			["dom", "lun", "mar", "mié", "jue", "vie", "sáb"],
			["do", "lu", "ma", "mi", "ju", "vi", "sa"],
			"AM",
			"PM",
			"/",
			":",
			0,
			"%B de %Y",
			"%B %d",
			"%A, %B %d, %Y",
			"%f/%e/%Y",
			"%a, %d %b %Y %H:%M:%S GMT",
			"%A, %B %d, %Y %l:%M:%S %p",
			"%Y-%m-%d %H:%M:%SZ",
			"%Y-%m-%dT%H:%M:%S",
			"%l:%M:%S %p",
			"%l:%M:%S %p");
		symbolNaN = "NeuN";
		symbolPercent = "%";
		symbolPermille = "‰";
		signNeg = "-";
		signPos = "+";
		symbolNegInf = "-Infinito";
		symbolPosInf = "Infinito";
		number = new thx.culture.core.NumberInfo(2, ".", [3, 0], ",", "-n", "n");
		currency = new thx.culture.core.NumberInfo(2, ".", [3], ",", "($n)", "$n");
		percent = new thx.culture.core.NumberInfo(2, ".", [3, 0], ",", "-n %", "n %");
		pluralRule = 1;
		englishCurrency = "US Dollar";
		nativeCurrency = "Dólar de EE.UU.";
		currencySymbol = "$";
		currencyIso = "USD";
		englishRegion = "United States";
		nativeRegion = "Estados Unidos";
		iso2 = "US";
		iso3 = "USA";
		isMetric = false;
		Culture.add(this);
	}
	@:isVar public static var culture(get, null) : Culture; static function get_culture() { if(null == culture) culture = new EsUS(); return culture; }
	static function __init__() { get_culture(); }
}