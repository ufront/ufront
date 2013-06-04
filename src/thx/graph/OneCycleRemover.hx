package thx.graph;

class OneCycleRemover
{
	public function new() {}
	public function remove<TNodeData, TEdgeData>(graph : Graph<TNodeData, TEdgeData>) : Array<{ node : GNode<TNodeData, TEdgeData>, data : TEdgeData, weight : Float }>
	{
		var edge, result = [];
		for(node in graph.nodes)
		{
			edge = node.predecessorBy(node);
			if(null == edge)
				continue;
			result.push({
				node   : node,
				weight : edge.weight,
				data   : edge.data
			});
			edge.remove();
		}
		return result;
	}
}