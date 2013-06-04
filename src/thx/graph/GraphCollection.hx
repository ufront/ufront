package thx.graph;

#if hxevents
import hxevents.Dispatcher;
#end
import haxe.ds.StringMap;
import haxe.ds.IntMap;
using IntHashes;

class GraphCollection<TNodeData, TEdgeData, TData, TListItem : GraphElement<TData, TNodeData, TEdgeData>>
{
#if hxevents
	public var onRemove(default, null) : Dispatcher<TListItem>;
	public var onCreate(default, null) : Dispatcher<TListItem>;
#end
	var graph : Graph<TNodeData, TEdgeData>;
	var collection : IntMap<TListItem>;
	var nextid : Int;
	var idf : TData -> String;
	var _map : StringMap<TListItem>;

	public var length(get_length, null) : Int;
	function new(graph : Graph<TNodeData, TEdgeData>, ?idf : TData -> String)
	{
		nextid = 0;
		this.graph = graph;
		this.idf = idf;
		collection = new IntMap();
		_map = new StringMap();
		if(null != idf)
		{
			var add = collectionCreate;
			collectionCreate = function(item : TListItem)
			{
				_map.set(idf(item.data), item);
				add(item);
			}
			var rem = collectionRemove;
			collectionRemove = function(item : TListItem)
			{
				_map.remove(idf(item.data));
				rem(item);
			}
		}
#if hxevents
		onRemove = new Dispatcher();
		onCreate = new Dispatcher();
#end
	}

	public function getById(id : String) : TListItem
	{
		return _map.get(id);
	}

	public function get(id : Int) : TListItem return collection.get(id);

	public function has(item : TListItem) return item.graph == graph && collection.exists(item.id);

	inline function get_length() : Int return collection.count();

	dynamic function collectionCreate(item : TListItem)
	{
#if hxevents
		onCreate.dispatch(item);
#end
		collection.set(item.id, item);
	}

	dynamic function collectionRemove(item : TListItem)
	{
		collection.remove(item.id);
#if hxevents
		onRemove.dispatch(item);
#end
	}

	inline public function iterator() return collection.iterator();

	public function toString() return Iterables.map(collection, function(item : TListItem, _) : String return Std.string(item)).join(", ");
}