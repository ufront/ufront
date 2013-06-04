package thx.graph;

import thx.error.Error;
using Arrays;

class GraphEdges<TNodeData, TEdgeData> extends GraphCollection<TNodeData, TEdgeData, TEdgeData, GEdge<TNodeData, TEdgeData>>
{
	static public function newInstance<TNodeData, TEdgeData>(graph : Graph<TNodeData, TEdgeData>, ?edgeidf : TEdgeData -> String) return new GraphEdges(graph, edgeidf);

	var edgesp : Map<Int, Array<Int>>;
	var edgesn : Map<Int, Array<Int>>;

	function new(graph : Graph<TNodeData, TEdgeData>, ?edgeidf : TEdgeData -> String)
	{
		super(graph, edgeidf);
		edgesp = new Map ();
		edgesn = new Map ();
	}

	function copyTo(graph : Graph<TNodeData, TEdgeData>) : GraphEdges<TNodeData, TEdgeData> 
	{
		var edges = new GraphEdges(graph),
			nodes = graph.nodes,
			tail,
			head;
		for(edge in this)
		{
			tail = nodes.get(edge.tail.id);
			head = nodes.get(edge.head.id);
			edges._create(edge.id, tail, head, edge.weight, edge.data);
		}
		edges.nextid = this.nextid;
		return edges;
	}

	public function create(tail : GNode<TNodeData, TEdgeData>, head : GNode<TNodeData, TEdgeData>, ?weight : Float = 1.0, ?data : TEdgeData)
	{
		if(tail.graph != head.graph || tail.graph != graph)
			throw new Error("can't create an edge between nodes on different graphs");
		return _create(++nextid, tail, head, weight, data);
	}

	function _create(id : Int, tail : GNode<TNodeData, TEdgeData>, head : GNode<TNodeData, TEdgeData>, weight : Float, ?data : TEdgeData)
	{
		var e = GEdge.create(graph, id, tail, head, weight, data);
		collectionCreate(e);
		connections(tail.id, edgesp).push(id);
		connections(head.id, edgesn).push(id);
		return e;
	}

	public function remove(edge : GEdge<TNodeData, TEdgeData>)
	{
		if(edge.graph != graph)
			throw new Error("remove: the edge is not part of this graph");
		_remove(edge);
	}

	function _remove(edge : GEdge<TNodeData, TEdgeData>)
	{
		collectionRemove(edge);
		removeConnection(edge.id, edge.tail.id, edgesp);
		removeConnection(edge.id, edge.head.id, edgesn);
		GraphElement.friendDestroy(edge).destroy();
	}

	public function unlink(node : GNode<TNodeData, TEdgeData>)
	{
		if(node.graph != graph)
			throw new Error("unlink: the node is not part of this graph");
		_unlink(node, edgesp);
		_unlink(node, edgesn);
	}

	function positives(node : GNode<TNodeData, TEdgeData>) : Iterator<GEdge<TNodeData, TEdgeData>>
	{
		return _edges(node.id, edgesp).iterator();
	}

	function negatives(node : GNode<TNodeData, TEdgeData>) : Iterator<GEdge<TNodeData, TEdgeData>>
	{
		return _edges(node.id, edgesn).iterator();
	}

	function sortPositives(node : GNode<TNodeData, TEdgeData>, sortf : GEdge<TNodeData, TEdgeData> -> GEdge<TNodeData, TEdgeData> -> Int)
	{
		_sort(node, sortf, edgesp);
	}

	function sortNegatives(node : GNode<TNodeData, TEdgeData>, sortf : GEdge<TNodeData, TEdgeData> -> GEdge<TNodeData, TEdgeData> -> Int)
	{
		_sort(node, sortf, edgesn);
	}

	function _sort(node : GNode<TNodeData, TEdgeData>, sortf : GEdge<TNodeData, TEdgeData> -> GEdge<TNodeData, TEdgeData> -> Int, collection : Map<Int, Array<Int>>)
	{
		var arr = collection.get(node.id);
		if(null == arr)
			return;
		arr.sort(function(ida : Int, idb : Int) {
			var ea = graph.edges.get(ida),
				eb = graph.edges.get(idb);
			return sortf(ea, eb);
		});
	}

	function edges(node : GNode<TNodeData, TEdgeData>) : Iterator<GEdge<TNodeData, TEdgeData>>
	{
		return _edges(node.id, edgesp).concat(_edges(node.id, edgesn)).iterator();
	}

	function positiveCount(node : GNode<TNodeData, TEdgeData>) : Int
	{
		return _edgeids(node.id, edgesp).length;
	}

	function negativeCount(node : GNode<TNodeData, TEdgeData>) : Int
	{
		return _edgeids(node.id, edgesn).length;
	}

	function edgeCount(node : GNode<TNodeData, TEdgeData>) : Int
	{
		return _edgeids(node.id, edgesp).length + _edgeids(node.id, edgesn).length;
	}

	function _edgeids(id : Int, collection : Map<Int, Array<Int>>)
	{
		var r = collection.get(id);
		if(null == r)
			r = [];
		return r;
	}

	function _edges(id : Int, collection : Map<Int, Array<Int>>) : Array<GEdge<TNodeData, TEdgeData>>
	{
		return _edgeids(id, collection).map(function(eid) return get(eid));
	}

	function unlinkPositives(node : GNode<TNodeData, TEdgeData>)
	{
		if(node.graph != graph)
			throw new Error("unlinkePositives: the node is not part of this graph");
		_unlink(node, edgesp);
	}

	function unlinkNegatives(node : GNode<TNodeData, TEdgeData>)
	{
		if(node.graph != graph)
			throw new Error("unlinkeNegatives: the node is not part of this graph");
		_unlink(node, edgesn);
	}

	function _unlink(node : GNode<TNodeData, TEdgeData>, connections : Map<Int, Array<Int>>)
	{
		var ids = connections.get(node.id);
		if(null == ids)
			return;
		ids = ids.copy();
		for(id in ids)
		{
			var edge = get(id);
			if(null == edge || null == edge.graph) // not sure why the edge should not exist
				continue;
			_remove(edge);
		}
		connections.remove(node.id);
	}

	public function clear()
	{
		var items = Iterables.array(collection).copy();
		for(item in items)
			remove(item);
	}

	function connections(id : Int, connections : Map<Int, Array<Int>>)
	{
		var c = connections.get(id);
		if(null == c)
			connections.set(id, c = []);
		return c;
	}

	function removeConnection(edgeid : Int, nodeid : Int, connections : Map<Int, Array<Int>>)
	{
		var c = connections.get(nodeid);
		if(null == c)
			return;
		c.remove(edgeid);
		if(c.length == 0)
			connections.remove(nodeid);
	}

	override public function toString() return 'GraphEdges ($length): ${super.toString()}';
}

typedef FriendGraphEdges<TNodeData, TEdgeData> =
{
//	private function unlink(node : GNode<TNodeData, TEdgeData>) : Void;
	private function positives(node : GNode<TNodeData, TEdgeData>) : Iterator<GEdge<TNodeData, TEdgeData>>;
	private function negatives(node : GNode<TNodeData, TEdgeData>) : Iterator<GEdge<TNodeData, TEdgeData>>;
	private function sortPositives(node : GNode<TNodeData, TEdgeData>, sortf : GEdge<TNodeData, TEdgeData> -> GEdge<TNodeData, TEdgeData> -> Int) : Void;
	private function sortNegatives(node : GNode<TNodeData, TEdgeData>, sortf : GEdge<TNodeData, TEdgeData> -> GEdge<TNodeData, TEdgeData> -> Int) : Void;
	private function edges(node : GNode<TNodeData, TEdgeData>) : Iterator<GEdge<TNodeData, TEdgeData>>;
	private function positiveCount(node : GNode<TNodeData, TEdgeData>) : Int;
	private function negativeCount(node : GNode<TNodeData, TEdgeData>) : Int;
	private function edgeCount(node : GNode<TNodeData, TEdgeData>) : Int;
}