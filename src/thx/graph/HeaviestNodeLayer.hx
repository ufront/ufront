package thx.graph;

using Iterables;
using Arrays;

class HeaviestNodeLayer
{
	public function new(){}

	public function lay<TNodeData, TEdgeData>(graph : Graph<TNodeData, TEdgeData>) : Array<Array<Int>>
	{
		var layers = [],
			nodes = graph.nodes.array().order(function(a, b) return Floats.compare(b.positiveWeight(), a.positiveWeight()));


		function getLayer(index : Int)
		{
			var layer = layers[index];
			if(null == layer)
				layer = layers[index] = [];
			return layer;
		}

		function addAt(node, lvl)
		{
			if(!nodes.remove(node))
				return;
			var layer = getLayer(lvl);
			layer.push(node.id);
			for(edge in node.positives())
			{
				addAt(edge.head, lvl+1);
			}
		}

		while(nodes.length > 0)
			addAt(nodes[0], 0);

		for(layer in layers)
		{
			layer.order(function(ida, idb) {
				return Floats.compare(graph.nodes.get(idb).positiveWeight(), graph.nodes.get(ida).positiveWeight());
			});
		}

		return layers;
	}
}