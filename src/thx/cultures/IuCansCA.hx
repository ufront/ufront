package thx.cultures;

import thx.culture.Culture;

class IuCansCA extends Culture {
	function new() {
		name = "iu-Cans-CA";
		english = "Inuktitut (Syllabics) (Canada)";
		native = "ᐃᓄᒃᑎᑐᑦ (ᑲᓇᑕ)";
		date = new thx.culture.core.DateTimeInfo(
			["ᔮᓐᓄᐊᕆ", "ᕖᕝᕗᐊᕆ", "ᒫᑦᓯ", "ᐄᐳᕆ", "ᒪᐃ", "ᔫᓂ", "ᔪᓚᐃ", "ᐋᒡᒌᓯ", "ᓯᑎᐱᕆ", "ᐅᑐᐱᕆ", "ᓄᕕᐱᕆ", "ᑎᓯᐱᕆ", ""],
			["ᔮᓐᓄ", "ᕖᕝᕗ", "ᒫᑦᓯ", "ᐄᐳᕆ", "ᒪᐃ", "ᔫᓂ", "ᔪᓚᐃ", "ᐋᒡᒌ", "ᓯᑎᐱ", "ᐅᑐᐱ", "ᓄᕕᐱ", "ᑎᓯᐱ", ""],
			["ᓈᑦᑏᖑᔭ", "ᓇᒡᒐᔾᔭᐅ", "ᐊᐃᑉᐱᖅ", "ᐱᖓᑦᓯᖅ", "ᓯᑕᒻᒥᖅ", "ᑕᓪᓕᕐᒥᖅ", "ᓯᕙᑖᕐᕕᒃ"],
			["ᓈᑦᑏ", "ᓇᒡᒐ", "ᐊᐃᑉᐱ", "ᐱᖓᑦᓯ", "ᓯᑕ", "ᑕᓪᓕ", "ᓯᕙᑖᕐᕕᒃ"],
			["ᓈ", "ᓇ", "ᐊ", "ᐱ", "ᓯ", "ᑕ", "ᓯ"],
			"AM",
			"PM",
			"/",
			":",
			0,
			"%B,%Y",
			"%B %d",
			"%A,%B %d,%Y",
			"%e/%f/%Y",
			"%a, %d %b %Y %H:%M:%S GMT",
			"%A,%B %d,%Y %l:%M:%S %p",
			"%Y-%m-%d %H:%M:%SZ",
			"%Y-%m-%dT%H:%M:%S",
			"%l:%M:%S %p",
			"%l:%M:%S %p");
		englishCurrency = "Canadian Dollar";
		nativeCurrency = "ᑲᓇᑕᐅᑉ ᑮᓇᐅᔭᖓ";
		currencySymbol = "$";
		currencyIso = "CAD";
		englishRegion = "Canada";
		nativeRegion = "ᑲᓇᑕ";
		iso2 = "CA";
		iso3 = "CAN";
		isMetric = false;
		Culture.add(this);
	}
	@:isVar public static var culture(get, null) : Culture; static function get_culture() { if(null == culture) culture = new IuCansCA(); return culture; }
}