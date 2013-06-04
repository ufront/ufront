package thx.cultures;

import thx.culture.Culture;

class EsAR extends Culture {
	function new() {
		language = thx.languages.Es.language;
		name = "es-AR";
		english = "Spanish (Argentina)";
		native = "Español (Argentina)";
		date = new thx.culture.core.DateTimeInfo(
			["enero", "febrero", "marzo", "abril", "mayo", "junio", "julio", "agosto", "septiembre", "octubre", "noviembre", "diciembre", ""],
			["ene", "feb", "mar", "abr", "may", "jun", "jul", "ago", "sep", "oct", "nov", "dic", ""],
			["domingo", "lunes", "martes", "miércoles", "jueves", "viernes", "sábado"],
			["dom", "lun", "mar", "mié", "jue", "vie", "sáb"],
			["do", "lu", "ma", "mi", "ju", "vi", "sá"],
			"a.m.",
			"p.m.",
			"/",
			":",
			0,
			"%B de %Y",
			"%d %B",
			"%A, %d de %B de %Y",
			"%d/%m/%Y",
			"%a, %d %b %Y %H:%M:%S GMT",
			"%A, %d de %B de %Y %I:%M:%S %p",
			"%Y-%m-%d %H:%M:%SZ",
			"%Y-%m-%dT%H:%M:%S",
			"%I:%M:%S %p",
			"%I:%M %p");
		symbolNaN = "NeuN";
		symbolPercent = "%";
		symbolPermille = "‰";
		signNeg = "-";
		signPos = "+";
		symbolNegInf = "-Infinito";
		symbolPosInf = "Infinito";
		number = new thx.culture.core.NumberInfo(2, ",", [3], ".", "-n", "n");
		currency = new thx.culture.core.NumberInfo(2, ",", [3], ".", "$-n", "$ n");
		percent = new thx.culture.core.NumberInfo(2, ",", [3], ".", "-n %", "n %");
		pluralRule = 1;
		englishCurrency = "Argentine Peso";
		nativeCurrency = "Peso";
		currencySymbol = "$";
		currencyIso = "ARS";
		englishRegion = "Argentina";
		nativeRegion = "Argentina";
		iso2 = "AR";
		iso3 = "ARG";
		isMetric = false;
		Culture.add(this);
	}
	@:isVar public static var culture(get, null) : Culture; static function get_culture() { if(null == culture) culture = new EsAR(); return culture; }
	static function __init__() { get_culture(); }
}