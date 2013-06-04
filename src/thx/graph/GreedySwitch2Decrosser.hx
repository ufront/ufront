package thx.graph;

using thx.graph.Graphs;
using Arrays;

class GreedySwitch2Decrosser extends GreedySwitchDecrosser
{
	override public function decross<TNodeData, TEdgeData>(layout : GraphLayout<TNodeData, TEdgeData>) : GraphLayout<TNodeData, TEdgeData>
	{
		var layers = layout.layers(),
			graph = layout.graph,
			newlayers ,
			newlayout = layout;
		if(layers.length <= 1)
			return new GraphLayout(layout.graph, layers);
		var totbefore,
			crossings,
			len = layers.length - 1,
			a, b, c;
		do
		{
			newlayers = layers.map(function(arr) return arr.copy());
			newlayout = new GraphLayout(graph, layers);
			totbefore = newlayout.crossings();
			for(i in 0...len)
			{
				a = newlayers[i-1];
				b = newlayers[i];
				c = newlayers[i+1];
				decrossTriplet(graph, a, b, c);
			}
			crossings = new GraphLayout(graph, newlayers).crossings();
			layers = newlayers;
		} while(totbefore > crossings);
		return newlayout;
	}

	function decrossTriplet<TNodeData, TEdgeData>(graph : Graph<TNodeData, TEdgeData>, a : Array<Int>, b : Array<Int>, c : Array<Int>)
	{
		if(null == a)
		{
			decrossPair(graph, b, c);
		} else if(null == c)
		{
			decrossPair(graph, a, b);
		} else {
			var tot = GraphLayout.arrayCrossings(graph, a, b) + GraphLayout.arrayCrossings(graph, b, c),
				ntot = tot,
				t;
			do
			{
				tot = ntot;
				for(i in 0...b.length-1)
				{
					swap(b, i);
					if((t = GraphLayout.arrayCrossings(graph, a, b) + GraphLayout.arrayCrossings(graph, b, c)) >= ntot)
						swap(b, i)
					else
						ntot = t;
				}
			} while(ntot < tot);
		}
	}
}