package thx.cultures;

import thx.culture.Culture;

class HeIL extends Culture {
	function new() {
		language = thx.languages.He.language;
		name = "he-IL";
		english = "Hebrew (Israel)";
		native = "עברית (ישראל)";
		date = new thx.culture.core.DateTimeInfo(
			["ינואר", "פברואר", "מרץ", "אפריל", "מאי", "יוני", "יולי", "אוגוסט", "ספטמבר", "אוקטובר", "נובמבר", "דצמבר", ""],
			["ינו", "פבר", "מרץ", "אפר", "מאי", "יונ", "יול", "אוג", "ספט", "אוק", "נוב", "דצמ", ""],
			["יום ראשון", "יום שני", "יום שלישי", "יום רביעי", "יום חמישי", "יום שישי", "שבת"],
			["יום א", "יום ב", "יום ג", "יום ד", "יום ה", "יום ו", "שבת"],
			["א", "ב", "ג", "ד", "ה", "ו", "ש"],
			"AM",
			"PM",
			"/",
			":",
			0,
			"%B %Y",
			"%d %B",
			"%A %d %B %Y",
			"%d/%m/%Y",
			"%a, %d %b %Y %H:%M:%S GMT",
			"%A %d %B %Y %H:%M:%S",
			"%Y-%m-%d %H:%M:%SZ",
			"%Y-%m-%dT%H:%M:%S",
			"%H:%M:%S",
			"%H:%M");
		symbolNaN = "לא מספר";
		symbolPercent = "%";
		symbolPermille = "‰";
		signNeg = "-";
		signPos = "+";
		symbolNegInf = "אינסוף שלילי";
		symbolPosInf = "אינסוף חיובי";
		number = new thx.culture.core.NumberInfo(2, ".", [3], ",", "-n", "n");
		currency = new thx.culture.core.NumberInfo(2, ".", [3], ",", "$-n", "$ n");
		percent = new thx.culture.core.NumberInfo(2, ".", [3], ",", "-n%", "n%");
		pluralRule = 1;
		englishCurrency = "Israeli New Shekel";
		nativeCurrency = "שקל חדש";
		currencySymbol = "₪";
		currencyIso = "ILS";
		englishRegion = "Israel";
		nativeRegion = "ישראל";
		iso2 = "IL";
		iso3 = "ISR";
		isMetric = false;
		Culture.add(this);
	}
	@:isVar public static var culture(get, null) : Culture; static function get_culture() { if(null == culture) culture = new HeIL(); return culture; }
	static function __init__() { get_culture(); }
}