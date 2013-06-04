package thx.cultures;

import thx.culture.Culture;

class HyAM extends Culture {
	function new() {
		language = thx.languages.Hy.language;
		name = "hy-AM";
		english = "Armenian (Armenia)";
		native = "Հայերեն (Հայաստան)";
		date = new thx.culture.core.DateTimeInfo(
			["Հունվար", "Փետրվար", "Մարտ", "Ապրիլ", "Մայիս", "Հունիս", "Հուլիս", "Օգոստոս", "Սեպտեմբեր", "Հոկտեմբեր", "Նոյեմբեր", "Դեկտեմբեր", ""],
			["ՀՆՎ", "ՓՏՎ", "ՄՐՏ", "ԱՊՐ", "ՄՅՍ", "ՀՆՍ", "ՀԼՍ", "ՕԳՍ", "ՍԵՊ", "ՀՈԿ", "ՆՈՅ", "ԴԵԿ", ""],
			["Կիրակի", "Երկուշաբթի", "Երեքշաբթի", "Չորեքշաբթի", "Հինգշաբթի", "ՈՒրբաթ", "Շաբաթ"],
			["Կիր", "Երկ", "Երք", "Չրք", "Հնգ", "ՈՒր", "Շբթ"],
			["Կ", "Ե", "Ե", "Չ", "Հ", "Ո", "Շ"],
			null,
			null,
			".",
			":",
			1,
			"%B, %Y",
			"%e %B",
			"%e %B, %Y",
			"%d.%m.%Y",
			"%a, %d %b %Y %H:%M:%S GMT",
			"%e %B, %Y %k:%M:%S",
			"%Y-%m-%d %H:%M:%SZ",
			"%Y-%m-%dT%H:%M:%S",
			"%k:%M:%S",
			"%k:%M");
		symbolNaN = "NaN";
		symbolPercent = "%";
		symbolPermille = "‰";
		signNeg = "-";
		signPos = "+";
		symbolNegInf = "-Infinity";
		symbolPosInf = "Infinity";
		number = new thx.culture.core.NumberInfo(2, ".", [3], ",", "-n", "n");
		currency = new thx.culture.core.NumberInfo(2, ".", [3], ",", "-n $", "n $");
		percent = new thx.culture.core.NumberInfo(2, ".", [3], ",", "-n %", "n %");
		pluralRule = 1;
		englishCurrency = "Armenian Dram";
		nativeCurrency = "դրամ";
		currencySymbol = "դր.";
		currencyIso = "AMD";
		englishRegion = "Armenia";
		nativeRegion = "Հայաստան";
		iso2 = "AM";
		iso3 = "ARM";
		isMetric = false;
		Culture.add(this);
	}
	@:isVar public static var culture(get, null) : Culture; static function get_culture() { if(null == culture) culture = new HyAM(); return culture; }
	static function __init__() { get_culture(); }
}