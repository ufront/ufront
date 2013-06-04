package thx.benchmark;

#if (flash || js)
import haxe.Timer;
#end
import thx.culture.Culture;

class SpeedTest
{
	public function new(repetitions = 100000, testDelay = 0, averages = 5)
	{
		this.testDelay = testDelay;
		this.averages = averages;
		this.repetitions = repetitions;
		this.tests = [];
		this.descriptions = [];
		this.reference = -1;
	}

	public function add(description : String, f : Int -> Void, isReference = false)
	{
		descriptions.push(description);
		if (isReference)
			reference = tests.length;
		tests.push(f);
		return this;
	}


	public function execute(?handler : String -> Void)
	{
		this.handler = handler;
		if (null == this.handler)
			this.handler = function(s) trace("\n" + s);
		results = [];
		for (i in 0...tests.length)
			results[i] = 0.0;
		toPerform = averages;
		start = getTimer();
		handleRound();
	}

	var reference : Int;
	var testDelay : Int;
	var averages : Int;
	var repetitions : Int;
	var tests : Array<Int -> Void> ;
	var descriptions : Array<String>;
	var results : Array<Float>;
	var toPerform : Int;
	var handler : String -> Void;
	var start : Float;

	function test(f : Int -> Void)
	{
		var start = getTimer();
		f(repetitions);
		return getTimer() - start;
	}

	static inline function getTimer() : Float
	{
#if flash
		return flash.Lib.getTimer();
#elseif php
		return php.Sys.cpuTime() * 1000;
#elseif neko
		return neko.Sys.cpuTime() * 1000;
#elseif cpp
		return cpp.Sys.cpuTime() * 1000;
#else
		return Date.now().getTime();
#end
	}

	function takeRound()
	{
		var indexes = Arrays.shuffle(Ints.range(0, tests.length));
		for (i in indexes)
			results[i] += test(tests[i]);
		handleRound();
	}

	function handleRound()
	{
		toPerform--;
		if (toPerform >= 0)
#if (flash || js)
			if(testDelay > 0)
				Timer.delay(takeRound, testDelay);
			else
				takeRound();
#else
			takeRound();
#end
		else
			handler(getOutput());
	}

	function getOutput()
	{
		var total = getTimer() - start;
		var sl = 0;
		var slowest = -1.0;
		var bd = 0;
		var ad = 0;
		var r = [];
		var sep = Culture.defaultCulture.number.decimalsSeparator;
		for (i in 0...descriptions.length)
		{
			var d = descriptions[i];
			if (d.length > sl)
				sl = d.length;
			if (slowest < 0 || slowest > results[i])
				slowest = results[i];

			var v = Floats.format(results[i] / averages, "D:1");
			var n = (v).split(sep);
			if (bd < n[0].length)
				bd = n[0].length;
			r.push(n);
		}
		sl += 3;
		var s = new StringBuf();
		s.add("test repeated " + Ints.format(repetitions) + " time(s), average on " + Ints.format(averages) + " cycle(s)\n\n");

		if (reference >= 0)
			slowest = results[reference];

		for (i in 0...descriptions.length)
		{
			var d = descriptions[i];
			s.add(StringTools.rpad(d, ".", sl));
			s.add(": ");

			s.add(StringTools.lpad(r[i][0], " ", bd));
			s.add(".");
			s.add(r[i][1]);

			s.add(" ms. ");
			if (reference < 0)
			{
				s.add(Floats.format(Math.round(100 * slowest / results[i]), "P"));
			} else if (reference == i) {
				s.add("        reference");
			} else {
				var v = Math.round(100 * slowest / results[i]);
				if (v < 100)
					s.add("(" + StringTools.lpad(Floats.format(100-v, "P:0"), " ", 5) + ") slower");
				else if(v == 100)
					s.add("        same");
				else
					s.add(" " + StringTools.lpad(Floats.format(v-100, "P:0"), " ", 5) + "  faster");
			}
			s.add("\n");
		}
		s.add("\n");
		s.add("total execution time: " + Floats.format(total, "I") + " ms.");
		return s.toString();
	}
}