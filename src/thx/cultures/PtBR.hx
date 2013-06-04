package thx.cultures;

import thx.culture.Culture;

class PtBR extends Culture {
	function new() {
		language = thx.languages.Pt.language;
		name = "pt-BR";
		english = "Portuguese (Brazil)";
		native = "Português (Brasil)";
		date = new thx.culture.core.DateTimeInfo(
			["janeiro", "fevereiro", "março", "abril", "maio", "junho", "julho", "agosto", "setembro", "outubro", "novembro", "dezembro", ""],
			["jan", "fev", "mar", "abr", "mai", "jun", "jul", "ago", "set", "out", "nov", "dez", ""],
			["domingo", "segunda-feira", "terça-feira", "quarta-feira", "quinta-feira", "sexta-feira", "sábado"],
			["dom", "seg", "ter", "qua", "qui", "sex", "sáb"],
			["dom", "seg", "ter", "qua", "qui", "sex", "sáb"],
			null,
			null,
			"/",
			":",
			0,
			"%B de %Y",
			"%d de %B",
			"%A, %e de %B de %Y",
			"%e/%f/%Y",
			"%a, %d %b %Y %H:%M:%S GMT",
			"%A, %e de %B de %Y %k:%M:%S",
			"%Y-%m-%d %H:%M:%SZ",
			"%Y-%m-%dT%H:%M:%S",
			"%k:%M:%S",
			"%k:%M");
		symbolNaN = "NaN (Não é um número)";
		symbolPercent = "%";
		symbolPermille = "‰";
		signNeg = "-";
		signPos = "+";
		symbolNegInf = "-Infinito";
		symbolPosInf = "+Infinito";
		number = new thx.culture.core.NumberInfo(2, ",", [3], ".", "-n", "n");
		currency = new thx.culture.core.NumberInfo(2, ",", [3], ".", "-$ n", "$ n");
		percent = new thx.culture.core.NumberInfo(2, ",", [3], ".", "-n%", "n%");
		pluralRule = 2;
		englishCurrency = "Real";
		nativeCurrency = "Real";
		currencySymbol = "R$";
		currencyIso = "BRL";
		englishRegion = "Brazil";
		nativeRegion = "Brasil";
		iso2 = "BR";
		iso3 = "BRA";
		isMetric = false;
		Culture.add(this);
	}
	@:isVar public static var culture(get, null) : Culture; static function get_culture() { if(null == culture) culture = new PtBR(); return culture; }
	static function __init__() { get_culture(); }
}