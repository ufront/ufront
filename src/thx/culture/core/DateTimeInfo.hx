package thx.culture.core;

class DateTimeInfo {
	public var months(default, null) : Array<String>;
	public var abbrMonths(default, null) : Array<String>;
	public var days(default, null) : Array<String>;
	public var abbrDays(default, null) : Array<String>;
	public var shortDays(default, null) : Array<String>;
	public var am(default, null) : String;
	public var pm(default, null) : String;
	public var separatorDate(default, null) : String;
	public var separatorTime(default, null) : String;
	public var firstWeekDay(default, null) : Int;
	public var patternYearMonth(default, null) : String;
	public var patternMonthDay(default, null) : String;
	public var patternDate(default, null) : String;
	public var patternDateShort(default, null) : String;
	public var patternDateRfc(default, null) : String;
	public var patternDateTime(default, null) : String;
	public var patternUniversal(default, null) : String;
	public var patternSortable(default, null) : String;
	public var patternTime(default, null) : String;
	public var patternTimeShort(default, null) : String;

	public function new(months : Array<String>, abbrMonths : Array<String>, days : Array<String>, abbrDays : Array<String>, shortDays : Array<String>, am : String, pm : String, separatorDate : String, separatorTime : String, firstWeekDay : Int, patternYearMonth : String, patternMonthDay : String, patternDate : String, patternDateShort : String, patternDateRfc : String, patternDateTime : String, patternUniversal : String, patternSortable : String, patternTime : String, patternTimeShort : String) {
		this.months = months;
		this.abbrMonths = abbrMonths;
		this.days = days;
		this.abbrDays = abbrDays;
		this.shortDays = shortDays;
		this.am = am;
		this.pm = pm;
		this.separatorDate = separatorDate;
		this.separatorTime = separatorTime;
		this.firstWeekDay = firstWeekDay;

		this.patternYearMonth = patternYearMonth;
		this.patternMonthDay = patternMonthDay;
		this.patternDate = patternDate;
		this.patternDateShort = patternDateShort;
		this.patternDateRfc = patternDateRfc;
		this.patternDateTime = patternDateTime;
		this.patternUniversal = patternUniversal;
		this.patternSortable = patternSortable;
		this.patternTime = patternTime;
		this.patternTimeShort = patternTimeShort;
	}
}