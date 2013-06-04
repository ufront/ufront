package thx.date;
import thx.cultures.EnUS;
import thx.error.Error;
using Arrays;

/**
 * ...
 * @author Franco Ponticelli
 */

class DateParser
{
	static var daynumeric = "0?[1-9]|[1-2][0-9]|3[0-1]";

	static var months = EnUS.culture.date.months.slice(0, -1).map(function(d) return d.toLowerCase());
	static var shortmonths = EnUS.culture.date.abbrMonths.slice(0, -1).map(function(d) return d.toLowerCase());
	static var days = EnUS.culture.date.days.map(function(d) return d.toLowerCase());
	static var shortdays = EnUS.culture.date.abbrDays.map(function(d) return d.toLowerCase());


	static var sfullmonths = months.join("|");
	static var sshortmonths = shortmonths.join("|");
	static var sfulldays = days.join("|");
	static var sshortdays = shortdays.join("|");
//	static var seasons = ["spring","summer","autumn","winter"].join("|");


	static var day = "(0?[0-9]|[1-2][0-9]|3[0-1])(?:st|nd|rd|th)?";
	static var month = "(?:0?[1-9]|1[0-2])";
	static var hour = "(?:0?[0-9]|1[0-9]|2[0-3])";
	static var hhour = "(?:0[0-9]|1[0-2])";
	static var hohour = "(?:0?[0-9]|1[0-2])";
	static var fminsec = "(?:0[0-9]|[1-5][0-9])";
	static var minsec = "(?:0?[0-9]|[1-5][0-9])";
	static var ampm = "(?:(?:in\\s+the\\s+)?(am|pm|evening|morning|afternoon))";
	static var daypart = "(?:(?:in\\s+the\\s+)?(evening|morning|afternoon|sunsrise|sunset|dawn|dusk|noon|mid-day|midday|mid-night|midnight))";
	static var period = "minute|minutes|hour|hours|day|days|week|weeks|month|months|year|years|second|seconds";

	static var dateexp = new EReg(
		"(?:(?:"
		+ "\\b(" + sfullmonths + ")\\s+"+day+"(?:\\s*,\\s*(\\d{2,4}))?\\b"  // g: 1,2,3
		+ ")|(?:"
		+ "\\b(" + sshortmonths + ")\\s+"+day+"(?:\\s*,?\\s*(\\d{2,4}))?\\b"  // g: 4,5,6
		+ ")|(?:"
		+ "\\b" + day + "\\s+(" + sfullmonths + ")(?:\\s+(\\d{2,4}))?\\b"  // g: 7,8,9
		+ ")|(?:"
		+ "\\b" + day + "\\s+(" + sshortmonths + ")(?:\\s+(\\d{2,4}))?\\b"  // g: 10,11,12
		+ ")|(?:"
		+ "\\b(?:" + day + "\\s+)?(" + sfullmonths + ")\\s+(\\d{2,4})\\b"  // g: 13,14,15
		+ ")|(?:"
		+ "\\b(?:" + day + "\\s+)?(" + sshortmonths + ")\\s+(\\d{2,4})\\b"  // g: 16,17,18

		+ ")|(?:"
		+ "\\b(" + month + ")/" + day + "(?:/(\\d{2,4}))?\\b"  // g: 19,20,21
		+ ")|(?:"
		+ "\\b" + day + "/(" + month + ")(?:/(\\d{2,4}))?\\b"  // g: 22,23,24
		+ ")|(?:"
		+ "\\b(\\d{2,4})-(" + month + ")-" + day + "\\b"  // g: 25,26,27

		+ ")|(?:"
		+ "^\\s*" + day + "\\s*$"  // g: 22

		+ "))"
		, "i"
	);

	static var absdateexp = new EReg(
		  "(?:(?:"
		+ "\\b(today|now|this\\s+second|tomorrow|yesterday)\\b"  // g: 1
		+ ")|(?:"
//		+ "\\b(?:(next|last|this)\\s+)?(" + seasons + ")\\b" // g:
//		+ ")|(?:"
		+ "\\b(?:(next|last|this)\\s+)?(" + sfullmonths + ")\\b" // g: 2,3
		+ ")|(?:"
		+ "\\b(?:(next|last|this)\\s+)?(" + sfulldays + ")\\b" // g: 4,5
		+ ")|(?:"
		+ "\\b(?:(next|last|this)\\s+)?(" + sshortmonths + ")\\b" // g: 6,7
		+ ")|(?:"
		+ "\\b(?:(next|last|this)\\s+)?(" + sshortdays + ")\\b" // g: 8,9
		+ "))"
		, "i"
	);

	static var relexp = new EReg(
		  "(?:(?:"
		 // g: 1,2,3
		 + "\\b(plus\\s+|minus\\s|\\+|-|in)\\s*(\\d+)?\\s+("+period+")\\b"
		+ ")|(?:"
		 // g: 4,5,6
		 + "\\b(\\d+)?\\s+("+period+")\\s+(from|before|hence|after|ago)?\\b"
		+ "))"
		, "i"
	);

	static var timeexp = new EReg(
		  "(?:\\bat\\s+)?" // at or T
		+ "(?:(?:"
		+ "\\b("+hohour+"):("+minsec+")\\s*"+ampm+"\\b" // 08:00 pm, groups: 1,2,3
		+ ")|(?:"
		+ "(?:\\b|T)("+hour+"):("+minsec+")(?:[:]("+minsec+")(?:\\.(\\d+))?)?\\b" // 20:00, groups: 4,5,6,7
		+ ")|(?:"
		+ "(?:^|\\s+)("+hhour+")("+fminsec+")\\s*"+ampm+"?(?:\\s+|$)" // 0800, groups: 8,9,10
		+ ")|(?:"
		+ "\\b(" + hohour + ")\\s*" + ampm + "\\b" // hour am|pm, groups: 11,12
		+ ")|(?:"
		+ "\\b"+daypart+"\\b" // groups: 13
		+ "))"
		, "i"
	);

	// day of the week
	// month
	// season
	// next something
	// last something
	// last period day
	// multiplier period (ago|before now|from now|hence)
	// in multiplier period
	// 1st|2nd|3rd|4-7th day

	public static function parse(s : String, ?d : Date) : Null<Date>
	{
		var time = parseTime(s), v;
		if (null == d)
			d = Date.now();
		if(null != time.matched)
			s = StringTools.replace(s, time.matched, ""); // strip off parsed time
		// set base date
		var year = 0, month = 0, day = 0, found = null != time.matched;
		if (dateexp.match(s)) {
			found = true;
			s = StringTools.replace(s, dateexp.matched(0), "");
			if (null != (v = dateexp.matched(1)))
			{
				day = Std.parseInt(dateexp.matched(2));
				month = months.indexOf(v.toLowerCase());
				year = null != (v = dateexp.matched(3)) ? fixyear(Std.parseInt(v)) : d.getFullYear();
			} else if (null != (v = dateexp.matched(4)))
			{
				day = Std.parseInt(dateexp.matched(5));
				month = shortmonths.indexOf(v.toLowerCase());
				year = null != (v = dateexp.matched(6)) ? fixyear(Std.parseInt(v)) : d.getFullYear();
			} else if (null != (v = dateexp.matched(8)))
			{
				month = months.indexOf(v.toLowerCase());
				day = null != (v = dateexp.matched(7)) ? Std.parseInt(v) : 1;
				year = null != (v = dateexp.matched(9)) ? fixyear(Std.parseInt(v)) : d.getFullYear();
			} else if (null != (v = dateexp.matched(11)))
			{
				month = shortmonths.indexOf(v.toLowerCase());
				day = null != (v = dateexp.matched(10)) ? Std.parseInt(v) : 1;
				year = null != (v = dateexp.matched(12)) ? fixyear(Std.parseInt(v)) : d.getFullYear();
			} else if (null != (v = dateexp.matched(14)))
			{
				month = months.indexOf(v.toLowerCase());
				day = null != (v = dateexp.matched(13)) ? Std.parseInt(v) : 1;
				year = null != (v = dateexp.matched(15)) ? fixyear(Std.parseInt(v)) : d.getFullYear();
			} else if (null != (v = dateexp.matched(17)))
			{
				month = shortmonths.indexOf(v.toLowerCase());
				day = null != (v = dateexp.matched(16)) ? Std.parseInt(v) : 1;
				year = null != (v = dateexp.matched(18)) ? fixyear(Std.parseInt(v)) : d.getFullYear();
			} else if (null != (v = dateexp.matched(19)))
			{
				day = Std.parseInt(dateexp.matched(20));
				month = Std.parseInt(v)-1;
				year = null != (v = dateexp.matched(21)) ? fixyear(Std.parseInt(v)) : d.getFullYear();
			} else if (null != (v = dateexp.matched(23)))
			{
				day = Std.parseInt(dateexp.matched(22));
				month = Std.parseInt(v)-1;
				year = null != (v = dateexp.matched(24)) ? fixyear(Std.parseInt(v)) : d.getFullYear();
			} else if (null != (v = dateexp.matched(25)))
			{
				year = fixyear(Std.parseInt(v));
				day = Std.parseInt(dateexp.matched(27));
				month = Std.parseInt(dateexp.matched(26))-1;
			} else if (null != (v = dateexp.matched(28)))
			{
				year = d.getFullYear();
				day = Std.parseInt(v);
				month = d.getMonth();
			}
		} else if (absdateexp.match(s))
		{
			found = true;
			s = StringTools.replace(s, absdateexp.matched(0), "");
			year = d.getFullYear();
			month = d.getMonth();
			day = d.getDate();
			if (null != (v = absdateexp.matched(1)))
			{
				switch(v.toLowerCase())
				{
					case "now", "this second":
						if (null == time.matched)
						{
							time.hour = d.getHours();
							time.minute = d.getMinutes();
							time.second = d.getSeconds();
						}
					case "tomorrow":
						day += 1;
					case "yesterday":
						day -= 1;
				}
			} else if (null != (v = absdateexp.matched(3))) // full months
			{
				var t = absdateexp.matched(2),
					v = months.indexOf(v.toLowerCase());

				if (v == month)
				{
					year += (last(t) ? -1 : (next(t) ? 1 : 0));
				} else if (v > month)
				{
					year += (last(t) ? -1 : 0);
				} else {
					year += (next(t) ? 1 : 0);
				}
				month = v;
				day = 1;
			} else if (null != (v = absdateexp.matched(5))) // full week days
			{
				var t = absdateexp.matched(4),
					v = days.indexOf(v.toLowerCase());

				var wd = d.getDay();
				if (v == wd)
				{
					day += (last(t) ? -7 : (next(t) ? 7 : 0));
				} else if (v > wd)
				{
					day += (v - wd) + (last(t) ? -7 : 0);
				} else {
					day += (v - wd) + (next(t) ? 7 : 0);
				}
			} else if (null != (v = absdateexp.matched(7))) // short months
			{
				var t = absdateexp.matched(6),
					v = shortmonths.indexOf(v.toLowerCase());
				if (v == month)
				{
					year += (last(t) ? -1 : (next(t) ? 1 : 0));
				} else if (v > month)
				{
					year += (last(t) ? -1 : 0);
				} else {
					year += (next(t) ? 1 : 0);
				}
				month = v;
				day = 1;
			} else if (null != (v = absdateexp.matched(9))) // short weekdays
			{
				var t = absdateexp.matched(8),
					v = shortdays.indexOf(v.toLowerCase());

				var wd = d.getDay();
				if (v == wd)
				{
					day += (last(t) ? -7 : (next(t) ? 7 : 0));
				} else if (v > wd)
				{
					day += (v - wd) + (last(t) ? -7 : 0);
				} else {
					day += (v - wd) + (next(t) ? 7 : 0);
				}
			}
			if (null == time.matched)
				time.matched = "x";
		} else {
			year = d.getFullYear();
			month = d.getMonth();
			day = d.getDate();
		}

		// add modifiers
		while (relexp.match(s))
		{
			found = true;
			s = StringTools.replace(s, relexp.matched(0), "");
			var dir = relexp.matched(1),
				qt,
				period;
			if (null != dir)
			{
				qt = null != (v = relexp.matched(2)) ? Std.parseInt(v) : 1;
				period = relexp.matched(3);
			} else {
				period = relexp.matched(5);
				if (null == period)
					break;
				qt = null != (v = relexp.matched(4)) ? Std.parseInt(v) : 1;
				dir = null != (v = relexp.matched(6)) ? v : "after";
			}

			dir = dir.toLowerCase();

			switch(dir) {
				case "plus", "+", "from", "hence", "after":
					//
				case "minus", "-", "before", "ago":
					qt = -qt;

			};

			switch(dir)
			{
				case "ago", "in":
					if (null == time.matched)
					{
						time.hour = d.getHours();
						time.minute = d.getMinutes();
						time.second = d.getSeconds();
						time.matched = "x";
					}
			}

			switch(period.toLowerCase())
			{
				case "second", "seconds":
					time.second += qt;
				case "minute", "minutes":
					time.minute += qt;
				case "hour", "hours":
					time.hour += qt;
				case "day", "days":
					day += qt;
				case "week", "weeks":
					day += qt * 7;
				case "month", "months":
					month += qt;
				case "year", "years":
					year += qt;
			}
		}

		if (!found)
			throw new Error("no date information found in the string '{0}'", s);
		return Date.fromTime(new Date(year, month, day, time.hour, time.minute, time.second).getTime() + time.millis);
	}

	public static function parseTime(s : String)
	{
		var result = {
			hour    : 0,
			minute  : 0,
			second  : 0,
			millis  : 0.0,
			matched : null
		};
		if (!timeexp.match(s))
			return result;
		result.matched = timeexp.matched(0);

		// hour   1,4,8, 11
		// min    2,5,9
		// sec      6
		// am     3,  10,12
		// millis   7
		var v;
		if (null != (v = timeexp.matched(1)))
		{
			result.hour = Std.parseInt(v) + plusPm(timeexp.matched(3));
			result.minute = Std.parseInt(timeexp.matched(2));
		} else if (null != (v = timeexp.matched(4)))
		{
			result.hour = Std.parseInt(v);
			result.minute = Std.parseInt(timeexp.matched(5));
			if (null != (v = timeexp.matched(6)))
				result.second = Std.parseInt(v);
			if (null != (v = timeexp.matched(7)))
				result.millis = Std.parseFloat(v) / 1000;
		} else if (null != (v = timeexp.matched(8)))
		{
			result.hour = Std.parseInt(v) + plusPm(timeexp.matched(10));
			result.minute = Std.parseInt(timeexp.matched(9));
		} else if (null != (v = timeexp.matched(11)))
		{
			result.hour = Std.parseInt(v) + plusPm(timeexp.matched(12));
		} else if (null != (v = timeexp.matched(13)))
		{
			// some of the followings values are subjective or varying during the seasons
			switch(v.toLowerCase())
			{
				case "evening":
					result.hour = 17;
				case "morning":
					result.hour = 8;
				case "afternoon":
					result.hour = 14;
				case "sunsrise", "dawn":
					result.hour = 6;
				case "sunset", "dusk":
					result.hour = 19;
				case "noon", "midday", "mid-day":
					result.hour = 12;
				case "mid-night", "midnight":
					result.hour = 23;
					result.minute = 59;
					result.second = 59;
					result.millis = 0.999;
			}
		} else {
			// should never happen
			throw new Error("failed to parse time for '{0}'", s);
		}
		return result;
	}

	static function fixyear(y : Int)
	{
		if (y < 70)
			return 2000 + y;
		else if (y < 100)
			return 1900 + y;
		else
			return y;
	}

	static function last(s : String)
	{
		if (null == s)
			return false;
		else
			return "last" == s.toLowerCase();
	}

	static function next(s : String)
	{
		if (null == s)
			return true;
		else
			return "next" == s.toLowerCase();
	}

	static function plusPm(s : String)
	{
		if (null == s)
			return 0;
		else return switch(s.toLowerCase())
		{
			case 'pm', 'evening', 'afternoon': 12;
			default: 0;
		}
	}
}