package thx.graph;

import thx.error.Error;

class GEdge<TNodeData, TEdgeData> extends GraphElement<TEdgeData, TNodeData, TEdgeData>
{
	public static function create<TNodeData, TEdgeData>(graph : Graph<TNodeData, TEdgeData>, id : Int, tail : GNode<TNodeData, TEdgeData>, head : GNode<TNodeData, TEdgeData>, weight : Float, ?data : TEdgeData)
	{
		return new GEdge(graph, id, tail, head, weight, data);
	}

	public var tail(default, null) : GNode<TNodeData, TEdgeData>;
	public var head(default, null) : GNode<TNodeData, TEdgeData>;
	public var weight : Float;

	function new(graph : Graph<TNodeData, TEdgeData>, id : Int, tail : GNode<TNodeData, TEdgeData>, head : GNode<TNodeData, TEdgeData>, weight : Float, ?data : TEdgeData)
	{
		super(graph, id, data);
		this.tail   = tail;
		this.head   = head;
		this.weight = weight;
	}

	override function destroy()
	{
		super.destroy();
		tail  = null;
		head  = null;
	}

	public function split(?times = 1, ?dataf : GEdge<TNodeData, TEdgeData> -> TNodeData, ?edgef : GEdge<TNodeData, TEdgeData> -> GEdge<TNodeData, TEdgeData> -> Int -> Void)
	{
		if(times < 1)
			throw new Error("the split times parameter must be an integer value greater than zero");
		if(null == edgef)
			edgef = function(_, _, _) {};
		if(null == dataf)
			dataf = function(_) return null;
		var last      = this,
			result    = [],
			node,
			e1, e2, g = last.graph;
		for(i in 0...times)
		{
			node = g.nodes.create(dataf(last));
			e1 = g.edges.create(last.tail, node, last.weight, last.data);
			e2 = g.edges.create(node, last.head, last.weight, last.data);
			g.edges.remove(last);
			edgef(e1, e2, i);
			last = e2;
			g = last.graph;
			result.push(e1);
		}
		result.push(last);
		return result;
	}

	public function other(node : GNode<TNodeData, TEdgeData>)
	{
		if(node.graph != graph)
			throw new Error("node is part of the edge graph");
		if(tail == node)
			return head;
		else if(head == node)
			return tail;
		else
			throw new Error("node is not part of the edge");
	}

	public function invert()
	{
		var inverted = graph.edges.create(head, tail, weight, data);
		this.remove();
		return inverted;
	}

	inline public function remove() friendRemove()._remove(this);

	inline function friendRemove() : { private function _remove(edge : GEdge<TNodeData, TEdgeData>) : Void; } return graph.edges;

	public function toString() return null == graph ? "Edge Destroyed" : 'Edge (n.$id, tail: n.${tail.id}, head: n.${head.id}, weight : $weight${null == data ? "" : ", data: "+data})';
}