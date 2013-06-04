package thx.svg;

/**
 * Based on D3.js by Michael Bostock
 * @author Franco Ponticelli
 */

class Chord<TData, TChord>
{
	var _source : TData -> Int -> TChord;
	var _target : TData -> Int -> TChord;
	var _radius : TChord -> Int -> Float;
	var _startAngle : TChord -> Int -> Float;
	var _endAngle : TChord -> Int -> Float;
	public function new(source : TData -> Int -> TChord, target : TData -> Int -> TChord, radius : TChord -> Int -> Float, startAngle : TChord -> Int -> Float, endAngle : TChord -> Int -> Float)
	{
		this._source = source;
		this._target = target;
		this._radius = radius;
		this._startAngle = startAngle;
		this._endAngle = endAngle;
	}

	public function shape(d, i)
	{
		var s = subgroup(_source, d, i),
			t = subgroup(_target, d, i);
		return "M" + s.p0[0] + "," + s.p0[1]
			+ arc(s.r, s.p1) + (equals(s, t)
			? curve(s.r, s.p1, s.r, s.p0)
			: curve(s.r, s.p1, t.r, t.p0)
			+ arc(t.r, t.p1)
			+ curve(t.r, t.p1, s.r, s.p0))
			+ "Z";
	}

	function subgroup(f : TData -> Int -> TChord, d, i)
	{
		var sub = f(d, i),
			r = _radius(sub, i),
			a0 = _startAngle(sub, i) + LineInternals.arcOffset,
			a1 = _endAngle(sub, i) + LineInternals.arcOffset;
		return {
			r : r,
			a0 : a0,
			a1 : a1,
			p0 : [r * Math.cos(a0), r * Math.sin(a0)],
			p1 : [r * Math.cos(a1), r * Math.sin(a1)]
		};
	}

	function equals(a, b)
	{
		return a.a0 == b.a0 && a.a1 == b.a1;
	}

	function arc(r : Float, p : Array<Float>)
	{
		return "A" + r + "," + r + " 0 0,1 " + p;
	}

	function curve(r0 : Float, p0 : Array<Float>, r1 : Float, p1 : Array<Float>)
	{
		return "Q 0,0 " + p1;
	}

	public function getSource() return _source;
	public function source(v : TChord)
	{
		_source = function(_,_) return v;
		return this;
	}
	public function sourcef(v : TData -> Int -> TChord)
	{
		_source = v;
		return this;
	}

	public function getTarget() return _target;
	public function target(v : TChord)
	{
		_target = function(_,_) return v;
		return this;
	}
	public function targetf(v : TData -> Int -> TChord)
	{
		_target = v;
		return this;
	}

	public function getRadius() return _radius;
	public function radius(v : Float)
	{
		_radius = function(_,_) return v;
		return this;
	}
	public function radiusf(v : TChord -> Int -> Float)
	{
		_radius = v;
		return this;
	}

	public function getStartAngle() return _startAngle;
	public function startAngle(v : Float)
	{
		_startAngle = function(_,_) return v;
		return this;
	}
	public function startAnglef(v : TChord -> Int -> Float)
	{
		_startAngle = v;
		return this;
	}

	public function getEndAngle() return _endAngle;
	public function endAngle(v : Float)
	{
		_endAngle = function(_,_) return v;
		return this;
	}
	public function endAnglef(v : TChord -> Int -> Float)
	{
		_endAngle = v;
		return this;
	}

	public static function pathObject()
	{
		return new Chord<{source:ChordType,target:ChordType,radius:Float,startAngle:Float,endAngle:Float},ChordType>(
			function(d, _) return d.source,
			function(d, _) return d.target,
			function(d, _) return d.radius,
			function(d, _) return d.startAngle,
			function(d, _) return d.endAngle
		);
	}
}

private typedef ChordType =
{
	radius : Float,
	startAngle : Float,
	endAngle : Float,
}