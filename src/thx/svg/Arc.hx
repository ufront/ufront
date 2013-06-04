package thx.svg;

/**
 * Based on D3.js by Michael Bostock
 * @author Franco Ponticelli
 */

class Arc<T>
{
	var _r0 : T -> Int -> Float;
	var _r1 : T -> Int -> Float;
	var _a0 : T -> Int -> Float;
	var _a1 : T -> Int -> Float;
	public function new()
	{
		_r0 = function(_,_) return 0;
		_r1 = function(_,_) return 1;
		_a0 = function(_,_) return 0;
		_a1 = function(_,_) return Math.PI;
	}

	public function getInnerRadius() return _r0;
	public function innerRadius(v : Float) return innerRadiusf(function(_,_) return v);
	public function innerRadiusf(v : T -> Int -> Float)
	{
		_r0 = v;
		return this;
	}

	public function getOuterRadius() return _r1;
	public function outerRadius(v : Float) return outerRadiusf(function(_,_) return v);
	public function outerRadiusf(v : T -> Int -> Float)
	{
		_r1 = v;
		return this;
	}

	public function getStartAngle() return _a0;
	public function startAngle(v : Float) return startAnglef(function(_,_) return v);
	public function startAnglef(v : T -> Int -> Float)
	{
		_a0 = v;
		return this;
	}

	public function getEndAngle() return _a1;
	public function endAngle(v : Float) return endAnglef(function(_,_) return v);
	public function endAnglef(v : T -> Int -> Float)
	{
		_a1 = v;
		return this;
	}

	public function shape(?d : T, ?i : Int)
	{
        var a0 = _a0(d,i) + LineInternals.arcOffset,
			a1 = _a1(d,i) + LineInternals.arcOffset,
			da = a1 - a0,
			df = da < Math.PI ? "0" : "1",
			c0 = Math.cos(a0),
			s0 = Math.sin(a0),
			c1 = Math.cos(a1),
			s1 = Math.sin(a1),
			r0 = _r0(d, i),
			r1 = _r1(d, i)
		;
		return da >= LineInternals.arcMax
			? (r0 != 0
			? "M0," + r1
			+ "A" + r1 + "," + r1 + " 0 1,1 0," + (-r1)
			+ "A" + r1 + "," + r1 + " 0 1,1 0," + r1
			+ "M0," + r0
			+ "A" + r0 + "," + r0 + " 0 1,1 0," + (-r0)
			+ "A" + r0 + "," + r0 + " 0 1,1 0," + r0
			+ "Z"
			: "M0," + r1
			+ "A" + r1 + "," + r1 + " 0 1,1 0," + (-r1)
			+ "A" + r1 + "," + r1 + " 0 1,1 0," + r1
			+ "Z")
			: (r0 != 0
			? "M" + r1 * c0 + "," + r1 * s0
			+ "A" + r1 + "," + r1 + " 0 " + df + ",1 " + r1 * c1 + "," + r1 * s1
			+ "L" + r0 * c1 + "," + r0 * s1
			+ "A" + r0 + "," + r0 + " 0 " + df + ",0 " + r0 * c0 + "," + r0 * s0
			+ "Z"
			: "M" + r1 * c0 + "," + r1 * s0
			+ "A" + r1 + "," + r1 + " 0 " + df + ",1 " + r1 * c1 + "," + r1 * s1
			+ "L0,0"
			+ "Z");
	}

	public function centroid(?d : T, ?i : Int)
	{
		var r = (_r0(d, i) + _r1(d, i)) / 2,
			a = (_a0(d, i) + _a1(d, i)) / 2 + LineInternals.arcOffset;
		return [Math.cos(a) * r, Math.sin(a) * r];
	}

	public static function fromObject()
	{
		return new Arc<{ innerRadius : Float, outerRadius : Float, startAngle : Float, endAngle : Float }>()
			.innerRadiusf(function(d, _) return d.innerRadius)
			.outerRadiusf(function(d, _) return d.outerRadius)
			.startAnglef(function(d, _) return d.startAngle)
			.endAnglef(function(d, _) return d.endAngle)
		;
	}

	public static function fromAngleObject()
	{
		return new Arc<{ startAngle : Float, endAngle : Float }>()
			.startAnglef(function(d, _) return d.startAngle)
			.endAnglef(function(d, _) return d.endAngle)
		;
	}
}