package thx.graph;

class GraphElement<TData, TNodeData, TEdgeData>
{
	public var graph(default, null) : Graph<TNodeData, TEdgeData>;
	public var id(default, null) : Int;
	public var data(default, null) : Null<TData>;
	private function new(graph : Graph<TNodeData, TEdgeData>, id : Int, ?data : Null<TData>)
	{
		this.id = id;
		this.data = data;
		this.graph = graph;
	}

	function destroy()
	{
		graph = null;
		id = -1;
	}

	public function destroyed() return null == graph;

	public static inline function friendDestroy<TData, TNodeData, TEdgeData>(item : GraphElement<TData, TNodeData, TEdgeData>) : FriendDestroy return item;
}

typedef FriendDestroy = {
	private function destroy() : Void;
}