package thx.cultures;

import thx.culture.Culture;

class GuIN extends Culture {
	function new() {
		language = thx.languages.Gu.language;
		name = "gu-IN";
		english = "Gujarati (India)";
		native = "ગુજરાતી (ભારત)";
		date = new thx.culture.core.DateTimeInfo(
			["જાન્યુઆરી", "ફેબ્રુઆરી", "માર્ચ", "એપ્રિલ", "મે", "જૂન", "જુલાઈ", "ઑગસ્ટ", "સપ્ટેમ્બર", "ઑક્ટ્બર", "નવેમ્બર", "ડિસેમ્બર", ""],
			["જાન્યુ", "ફેબ્રુ", "માર્ચ", "એપ્રિલ", "મે", "જૂન", "જુલાઈ", "ઑગસ્ટ", "સપ્ટે", "ઑક્ટો", "નવે", "ડિસે", ""],
			["રવિવાર", "સોમવાર", "મંગળવાર", "બુધવાર", "ગુરુવાર", "શુક્રવાર", "શનિવાર"],
			["રવિ", "સોમ", "મંગળ", "બુધ", "ગુરુ", "શુક્ર", "શનિ"],
			["ર", "સ", "મ", "બ", "ગ", "શ", "શ"],
			"પૂર્વ મધ્યાહ્ન",
			"ઉત્તર મધ્યાહ્ન",
			"-",
			":",
			1,
			"%B, %Y",
			"%d %B",
			"%d %B %Y",
			"%d-%m-%y",
			"%a, %d %b %Y %H:%M:%S GMT",
			"%d %B %Y %H:%M:%S",
			"%Y-%m-%d %H:%M:%SZ",
			"%Y-%m-%dT%H:%M:%S",
			"%H:%M:%S",
			"%H:%M");
		symbolNaN = "NaN";
		symbolPercent = "%";
		symbolPermille = "‰";
		signNeg = "-";
		signPos = "+";
		symbolNegInf = "-Infinity";
		symbolPosInf = "Infinity";
		digits = ["૦", "૧", "૨", "૩", "૪", "૫", "૬", "૭", "૮", "૯"];
		number = new thx.culture.core.NumberInfo(2, ".", [3, 2], ",", "-n", "n");
		currency = new thx.culture.core.NumberInfo(2, ".", [3, 2], ",", "$ -n", "$ n");
		percent = new thx.culture.core.NumberInfo(2, ".", [3, 2], ",", "-n %", "n %");
		pluralRule = 1;
		englishCurrency = "Indian Rupee";
		nativeCurrency = "રૂપિયો";
		currencySymbol = "રૂ";
		currencyIso = "INR";
		englishRegion = "India";
		nativeRegion = "ભારત";
		iso2 = "IN";
		iso3 = "IND";
		isMetric = false;
		Culture.add(this);
	}
	@:isVar public static var culture(get, null) : Culture; static function get_culture() { if(null == culture) culture = new GuIN(); return culture; }
	static function __init__() { get_culture(); }
}