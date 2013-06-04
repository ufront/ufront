package thx.graph;

import thx.error.Error;
import thx.graph.GraphElement;

class GraphNodes<TNodeData, TEdgeData> extends GraphCollection<TNodeData, TEdgeData, TNodeData, GNode<TNodeData, TEdgeData>>
{
	static public function newInstance<TNodeData, TEdgeData>(graph : Graph<TNodeData, TEdgeData>, ?nodeidf : TNodeData -> String) return new GraphNodes(graph, nodeidf);

	function new(graph : Graph<TNodeData, TEdgeData>,?nodeidf : TNodeData -> String)
	{
		super(graph, nodeidf);
	}

	function copyTo(graph : Graph<TNodeData, TEdgeData>) : GraphNodes<TNodeData, TEdgeData> 
	{
		var nodes = new GraphNodes(graph);
		for(node in this)
			nodes._create(node.id, node.data);
		nodes.nextid = this.nextid;
		return nodes;
	}

	public function create(?data : TNodeData)
	{
		return _create(++nextid, data);
	}

	function _create(id, ?data : TNodeData)
	{
		var n = GNode.create(graph, id, data);
		collectionCreate(n);
		return n;
	}

	public function remove(node : GNode<TNodeData, TEdgeData>)
	{
		if(node.graph != graph)
			throw new Error("the node is not part of this graph");
		_remove(node);
	}

	function _remove(node : GNode<TNodeData, TEdgeData>)
	{
		graph.edges.unlink(node);
		collectionRemove(node);
		GraphElement.friendDestroy(node).destroy();
	}

	public function clear()
	{
		var items = Iterables.array(collection).copy();
		for(item in items)
			remove(item);
	}
	override public function toString() return 'GraphNodes ($length): ${super.toString()}';
}