package thx.graph;

using Arrays;
using thx.graph.Graphs;

//  TODO add one cycled remover

class SugiyamaMethod<TNodeData, TEdgeData>
{
	var partitioner : Partitioner<TNodeData, TEdgeData>;
	var layer       : Layer<TNodeData, TEdgeData>;
	var splitter    : Splitter<TNodeData, TEdgeData>;
	var decrosser   : Decrosser<TNodeData, TEdgeData>;

	public function new(?partitioner : Partitioner<TNodeData, TEdgeData>, ?layer : Layer<TNodeData, TEdgeData>, ?splitter : Splitter<TNodeData, TEdgeData>, ?decrosser : Decrosser<TNodeData, TEdgeData>)
	{
		var id = 0;
		this.partitioner = null == partitioner ? new GreedyCyclePartitioner()     : partitioner;
		this.layer       = null == layer       ? new LongestPathLayer()           : layer;
		this.splitter    = null == splitter    ? new EdgeSplitter()               : splitter;
		this.decrosser   = null == decrosser   ? GreedySwitchDecrosser.best()     : decrosser;
	}

	public function resolve(graph : Graph<TNodeData, TEdgeData>, ?nodef : GEdge<TNodeData, TEdgeData> -> TNodeData, ?edgef : GEdge<TNodeData, TEdgeData> -> GEdge<TNodeData, TEdgeData> -> Int -> Void) : GraphLayout<TNodeData, TEdgeData>
	{
		var onecycles = new OneCycleRemover().remove(graph),
			twocycles = new TwoCycleRemover().remove(graph);

		var partitions = partitioner.partition(graph),
			reversed = new Map ();
		(partitions.left.length > partitions.right.length ? partitions.right : partitions.left).each(function(edge, _) {
			reversed.set(edge.tail.id +"-"+edge.head.id, [edge.invert()]);
		});

		var layers = layer.lay(graph);

		var layout = new GraphLayout(graph, layers);

		var splits = [];
		layout = splitter.split(layout, splits, nodef, edgef);
		splits.each(function(split, _) {
			var key  = split.last().head.id+"-"+split.first().tail.id;
			if(reversed.exists(key))
				reversed.set(key, split);
		});

		layout = decrosser.decross(layout);

		// restore reversed
		for(path in reversed)
		{
			path.each(function(edge, _) {
				var e = edge.invert();
			});
		}

		// restore two cycles
		for(item in twocycles)
			layout.graph.edges.create(item.tail, item.head, item.weight, item.data);

		// restore one cycle
		for(item in onecycles)
			layout.graph.edges.create(item.node, item.node, item.weight, item.data);

		return layout;
	}
}

typedef Partitioner<TNodeData, TEdgeData> = {
	public function partition(graph : Graph<TNodeData, TEdgeData>) : { left : Array<GEdge<TNodeData, TEdgeData>>, right : Array<GEdge<TNodeData, TEdgeData>>};
}

typedef Layer<TNodeData, TEdgeData> = {
	public function lay(graph : Graph<TNodeData, TEdgeData>) : Array<Array<Int>>;
}

typedef Splitter<TNodeData, TEdgeData> = {
	public function split(layout : GraphLayout<TNodeData, TEdgeData>, splitted : Array<Array<GEdge<TNodeData, TEdgeData>>>, ?nodef : GEdge<TNodeData, TEdgeData> -> TNodeData, ?splitf : GEdge<TNodeData, TEdgeData> -> GEdge<TNodeData, TEdgeData> -> Int -> Void) : GraphLayout<TNodeData, TEdgeData>;
}

typedef Decrosser<TNodeData, TEdgeData> = {
	public function decross(layout : GraphLayout<TNodeData, TEdgeData>) : GraphLayout<TNodeData, TEdgeData>;
}