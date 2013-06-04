package thx.graph;

using thx.graph.Graphs;

class GreedyCyclePartitioner
{
	public function new()
	{
	}

	public function partition<TNodeData, TEdgeData>(graph : Graph<TNodeData, TEdgeData>) : { left : Array<GEdge<TNodeData, TEdgeData>>, right : Array<GEdge<TNodeData, TEdgeData>> }
	{
		var left  = [],
			right = [],
			clone = graph.clone(),
			n;
		while(!clone.empty())
		{
			// remove sinks
			while(null != (n = clone.findSink()))
			{
				for(edge in n.negatives())
				{
					// prepend edgesn to right
					right.unshift(graph.edges.get(edge.id));
					// remove edge
					edge.remove();
				}
				// remove sink
				n.remove();
			}

			// delete isolated vertices
			for(isolated in clone.findIsolateds())
				isolated.remove();

			// remove sources
			while(null != (n = clone.findSource()))
			{
				for(edge in n.positives())
				{
					// append edgesp to left
					left.push(graph.edges.get(edge.id));
					// remove edge
					edge.remove();
				}
				// remove source
				n.remove();
			}

			if(!clone.empty())
			{
				// choose a vertex such that edgesp - edgesn is max
				n = findMaxPositiveOverNegative(clone);
				for(edge in n.negatives())
				{
					// prepend edgesn to right
					right.unshift(graph.edges.get(edge.id));
					// remove edge
					edge.remove();
				}

				for(edge in n.positives())
				{
					// append edgesp to left
					left.push(graph.edges.get(edge.id));
					// remove edge
					edge.remove();
				}

				// remove from graph
				n.remove();
			}
		}
		return {
			left  : left,
			right : right
		}
	}

	static function findMaxPositiveOverNegative<TNodeData, TEdgeData>(graph : Graph<TNodeData, TEdgeData>)
	{
		var n = null, l = 0;
		for(node in graph.nodes)
		{
			var diff = node.positiveCount() - node.negativeCount();
			if(null == n || l < diff)
			{
				n = node;
				l = diff;
			}
		}
		return n;
	}
}
