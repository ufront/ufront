package thx.cultures;

import thx.culture.Culture;

class KaGE extends Culture {
	function new() {
		language = thx.languages.Ka.language;
		name = "ka-GE";
		english = "Georgian (Georgia)";
		native = "ქართული (საქართველო)";
		date = new thx.culture.core.DateTimeInfo(
			["იანვარი", "თებერვალი", "მარტი", "აპრილი", "მაისი", "ივნისი", "ივლისი", "აგვისტო", "სექტემბერი", "ოქტომბერი", "ნოემბერი", "დეკემბერი", ""],
			["იან", "თებ", "მარ", "აპრ", "მაის", "ივნ", "ივლ", "აგვ", "სექ", "ოქტ", "ნოემ", "დეკ", ""],
			["კვირა", "ორშაბათი", "სამშაბათი", "ოთხშაბათი", "ხუთშაბათი", "პარასკევი", "შაბათი"],
			["კვირა", "ორშაბათი", "სამშაბათი", "ოთხშაბათი", "ხუთშაბათი", "პარასკევი", "შაბათი"],
			["კ", "ო", "ს", "ო", "ხ", "პ", "შ"],
			null,
			null,
			".",
			":",
			1,
			"%B %Y",
			"%d %m",
			"%Y წლის %d %m, %A",
			"%d.%m.%Y",
			"%a, %d %b %Y %H:%M:%S GMT",
			"%Y წლის %d %m, %A %k:%M:%S",
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
		number = new thx.culture.core.NumberInfo(2, ",", [3], " ", "-n", "n");
		currency = new thx.culture.core.NumberInfo(2, ",", [3], " ", "-n $", "n $");
		percent = new thx.culture.core.NumberInfo(2, ",", [3], " ", "-n %", "n %");
		pluralRule = 0;
		englishCurrency = "Lari";
		nativeCurrency = "ლარი";
		currencySymbol = "Lari";
		currencyIso = "GEL";
		englishRegion = "Georgia";
		nativeRegion = "საქართველო";
		iso2 = "GE";
		iso3 = "GEO";
		isMetric = false;
		Culture.add(this);
	}
	@:isVar public static var culture(get, null) : Culture; static function get_culture() { if(null == culture) culture = new KaGE(); return culture; }
	static function __init__() { get_culture(); }
}