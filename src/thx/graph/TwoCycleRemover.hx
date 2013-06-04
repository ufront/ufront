package thx.graph;

//  TODO add one cycled remover

class TwoCycleRemover
{
	public function new() { }

	public function remove<TNodeData, TEdgeData>(graph : Graph<TNodeData, TEdgeData>) : Array<{ tail : GNode<TNodeData, TEdgeData>, head : GNode<TNodeData, TEdgeData>, data : TEdgeData, weight : Float }>
	{
		var result = [];
		for(node in graph.nodes)
		{
			for(edge in node.positives())
			{
				var reverse = edge.head.predecessorBy(node);
				if(null == reverse)
					continue;
				result.push({
					tail   : reverse.tail,
					head   : reverse.head,
					weight : reverse.weight,
					data   : reverse.data
				});
				reverse.remove();
			}
		}
		return result;
	}
}