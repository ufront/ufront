package thx.date;

using Arrays;

class Milli
{
	static var CHUNKER = ~/([+-])?\s*(\d*.?\d+)\s*(ms|millisecond|second|minute|hour|day|[smhd])s?/;
	static var intervals = [{
		name  : "day",
		short : "d",
		time  : 1000 * 60 * 60 * 24
	}, {
		name  : "hour",
		short : "h",
		time  : 1000 * 60 * 60
	}, {
		name  : "minute",
		short : "m",
		time  : 1000 * 60 
	}, {
		name  : "second",
		short : "s",
		time  : 1000
	}, {
		name  : "millisecond",
		short : "ms",
		time  : 1
	}];
	static var map = (function() {
		var m = new Map ();
		intervals.each(function(item, _) {
			m.set(item.name,  item.time);
			m.set(item.short, item.time);
		});
		return m;
	})();
	public static function parse(s : String)
	{
		if(CHUNKER.match(s))
		{
			return 
				(CHUNKER.matched(1) == '-' ? -1 : 1)   // sign
				 * Std.parseFloat(CHUNKER.matched(2))  // numeric value
				 * map.get(CHUNKER.matched(3))         // period
				 + parse(CHUNKER.matchedRight())       // rest
			;
		} else {
			return 0;
		}
	}


	public static function toString(v : Float, shortFormat = true)
	{
		var len = intervals.length, cur = 0, s = [], item;
		while(cur < len && v >= 1)
		{
			item = intervals[cur];
			var div = Math.floor(v / item.time);
			if(div > 0)
			{
				if(shortFormat)
				{
					s.push(div + item.short);
				} else {
					s.push(div + " " + item.name + (div == 1 ? "" : "s"));
				}
				v = v - div * item.time;
			}
			cur++;
		}
		if(shortFormat)
		{
			return s.join("");
		} else {
			var last = s.pop();
			return (s.length > 0 ? [s.join(", ")] : []).concat([last]).join(" and ");
		}
	}
}