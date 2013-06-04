package thx.graph;

using thx.graph.Graphs;
using Arrays;

class GreedySwitchDecrosser
{
	public function new(){}

	public function decross<TNodeData, TEdgeData>(layout : GraphLayout<TNodeData, TEdgeData>) : GraphLayout<TNodeData, TEdgeData>
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
			a, b;
		do
		{
			newlayers = layers.map(function(arr) return arr.copy());
			newlayout = new GraphLayout(graph, layers);
			totbefore = newlayout.crossings();
			for(i in 0...len)
			{
				a = newlayers[i];
				b = newlayers[i+1];
				decrossPair(graph, a, b);
			}
			crossings = new GraphLayout(graph, newlayers).crossings();
			layers = newlayers;
		} while(totbefore > crossings);
		return newlayout;
	}

	function decrossPair<TNodeData, TEdgeData>(graph : Graph<TNodeData, TEdgeData>, a : Array<Int>, b : Array<Int>)
	{
		var tot = GraphLayout.arrayCrossings(graph, a, b),
			ntot = tot,
			t;
		do
		{
			tot = ntot;
			for(i in 0...b.length-1)
			{
				swap(b, i);
				if((t = GraphLayout.arrayCrossings(graph, a, b)) >= ntot)
					swap(b, i)
				else
					ntot = t;
			}
		} while(ntot < tot);
	}

	function swap<T>(a : Array<T>, pos : Int)
	{
		var v = a[pos];
		a[pos] = a[pos+1];
		a[pos+1] = v;
	}

	public static function combined<TNodeData, TEdgeData>()
	{
		function decross<TNodeData, TEdgeData>(layout : GraphLayout<TNodeData, TEdgeData>) : GraphLayout<TNodeData, TEdgeData>
		{
			layout = new GreedySwitchDecrosser().decross(layout);
			return new GreedySwitch2Decrosser().decross(layout);
		}

		return {
			decross : decross
		}
	}

	public static function best<TNodeData, TEdgeData>()
	{
		function decross<TNodeData, TEdgeData>(layout : GraphLayout<TNodeData, TEdgeData>) : GraphLayout<TNodeData, TEdgeData>
		{
			var attempts = [new GreedySwitchDecrosser().decross(layout),
				new GreedySwitch2Decrosser().decross(layout),
				combined().decross(layout)];
			return attempts.min(function(layout) return layout.crossings());
		};
		return {
			decross : decross
		}
	}
}