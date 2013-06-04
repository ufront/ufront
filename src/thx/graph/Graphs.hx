package thx.graph;

import thx.collection.Set;
using Arrays;

class Graphs
{
	public static function crossings(a : Array<Node>, b : Array<Node>)
	{
		var map = new Map (), c = 0;
		for(i in 0...b.length)
			map.set(b[i].vertex, i);
		if(a.length <= 1 || b.length <= 1)
			return c;

		for(i in 0...a.length)
		{
			var n1 = a[i];
			for(dst1 in n1.edgesp)
			{
				var p1 = map.get(dst1);
				if(null == p1)
					continue;
				for(j in i+1...a.length)
				{
					var n2 = a[j];
					for(dst2 in n2.edgesp)
					{
						var p2 = map.get(dst2);
						if(p2 < p1)
							c++;
					}
				}
			}
		}

		return c;
	}

	public static function layoutCrossings(a : Array<Array<Node>>)
	{
		var tot = 0;
		for(i in 0...a.length-1)
		{
			tot += crossings(a[i], a[i+1]);
		}
		return tot;
	}

	public static function toMap(layout : Array<Array<Node>>) : Map<String, Node>
	{
		var map = new Map ();
		for(i in 0...layout.length)
		{
			for(j in 0...layout[i].length)
			{
				map.set(layout[i][j].vertex, layout[i][j]);
			}
		}
		return map;
	}

	public static function toVertices(layout : Array<Array<Node>>) : Array<String>
	{
		var result = [];
		for(i in 0...layout.length)
		{
			for(j in 0...layout[i].length)
			{
				result.push(layout[i][j].vertex);
			}
		}
		return result;
	}

	public static function toEdges(layout : Array<Array<Node>>) : Array<Edge>
	{
		var result = [];
		for(i in 0...layout.length)
		{
			for(j in 0...layout[i].length)
			{
				var v = layout[i][j].vertex;
				for(c in layout[i][j].edgesp)
					result.push({ a : v, b : c });
			}
		}
		return result;
	}

	public static function findMaxPositiveOverNegative(graph : Map<String, Node>)
	{
		var n = null, l = 0;
		for(node in graph)
		{
			var diff = node.edgesp.length - node.edgesn.length;
			if(null == n || l < diff)
			{
				n = node;
				l = diff;
			}
		}
		return n;
	}

	public static inline function isSink(node : Node) return node.edgesp.length == 0 && node.edgesn.length > 0;
	public static inline function isSource(node : Node) return node.edgesn.length == 0 && node.edgesp.length == 0;

	public static function findSink(graph : Map<String, Node>)
	{
		for(node in graph)
		{
			if(isSink(node))
				return node;
		}
		return null;
	}

	public static function findSource(graph : Map<String, Node>)
	{
		for(node in graph)
		{
			if(node.edgesn.length == 0 && node.edgesp.length > 0)
				return node;
		}
		return null;
	}

	public static function findAllIsolated(graph : Map<String, Node>)
	{
		var isolated = [];
		for(node in graph)
		{
			if(isSource(node))
				isolated.push(node);
		}
		return isolated;
	}

	public static function addConnection(graph : Map<String, Node>, a : String, b : String)
	{
		var path = findPath(graph, b, a);
		if(null != path && path.every(function(v,i) return i == 0 || i == path.length -1 || isDummy(v)))
		{
			// if a reversed path with only dummy nodes exists, replicate that connection in reverse
			path.reverse();
			addConnections(graph, path);
		} else {
			// otherwise just add the connection
			addConnections(graph, [a, b]);
		}
	}

	public static function addConnections(graph : Map<String, Node>, arr : Array<String>)
	{
		for(i in 0...arr.length - 1)
		{
			var a = arr[i],
				b = arr[i+1];
			graph.get(a).edgesp.push(b);
			graph.get(b).edgesp.push(a);
		}
	}

	public static function reverseConnection(graph : Map<String, Node>, a : String, b : String)
	{
		var path = findPath(graph, a, b);
		trace("REVERSING " + a + ", " + b);
		trace(path);
		if(null == path)
			return false;
		for(i in 0...path.length - 1)
		{
			var a = path[i],
				b = path[i+1],
				na = graph.get(a),
				nb = graph.get(b);
			na.edgesp.remove(b);
			na.edgesn.push(b);
			nb.edgesn.remove(a);
			nb.edgesp.push(a);
		}
		return true;
	}

	public static function findPath(graph : Map<String, Node>, a : String, b : String)
	{
		var traveled = new Set(),
			paths = [], t, r;
		function traverse(path : Array<String>, n : Node)
		{
			var totraverse = [];
			for(parent in n.edgesn)
			{
				if(parent == a)
				 	return path.concat([a]);
				else if(isSource(t = graph.get(parent)))
				 	continue;
				else
					totraverse.push(traverse.bind(path.concat([parent]), t));
			}
			for(t in totraverse)
			{
				if(null != (r = t()))
					return r;
			}
			return null;
		}
		var p = traverse([b], graph.get(b));
		if(null == p)
			return null;
		p.reverse();
		return p;
	}

	public static function isDummy(v : String) return v.substr(0, 1) == '#';
	static var id = 0;
	public static function createDummy(a : String, b : String, lvl : Int) return '#' + (++id);

	public static inline function removeNode(graph : Map<String, Node>, node : Node) graph.remove(node.vertex);
	public static inline function addNode(graph : Map<String, Node>, node : Node) graph.set(node.vertex, node);

	public static function clone(graph : Map<String, Node>)
	{
		var o = new Map ();
		for(node in graph)
		{
			addNode(o, {
				vertex : node.vertex,
				edgesn : node.edgesn.copy(),
				edgesp : node.edgesp.copy()
			});
		}
		return o;
	}

	public static inline function empty(graph : Map<String, Node>) return Hashes.empty(graph);
	public static inline function count(graph : Map<String, Node>) return Hashes.count(graph);
}