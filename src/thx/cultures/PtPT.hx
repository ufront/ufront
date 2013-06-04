package thx.cultures;

import thx.culture.Culture;

class PtPT extends Culture {
	function new() {
		language = thx.languages.Pt.language;
		name = "pt-PT";
		english = "Portuguese (Portugal)";
		native = "português (Portugal)";
		date = new thx.culture.core.DateTimeInfo(
			["Janeiro", "Fevereiro", "Março", "Abril", "Maio", "Junho", "Julho", "Agosto", "Setembro", "Outubro", "Novembro", "Dezembro", ""],
			["Jan", "Fev", "Mar", "Abr", "Mai", "Jun", "Jul", "Ago", "Set", "Out", "Nov", "Dez", ""],
			["domingo", "segunda-feira", "terça-feira", "quarta-feira", "quinta-feira", "sexta-feira", "sábado"],
			["dom", "seg", "ter", "qua", "qui", "sex", "sáb"],
			["dom", "seg", "ter", "qua", "qui", "sex", "sáb"],
			null,
			null,
			"-",
			":",
			1,
			"%B de %Y",
			"%e/%f",
			"%A, %e de %B de %Y",
			"%d-%m-%Y",
			"%a, %d %b %Y %H:%M:%S GMT",
			"%A, %e de %B de %Y %H:%M:%S",
			"%Y-%m-%d %H:%M:%SZ",
			"%Y-%m-%dT%H:%M:%S",
			"%H:%M:%S",
			"%k:%M");
		symbolNaN = "NaN (Não é um número)";
		symbolPercent = "%";
		symbolPermille = "‰";
		signNeg = "-";
		signPos = "+";
		symbolNegInf = "-Infinito";
		symbolPosInf = "+Infinito";
		number = new thx.culture.core.NumberInfo(2, ",", [3], ".", "-n", "n");
		currency = new thx.culture.core.NumberInfo(2, ",", [3], ".", "-n $", "n $");
		percent = new thx.culture.core.NumberInfo(2, ",", [3], ".", "-n%", "n%");
		pluralRule = 1;
		englishCurrency = "Euro";
		nativeCurrency = "euro";
		currencySymbol = "€";
		currencyIso = "EUR";
		englishRegion = "Portugal";
		nativeRegion = "Portugal";
		iso2 = "PT";
		iso3 = "PRT";
		isMetric = false;
		Culture.add(this);
	}
	@:isVar public static var culture(get, null) : Culture; static function get_culture() { if(null == culture) culture = new PtPT(); return culture; }
	static function __init__() { get_culture(); }
}