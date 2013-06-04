/**
 * Based on D3.js by Michael Bostock
 * @author Franco Ponticelli
 */

package thx.geom.layout;

using Arrays;

class Chord
{
	var _chords : Array<ChordType>;
	var _groups : Array<ItemType>;
	var _matrix : Array<Array<Int>>;
	var _n : Int;
	var _padding : Float;
	var _sortGroups : Float -> Float -> Int;
	var _sortSubgroups : Float -> Float -> Int;
	var _sortChords : Float -> Float -> Int;
	public function new()
	{
		_padding = 0;
	}

	function relayout()
	{
		var subgroups : Map<String, ItemType> = new Map (),
			groupSums = [],
			groupIndex = Ints.range(_n),
			subgroupIndex = [],
			k : Float,
			x : Float,
			x0,
			i : Int,
			j : Int;

		_chords = [];
		_groups = [];

		// compute the sum
		k = 0;
		i = -1;
		while (++i < _n)
		{
			x = 0;
			j = -1;
			while (++j < _n)
			{
				x += _matrix[i][j];
			}
			groupSums.push(x);
			subgroupIndex.push(Ints.range(_n));
			k += x;
		}

		// sort groups
		if (null != _sortGroups)
		{
			var sg = _sortGroups;
			groupIndex.sort(function(a, b) {
				return sg(groupSums[a], groupSums[b]);
			});
		}

		// sort subgroups
		if (null != _sortSubgroups)
		{
			var ss = _sortSubgroups,
				m = _matrix;
			subgroupIndex.each(function(d, i) {
				d.sort(function(a, b) {
					return ss(m[i][a], m[i][b]);
				});
			});
		}

		// Convert the sum to scaling factor for [0, 2pi].
		k = (2 * Math.PI - _padding * _n) / k;

		// compute the start and end angle for each group and subgroup
		x = 0;
		i = -1;
		while (++i < _n)
		{
			x0 = x;
			j = -1;
			var di = -1;
			while (++j < _n)
			{
				di = groupIndex[i];
				var dj = subgroupIndex[i][j],
					v = _matrix[di][dj];
				subgroups.set(di + "-" + dj, {
					index : di,
					subindex : dj,
					startAngle : x,
					endAngle : x += v * k,
					value : 0.0 + v
				});
			}
			_groups.push({
				index : di,
				subindex : -1, ///
				startAngle : x0,
				endAngle : x,
				value : (x - x0) / k
			});
			x += _padding;
		}

		// generate _chords for each (non-empty) subgroup-subgroup link
		i = -1;
		while (++i < _n)
		{
			j = i - 1;
			while (++j < _n)
			{
				var source = subgroups.get(i + "-" + j),
					target = subgroups.get(j + "-" + i);
				if (null != source.value || null != target.value)
				{
					_chords.push({
						source : source,
						target : target
					});
				}
			}
		}
		if (null != _sortChords) resort();
	}

	function resort()
	{
		var sc = _sortChords;
		_chords.sort(function(a, b) {
			var aa = Math.min(a.source.value, a.target.value);
			var bb = Math.min(b.source.value, b.target.value);
			return sc(aa, bb);
		});
	}

	public function getMatrix()
	{
		return _matrix;
	}

	public function matrix(x)
	{
		_matrix = x;
		_n = _matrix.length;
		_chords = null;
		_groups = null;
		return this;
	}

	public function getPadding() return _padding

	public function padding(v : Float)
	{
		_padding = v;
		_chords = null;
		_groups = null;
		return this;
	}

	public function getSortGroups() return _sortGroups

	public function sortGroups(v : Float -> Float -> Int)
	{
		_sortGroups = v;
		_chords = null;
		_groups = null;
		return this;
	}

	public function getSortSubgroups() return _sortSubgroups

	public function sortSubgroups(v : Float -> Float -> Int)
	{
		_sortSubgroups = v;
		_chords = null;
		return this;
	}

	public function getSortChords() return _sortChords

	public function sortChords(v : Float -> Float -> Int)
	{
		_sortChords = v;
		if (null != _chords) resort();
		return this;
	}


	public function chords()
	{
		if (null == _chords)
			relayout();
		return _chords;
	}

	public function groups()
	{
		if (null == _groups)
			relayout();
		return _groups;
	}
}

typedef ChordType =
{
	source : ItemType,
	target : ItemType
}

typedef ItemType =
{
	index : Int,
	subindex : Int,
	startAngle : Float,
	endAngle : Float,
	value : Null<Float>
}