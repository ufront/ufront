package thx.graph;

using thx.graph.Graphs;
using Iterables;

class LongestPathLayer
{
	public function new(){}

	public function lay<TNodeData, TEdgeData>(graph : Graph<TNodeData, TEdgeData>) : Array<Array<Int>>
	{
		var clone = graph.clone(),
			layers = [[]];
		// move all sinks to L0
		for(node in clone.findSinks())
		{
			layers[0].push(node.id);
		}
		for(node in clone.nodes.filter(function(n) return !n.isSink()))
		{
			var pos   = distanceToASink(clone, node),
				layer = layers[pos];
			if(null == layer)
				layer = layers[pos] = [];
			layer.push(node.id);
		}
		layers.reverse();
		return layers;
	}

	static function distanceToASink<TNodeData, TEdgeData>(graph : Graph<TNodeData, TEdgeData>, node : GNode<TNodeData, TEdgeData>)
	{
		function traverse(it : Iterator<GEdge<TNodeData, TEdgeData>>, lvl : Int)
		{
			var max = lvl;
			for(edge in it)
			{
				if(edge.head.isSink())
					continue;
				else
					max = Ints.max(max, traverse(edge.head.positives(), lvl + 1));
			}
			return max;
		}
		return node.isIsolated() ? 0 : traverse(node.positives(), 1);
	}
}