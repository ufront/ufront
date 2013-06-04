package thx.math.scale;

/**
 * Based on D3.js by Michael Bostock
 * @author Franco Ponticelli
 */

import thx.culture.FormatDate;
import thx.error.Error;
using Arrays;

class LinearTime extends Linear
{
	var _usetimeticks : Bool;
	var _maxnumberofticks : Int;
	public function new()
	{
		super();
		_usetimeticks = false;
		_maxnumberofticks = 10;
	}
// TODO: remove
	public static function guessPeriodicity(a : Float, b : Float, disc = 2)
	{
		var delta = Math.abs(b - a);
		if (delta >= DateTools.days(365 * disc))
			return "year";
		else if (delta >= DateTools.days(30 * disc))
			return "month";
		else if (delta >= DateTools.days(7 * disc))
			return "week";
		else if (delta >= DateTools.days(disc))
			return "day";
		else if (delta >= DateTools.hours(disc))
			return "hour";
		else
			return "minute";
	}
// TODO: remove
	static var valids = ["minute", "hour", "day", "week", "month", "year"];
// TODO: remove
	var _periodicity : String;

	override public function domain(d : Array<Float>) : Linear
	{
		super.domain(d);
// TODO: remove
		_periodicity = guessPeriodicity(d[0], d[1]);
		return this;
	}
// TODO: remove
	public function getPeriodicity() return _periodicity
// TODO: remove
	public function periodicity(v : String)
	{
		v = v.toLowerCase();
		if (!valids.exists(v))
			throw new Error("invalid periodicity '{0}'", v);
		_periodicity = v;
		return this;
	}

	override public function tickFormat(v : Float, ?i : Int)
	{
		var d = Date.fromTime(v);
		switch(_periodicity) {
			case "minute":
				return FormatDate.timeShort(d);
			case "hour":
				return FormatDate.timeShort(d);
			case "day", "week":
				return FormatDate.monthDay(d);
			case "month":
				return FormatDate.yearMonth(d);
			case "year":
				return FormatDate.year(d);
		};
		return "invalid date periodicity"; // should never happen
	}

	public function getUseTimeTicks() return _usetimeticks
	public function useTimeTicks(v : Bool)
	{
		_usetimeticks = v;
		return this;
	}
	
	public function getMaxNumberOfTicks() return _maxnumberofticks
	public function maxNumberOfTicks(v : Int)
	{
		_maxnumberofticks = v;
		return this;
	}
	
	override public function ticks()
	{
		if (_usetimeticks)
			return timeTicks();
		else
			return linearTicks();
	}

	public function linearTicks()
	{
		return super.ticks();
	}
	
	public function timeTicks()
	{
		var start = Arrays.min(_domain);
		var stop = Arrays.max(_domain);
		var step = 0.0;
		switch(_periodicity)
		{
			case "minute":
				step = 60000;
			case "hour":
				step = 60000 * 60;
			case "day":
				step = 60000 * 60 * 24;
			case "week":
				step = 60000 * 60 * 24 * 7;
			case "month":
				var range = [];
				var step1 = 60000 * 60 * 24 * DateTools.getMonthDays(Date.fromTime(start));
				var step2 = 60000 * 60 * 24 * DateTools.getMonthDays(Date.fromTime(stop));
				start = Math.ceil(start / step1) * step1;
				stop = Math.floor(stop / step2) * step2 + step2 * .5;
				while (start <= stop)
				{
					range.push(start);
					var d = Date.fromTime(start);
					start = new Date(d.getFullYear(), d.getMonth() + 1, d.getDate(), d.getHours(), d.getMinutes(), d.getSeconds()).getTime();
				}
				return range;
			case "year":
				var range = [];
				step = 60000 * 60 * 24 * 365;
				start = Math.ceil(start / step) * step;
				stop = Math.floor(stop / step) * step + step * .5;
				while (start <= stop)
				{
					range.push(start);
					var d = Date.fromTime(start);
					start = new Date(d.getFullYear() + 1, d.getMonth(), d.getDate(), d.getHours(), d.getMinutes(), d.getSeconds()).getTime();
				}
				return range;
		}
		var rsteps = Math.ceil((stop - start) / step);
		while (rsteps > _maxnumberofticks)
		{
			step *= 2;
			rsteps = Math.ceil((stop - start) / step);
		}
				
		start = Math.ceil(start / step) * step;
		stop = Math.floor(stop / step) * step + step * .5;
		return Floats.range(start, stop, step);
	}
}