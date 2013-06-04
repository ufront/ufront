package thx.culture;

class FormatDate {
	/**
	* Returns a formatted date according to the passed pattern and culture. The pattern
	* paramter accepts the following modifiers.
	*
<pre>
    description                                                   example
===========================================================================
%a	The abbreviated weekday name according to the current locale. Wed
%A	The full weekday name according to the current locale.	      Wednesday
%b	The abbreviated month name according to the current locale.	  Jan
%B	The full month name according to the current locale.	      January
%c	The preferred date and time representation for the current locale.
%C	The century number (year/100) as a 2-digit integer.	          19
%d	The day of the month as a decimal number (range 01 to 31).	  07
%D	Equivalent to %m/%d/%y. (This is the USA date format.         06/25/04
    In many countries %d/%m/%y is the standard date format.
    Thus, in an international context, both of these formats are
    ambiguous and should be avoided.)
%e	Like %d, the day of the month as a decimal number, but a      7
    leading zero may be replaced by a leadingspace.
%G	The ISO 8601 year with century as a decimal number. The       2004
    4-digit year corresponding to the ISO week number (see %V).
    This has the same format and value as %y, except that if the
    ISO week number belongs to the previous or next year, that
    year is used instead.
%g	Like %G, but without century, i.e., with a 2-digit year       04
    (00-99).
%h	Equivalent to %b.	                                          Jan
%H	The hour as a decimal number using a 24-hour clock            22
    (range 00 to 23).
%I	The hour as a decimal number using a 12-hour clock            07
    (range 01 to 12).
%j	The day of the year as a decimal number (range 001 to 366).   008
%k	The hour (24-hour clock) as a decimal number (range 0 to 23); 7
    single-digits are optionally prefixed by leadingspace.
    (See also %H.)
%l	The hour (12-hour clock) as a decimal number (range 1 to 12); 7
    single-digits are optionally prefixed by leadingspace.
    (See also %I.)
%m	The month as a decimal number (range 01 to 12).	              04
%M	The minute as a decimal number (range 00 to 59).              08
%n	A newline character.
%p	Either 'AM' or 'PM' according to the given time value, or the AM
    corresponding strings for the current locale. Noon is treated
    as 'pm' and midnight as 'am'.
%P	Like %p but in lowercase: 'am' or 'pm' or a corresponding     AM
    string for the current locale.
%r	The time in a.m. or p.m. notation. In the POSIX locale this   07:08:09 am
    is equivalent to '%I:%M:%S %p'.
%R	The time in 24-hour notation (%H:%M). For a version including 07:08
    the seconds, see %T below.
%s	The number of seconds since the Epoch, i.e., since            1099928130
    1970-01-01 00:00:00 UTC.
%S	The second as a decimal number (range 00 to 61). the upper    07
    level of the range 61 rather than 59 to allow for the
    occasional leap second and even more occasional double leap
    second.
%t	A tab character.
%T	The time in 24-hour notation (%H:%M:%S).                      17:08:09
%u	The day of the week as a decimal, range 1 to 7, Monday
    being 1. See also %w.
%U	The week number of the current year as a decimal number,      26
    range 00 to 53, starting with the first Sunday as the first
    day of week 01. See also %V and %W.
%V	The ISO 8601:1988 week number of the current year as a        26
    decimal number, range 01 to 53, where week 1 is the first
    week that has at least 4 days in the current year, and with
    Monday as the first day of the week. See also %U and %W.
%w	The day of the week as a decimal, range 0 to 6, Sunday being
    0. See also %u.
%W	The week number of the current year as a decimal number,
    range 00 to 53, starting with the first Monday as the first
    day of week 01.
%x	The preferred date representation for the current locale
    without the time.
%X	The preferred time representation for the current locale
    without the date.
%y	The year as a decimal number without a century                04
    (range 00 to 99).
%Y	The year as a decimal number including the century.           2004
%z	The time-zone as hour offset from GMT. Required to emit       -2
    RFC822-conformant dates (using "%a, %d %b %Y %H:%M:%S %z").
%Z	The time zone or name or abbreviation.                        GMT
%%	A literal '%' character.                                      %

customs for missing features
%f  The month. Single-digit months may be prefixed by             6
    leadingspace.
%i  The minute. Single-digit minutes may be prefixed by           8
    leadingspace.
%q  The second. Single-digit seconds may be prefixed by           9
    leadingspace.
</pre>
	*/
	static public function format(date : Date, pattern : String, ?culture : Culture, leadingspace = true) : String {
		if (null == culture)
			culture = Culture.defaultCulture;
		var pos = 0;
		var len = pattern.length;
		var buf = new StringBuf();
		var info = culture.date;
		while(pos < len) {
			var c = pattern.charAt(pos);
			if(c != '%') {
				buf.add(c);
				pos++;
				continue;
			}
			pos++;
			c = pattern.charAt(pos);
			switch(c) {
				case 'a': buf.add(info.abbrDays[date.getDay()]);
				case 'A': buf.add(info.days[date.getDay()]);
				case 'b', 'h': buf.add(info.abbrMonths[date.getMonth()]);
				case 'B': buf.add(info.months[date.getMonth()]);
				case 'c': buf.add(dateTime(date, culture));
				case 'C': buf.add(FormatNumber.digits(''+Math.floor(date.getFullYear()/100), culture));
				case 'd': buf.add(FormatNumber.digits(StringTools.lpad(''+date.getDate(), '0', 2), culture));
				case 'D': buf.add(format(date, "%m/%d/%y", culture));
				case 'e': buf.add(FormatNumber.digits(leadingspace ? StringTools.lpad(''+date.getDate(), ' ', 2) : ''+date.getDate(), culture));
				case 'f': buf.add(FormatNumber.digits(leadingspace ? StringTools.lpad(''+(date.getMonth()+1), ' ', 2) : ''+(date.getMonth()+1), culture));
				case 'G': throw "Not Implemented Yet";
				case 'g': throw "Not Implemented Yet";
				case 'H': buf.add(FormatNumber.digits(StringTools.lpad(''+date.getHours(), '0', 2), culture));
				case 'i': buf.add(FormatNumber.digits(leadingspace ? StringTools.lpad(''+date.getMinutes(), ' ', 2) : ''+date.getMinutes(), culture));
				case 'I': buf.add(FormatNumber.digits(StringTools.lpad(''+getMHours(date), '0', 2), culture));
				case 'j': throw "Not Implemented Yet";
				case 'k': buf.add(FormatNumber.digits(leadingspace ? StringTools.lpad(''+date.getHours(), ' ', 2) : ''+date.getHours(), culture));
				case 'l': buf.add(FormatNumber.digits(leadingspace ? StringTools.lpad(''+getMHours(date), ' ', 2) : ''+getMHours(date), culture));
				case 'm': buf.add(FormatNumber.digits(StringTools.lpad(''+(date.getMonth()+1), '0', 2), culture));
				case 'M': buf.add(FormatNumber.digits(StringTools.lpad(''+date.getMinutes(), '0', 2), culture));
				case 'n': buf.add("\n");
				case 'p': buf.add(date.getHours() > 11 ? info.pm : info.am);
				case 'P': buf.add((date.getHours() > 11 ? info.pm : info.am).toLowerCase());
				case 'q': buf.add(FormatNumber.digits(leadingspace ? StringTools.lpad(''+date.getSeconds(), ' ', 2) : ''+date.getSeconds(), culture));
				case 'r': buf.add(format(date, "%I:%M:%S %p", culture));
				case 'R': buf.add(format(date, "%H:%M", culture));
				case 's': buf.add(''+Std.int(date.getTime()/1000));
				case 'S': buf.add(FormatNumber.digits(StringTools.lpad(''+date.getSeconds(), '0', 2), culture));
				case 't': buf.add('\t');
				case 'T': buf.add(format(date, "%H:%M:%S", culture));
				case 'u': var d = date.getDay(); buf.add(FormatNumber.digits(d == 0 ? '7' : ''+d, culture));
				case 'U': throw "Not Implemented Yet";
				case 'V': throw "Not Implemented Yet";
				case 'w': buf.add(FormatNumber.digits(''+date.getDay(), culture));
				case 'W': throw "Not Implemented Yet";
				case 'x': buf.add(FormatDate.date(date, culture));
				case 'X': buf.add(time(date, culture));
				case 'y': buf.add(FormatNumber.digits((''+(date.getFullYear())).substr(-2), culture));
				case 'Y': buf.add(FormatNumber.digits(''+(date.getFullYear()), culture));
				case 'z': buf.add("+0000");  // TODO: check if there is a way to catch the correct settings
				case 'Z': buf.add("GMT");    // TODO: check if there is a way to catch the correct settings
				case '%': buf.add("%");
				default:  buf.add("%" + c);
			}
			pos++;
		}
		return buf.toString();
	}
	
	static function getMHours(date : Date)
	{
		var v = date.getHours();
		return v > 12 ? v - 12 : v;
	}

	static public function yearMonth(date : Date, ?culture : Culture) : String {
		if (null == culture)
			culture = Culture.defaultCulture;
		return format(date, culture.date.patternYearMonth, culture, false);
	}

	static public function monthDay(date : Date, ?culture : Culture) : String {
		if (null == culture)
			culture = Culture.defaultCulture;
		return format(date, culture.date.patternMonthDay, culture, false);
	}

	static public function dateYMD(date : Date, ?culture : Culture) : String {
		if (null == culture)
			culture = Culture.defaultCulture;
		return format(date, "%Y-%m-%d", culture, false);
	}

	static public function date(date : Date, ?culture : Culture) : String {
		if (null == culture)
			culture = Culture.defaultCulture;
		return format(date, culture.date.patternDate, culture, false);
	}

	static public function dateShort(date : Date, ?culture : Culture) : String {
		if (null == culture)
			culture = Culture.defaultCulture;
		return format(date, culture.date.patternDateShort, culture, false);
	}

	static public function dateShortTime(d : Date, ?culture : Culture) : String {
		return dateShort(d, culture)+' '+time(d, culture);
	}

	static public function dateShortTimeShort(d : Date, ?culture : Culture) : String {
		return dateShort(d, culture)+' '+timeShort(d, culture);
	}

	static public function dateTimeShort(d : Date, ?culture : Culture) : String {
		return date(d, culture)+' '+timeShort(d, culture);
	}

	static public function dateRfc(date : Date, ?culture : Culture) : String {
		if (null == culture)
			culture = Culture.defaultCulture;
		return format(date, culture.date.patternDateRfc, culture, false);
	}

	static public function dateTime(date : Date, ?culture : Culture) : String {
		if (null == culture)
			culture = Culture.defaultCulture;
		return format(date, culture.date.patternDateTime, culture, false);
	}

	static public function universal(date : Date, ?culture : Culture) : String {
		if (null == culture)
			culture = Culture.defaultCulture;
		return format(date, culture.date.patternUniversal, culture, false);
	}

	static public function sortable(date : Date, ?culture : Culture) : String {
		if (null == culture)
			culture = Culture.defaultCulture;
		return format(date, culture.date.patternSortable, culture, false);
	}

	static public function time(date : Date, ?culture : Culture) : String {
		if (null == culture)
			culture = Culture.defaultCulture;
		return format(date, culture.date.patternTime, culture, false);
	}

	static public function timeShort(date : Date, ?culture : Culture) : String {
		if (null == culture)
			culture = Culture.defaultCulture;
		return format(date, culture.date.patternTimeShort, culture, false);
	}
	
	static public function hourShort(date : Date, ?culture : Culture) : String {
		if (null == culture)
			culture = Culture.defaultCulture;
		if (null == culture.date.am)
			return format(date, "%H", culture, false);
		else
			return format(date, "%l %p", culture, false);
	}

	static public function year(date : Date, ?culture : Culture) : String {
		if (null == culture)
			culture = Culture.defaultCulture;
		return FormatNumber.digits(''+date.getFullYear(), culture);
	}

	static public function month(date : Date, ?culture : Culture) : String {
		if (null == culture)
			culture = Culture.defaultCulture;
		return FormatNumber.digits(''+(date.getMonth()+1), culture);
	}

	static public function monthName(date : Date, ?culture : Culture) : String {
		if (null == culture)
			culture = Culture.defaultCulture;
		return culture.date.months[date.getMonth()];
	}

	static public function monthNameShort(date : Date, ?culture : Culture) : String {
		if (null == culture)
			culture = Culture.defaultCulture;
		return culture.date.abbrMonths[date.getMonth()];
	}

	static public function weekDay(date : Date, ?culture : Culture) : String {
		if (null == culture)
			culture = Culture.defaultCulture;
		return FormatNumber.digits(''+(date.getDay()+culture.date.firstWeekDay), culture);
	}

	static public function weekDayName(date : Date, ?culture : Culture) : String {
		if (null == culture)
			culture = Culture.defaultCulture;
		return culture.date.days[date.getDay()];
	}

	static public function weekDayNameShort(date : Date, ?culture : Culture) : String {
		if (null == culture)
			culture = Culture.defaultCulture;
		return culture.date.abbrDays[date.getDay()];
	}

	/** Given a week day number, retrieve the day name. 
	* 
	*	@param weekDayNum The day number in the week.  0 is the first day of the week, 6 is the final day.
	*	@param firstDayOfWk The first day of the week to use.  Default: 0 (Sunday) 
	*	@param culture The culture to use to get the weekday name.  Default: null (will fetch Culture.defaultCulture)
	*	@return The abbreviated weekday name for the given culture, eg "Monday".  Returns null if no match was found.
	*/
	static public function weekDayNameFromNum(weekDayNum:Int, ?firstDayOfWk = 0, ?culture : Culture) {
		if (null == culture)
			culture = Culture.defaultCulture;
		
		firstDayOfWk = Ints.wrap(firstDayOfWk, 0, 6);
		var nameIndex = Ints.wrap(weekDayNum + firstDayOfWk, 0, 6);

		return culture.date.days[nameIndex];
	}


	/** Given a week day number, retrieve the abbreviated day name. 
	* 
	*	@param weekDayNum The day number in the week.  0 is the first day of the week, 6 is the final day.
	*	@param firstDayOfWk The first day of the week to use.  Default: 0 (Sunday) 
	*	@param culture The culture to use to get the weekday name.  Default: null (will fetch Culture.defaultCulture)
	*	@return The abbreviated weekday name for the given culture, eg "Mon".  Returns null if no match was found.
	*/
	static public function weekDayShortNameFromNum(weekDayNum:Int, ?firstDayOfWk = 0, ?culture : Culture) {
		if (null == culture)
			culture = Culture.defaultCulture;
		
		firstDayOfWk = Ints.wrap(firstDayOfWk, 0, 6);
		var nameIndex = Ints.wrap(weekDayNum + firstDayOfWk, 0, 6);

		return culture.date.abbrDays[nameIndex];
	}

	/** Given a week day name, figure out the weekday number.
	*
	*   The name can be provided as the long name (eg "Sunday") or the abbreviated form ("sunday") and 
	*   is matched against the values in your culture.dates.days[] or culture.dates.abbrDays[].  It is
	*   case insensitive.  
	*
	*   The number returned is adjusted for your start day of week.  For example (in English):
	*      
	*       when firstDayOfWk=0, a search for "Monday" will return 1.
	*       when firstDayOfWk=1, a search for "Monday" will return 0.
	* 
	*	@param weekDayName The name of the weekday.  Can be abbreivated (Mon) or full (Monday).  Case insensitive. (monday)
	*	@param firstDayOfWk The first day of the week to use.  Default: 0 (Sunday) 
	*	@param culture The culture to use to get the weekday name.  Default: null (will fetch Culture.defaultCulture)
	*	@return The number day in the week this is.  Will return -1 if no match was found.
	*/
	static public function weekDayNumFromName(weekDayName:String, ?firstDayOfWk = 0, ?culture : Culture) {
		if (null == culture)
			culture = Culture.defaultCulture;

		weekDayName = (weekDayName != null) ? weekDayName.toLowerCase() : "";

		// Make them lower case, so our comparison is case insensitive
		var dayNames = culture.date.days.map(function (d) return d.toLowerCase());
		var abbrDayNames = culture.date.abbrDays.map(function (d) return d.toLowerCase());

		// Try the full name first, then the abbr name
		var index = Lambda.indexOf(dayNames, weekDayName);
		if (index == -1) index = Lambda.indexOf(abbrDayNames, weekDayName);

		// If there was a match, adjust for firstDayOfWk
		if (index != -1)
		{
			firstDayOfWk = Ints.wrap(firstDayOfWk, 0, 6);
			index = Ints.wrap(index - firstDayOfWk, 0, 6);
		}
		return index;
	}
}