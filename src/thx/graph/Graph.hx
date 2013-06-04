package thx.graph;

import thx.collection.Set;
using Arrays;
using Iterables;

class Graph<TNodeData, TEdgeData>
{
	public var nodes(default, null) : GraphNodes<TNodeData, TEdgeData>;
	public var edges(default, null) : GraphEdges<TNodeData, TEdgeData>;

	public function new(?nodeidf : TNodeData -> String, ?edgeidf : TEdgeData -> String)
	{
		nodes = GraphNodes.newInstance(this, nodeidf);
		edges = GraphEdges.newInstance(this, edgeidf);
	}

	inline public function empty()
	{
		return nodes.count() == 0;
	}

	public function clear()
	{
		edges.clear();
		nodes.clear();
	}

	public function clone()
	{
		var g = new Graph();
		g.nodes = friendNodes(nodes).copyTo(g);
		g.edges = friendEdges(edges).copyTo(g);
		return g;
	}

	public function findSinks()
	{
		return nodes.filter(function(n) return n.isSink());
	}

	public function findSink()
	{
		return nodes.firstf(function(n) return n.isSink());
	}

	public function findSources()
	{
		return nodes.filter(function(n) return n.isSource());
	}

	public function findSource()
	{
		return nodes.firstf(function(n) return n.isSource());
	}

	public function findIsolateds()
	{
		return nodes.filter(function(n) return n.isIsolated());
	}

	public function findIsolated()
	{
		return nodes.firstf(function(n) return n.isIsolated());
	}

	public function paths(a : GNode<TNodeData, TEdgeData>, b : GNode<TNodeData, TEdgeData>)
	{
		var traveled = new Set<Int>(),
			paths = [], other, r;
		function traverse(path : Array<GEdge<TNodeData, TEdgeData>>, n : GNode<TNodeData, TEdgeData>)
		{
			var totraverse = [];
			for(edge in n.edges())
			{
				other = edge.other(n);
				if(traveled.exists(edge.id))
					continue;
				else if(other == b)
				 	paths.push(path.concat([edge]));
				else if(!other.isSource())
					totraverse.push(traverse.bind(path.concat([edge]), other));
				traveled.add(edge.id);
			}
			for(t in totraverse)
				t();
		}
		traverse([], a);
		return paths;
	}

	public function path(a : GNode<TNodeData, TEdgeData>, b : GNode<TNodeData, TEdgeData>, weighted = false)
	{
		return pickPath(paths(a, b), weighted);
	}

	public function directedPaths(a : GNode<TNodeData, TEdgeData>, b : GNode<TNodeData, TEdgeData>)
	{
		var traveled = new Set<Int>(),
			paths = [], other, r;
		function traverse(path : Array<GEdge<TNodeData, TEdgeData>>, n : GNode<TNodeData, TEdgeData>)
		{
			var totraverse = [];
			for(edge in n.positives())
			{
				other = edge.head;
				if(traveled.exists(edge.id))
					continue;
				else if(other == b)
				 	paths.push(path.concat([edge]));
				else if(!other.isSink() && !other.isSource())
					totraverse.push(traverse.bind(path.concat([edge]), other));
				traveled.add(edge.id);
			}
			for(t in totraverse)
				t();
		}
		traverse([], a);
		return paths;
	}

	public function directedPath(a : GNode<TNodeData, TEdgeData>, b : GNode<TNodeData, TEdgeData>, weighted = false)
	{
		return pickPath(directedPaths(a, b), weighted);
	}

	function pickPath(paths : Array<Array<GEdge<TNodeData, TEdgeData>>>, weighted : Bool)
	{
		if(paths.length == 0)
			return null;
		if(weighted)
		{
			return paths.min(function(arr) {
				return arr.reduce(function(acc, edge, _) {
					return acc + edge.weight;
				}, 0);
			});
		} else
		{
			return paths.min(function(arr) return arr.length);
		}
	}

	public function toString() return 'Graph (nodes: ${nodes.length}, edges: ${edges.length})';

	static inline function friendNodes<TNodeData, TEdgeData>(friend : GraphNodes<TNodeData, TEdgeData>) : FriendNodesCopy<TNodeData, TEdgeData> return friend;
	static inline function friendEdges<TNodeData, TEdgeData>(friend : GraphEdges<TNodeData, TEdgeData>) : FriendEdgesCopy<TNodeData, TEdgeData> return friend;
}

typedef FriendNodesCopy<TNodeData, TEdgeData> = {
	private function copyTo(g : Graph<TNodeData, TEdgeData>) : GraphNodes<TNodeData, TEdgeData>;
}

typedef FriendEdgesCopy<TNodeData, TEdgeData> = {
	private function copyTo(g : Graph<TNodeData, TEdgeData>) : GraphEdges<TNodeData, TEdgeData>;
}
