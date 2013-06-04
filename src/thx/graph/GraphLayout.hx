package thx.graph;

import thx.error.Error;
using Arrays;

class GraphLayout<TNodeData, TEdgeData>
{
	public var graph(default, null) : Graph<TNodeData, TEdgeData>;
	public var length(default, null) : Int;

	var _layers : Array<Array<Int>>;
	var _cell : LayoutCell;
	var _map : Map<Int, Array<Int>>;
	var friendCell : FriendLayoutCell;
	public function new(graph : Graph<TNodeData, TEdgeData>, layers : Array<Array<Int>>)
	{
		this.graph = graph;
		this._layers = layers.map(function(arr) return arr.copy());
		this.friendCell = this._cell = new LayoutCell();
		_updateMap();
		length = _layers.length;
#if hxevents
		graph.nodes.onRemove.add(_nodeRemove);
#end
	}

	// not very efficient when just one node is removed
	function _updateMap()
	{
		_map = new Map ();
		each(function(cell, node) {
			_map.set(node.id, [cell.layer, cell.position]);
		});
	}

	public function clone()
	{
		return new GraphLayout(graph.clone(), layers());
	}

	public function each(f : LayoutCell -> GNode<TNodeData, TEdgeData> -> Void)
	{
		var layers = _layers.length,
			positions;
		for(layer in 0...layers)
		{
			positions = _layers[layer].length;
			for(position in 0...positions)
			{
				friendCell.update(layer, position, layers, positions);
				f(_cell, graph.nodes.get(_layers[layer][position]));
			}
		}
	}

	public function cell(node : GNode<TNodeData, TEdgeData>)
	{
		if(node.graph != graph)
			throw new Error("node doesn't belong to this graph");
		var pos = _map.get(node.id);
		if(null == pos)
			return null;
		return new LayoutCell(pos[0], pos[1], _layers.length, _layers[pos[0]].length);
	}

	public function nodeAt(layer : Int, position : Int)
	{
		var arr = _layers[layer];
		if(null == arr)
			return null;
		if(position >= arr.length)
			return null;
		var id = arr[position];
		return graph.nodes.get(id);
	}

	public function layer(i : Int)
	{
		return _layers[i].map(function(id) return graph.nodes.get(id));
	}

	public function layers()
	{
		var result = [];
		for(arr in _layers)
			result.push(arr.copy());
		return result;
	}

	public function crossings()
	{
		var tot = 0;
		for(i in 0..._layers.length-1)
			tot += arrayCrossings(graph, _layers[i], _layers[i+1]);
		return tot;
	}

	public static function arrayCrossings<TNodeData, TEdgeData>(graph : Graph<TNodeData, TEdgeData>, a : Array<Int>, b : Array<Int>)
	{
		var map = new Map (), c = 0;
		for(i in 0...b.length)
			map.set(b[i], i);
		if(a.length <= 1 || b.length <= 1)
			return c;

		for(i in 0...a.length)
		{
			var n1 = graph.nodes.get(a[i]);
			for(edge1 in n1.positives())
			{
				var p1 = map.get(edge1.head.id);
				if(null == p1)
					continue;
				for(j in i+1...a.length)
				{
					var n2 = graph.nodes.get(a[j]);
					for(edge2 in n2.positives())
					{
						var p2 = map.get(edge2.head.id);
						if(p2 < p1)
							c++;
					}
				}
			}
		}

		return c;
	}

	public function maxCells()
	{
		return Std.int(_layers.floatMax(function(arr) return arr.length));
	}

	function _nodeRemove(node : GNode<TNodeData, TEdgeData>)
	{
		var c = cell(node);
		_layers[c.layer].splice(c.position, 1);
		if(_layers[c.layer].length == 0)
			_layers.splice(c.layer, 1);
		_updateMap();
	}

	public function toString() return 'GraphLayout (${graph}, layers: ${_layers.length}, crossings : ${crossings()})';
}

class LayoutCell
{
	public var layer : Int;
	public var position : Int;
	public var layers : Int;
	public var positions : Int;
	public function new(layer = 0, position = 0, layers = 0, positions = 0)
	{
		this.layer     = layer;
		this.layers    = layers;
		this.position  = position;
		this.positions = positions;
	}

	private function update(layer : Int, position : Int, layers : Int, positions : Int) : Void
	{
		this.layer     = layer;
		this.layers    = layers;
		this.position  = position;
		this.positions = positions;
	}

	public function toString()
	{
		return 'LayoutCell, layer $layer ($layers), position $position ($positions)';
	}
}

typedef FriendLayoutCell =
{
	private function update(layer : Int, position : Int, layers : Int, positions : Int) : Void;
}