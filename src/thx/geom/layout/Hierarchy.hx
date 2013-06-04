/**
 * Based on D3.js by Michael Bostock
 * @author Justin Donaldson
 */

package thx.geom.layout;
import thx.geom.layout.Hierarchy.Node;

class Hierarchy<T> extends AbstractHierarchy<T,Hierarchy<T>> {

	public function new(){
		super();
	}

	public static function nodeChildren<T>(d:Node<T>) : Array<Node<T>> {
	  return d.children;
	}

	public static function nodeValue<T>(d:Node<T>) : Float {
	  return d.value;
	}

	public static function nodeSort<T>(a:Node<T>, b:Node<T>) : Float {
	  return b.value - a.value;
	}

}

typedef Node<T> = {
	depth:Int,
	data:T,
	children:Array<Node<T>>,
	parent:Node<T>,
	value:Null<Float>
}

class AbstractHierarchy<T, This> extends IThis<This> {
	var _sort : T->T->Int;
	var _children : T->Int->Array<T>;
	var _value : T->Int->Float;

	public function new(){ //
		super();
/*		_sort = function(x : T, y : T) : Int { return untyped Std.int(x.value - y.value); }
		_children = function(n : T, _) { return  untyped n.children; }
		_value = function(n : T, _) { return  untyped n.value; }	*/
	}

	public function hierarchy(data : T, ?i:Int) {
		var nodes = new Array<Node<T>>();
		recurse(data, 0, nodes);
		return nodes;
	}

	// Recursively compute the node depth and value.
	// Also converts the data representation into a standard hierarchy structure.
	function recurse(data : T, depth : Int, nodes : Array<Node<T>>) : Node<T> {
		var datas = _children(data, depth);
		var node:Node<T> = { depth : depth, data : data, value : null,
							children : null, parent : null};
		nodes.push(node);
		if (datas != null) {
			var i = -1;
			var n = datas.length;
			var c = new Array<Node<T>>();
			node.children = c;
			var v = 0.0;
			var j = depth + 1;
			while (++i < n) {
				var d = this.recurse(datas[i], j, nodes);
				d.parent = node;
				c.push(d);
				v += d.value;
			}
			var t = this;
			if (_sort != null) c.sort( function(x,y){
				return t._sort(x.data, y.data);
				});
			if (_value != null) node.value = v;
		} else if (_value != null) {
			node.value = _value(data, depth);
		}
	return node;
	}

	// Recursively re-evaluates the node value.
	function _revalue(node:Node<T>, depth:Int) : Float{
		var children = node.children;
		var v = 0.0;
		if (children != null) {
			var i = -1;
			var n = children.length;
			var j = depth + 1;
			while (++i < n) v += _revalue(children[i], j);
		} else if (value != null) {
			v = _value(node.data, depth);
		}
		if (_value != null) node.value = v;
		return v;
	}


	public function sort(f : T->T->Int) {
		_sort = f;
		return This();
	}

	public function getSort() {
		return _sort;
	}

	public function children(c : T->Int->Array<T>){
		_children = c;
		return This();
	}

	public function getChildren(){
		return _children;
	}

	public function value(v : T->Int->Float) {
		_value = v;
		return This();
	}

	public function getValue(){
		return _value;
	}

	public function revalue(root : Node<T>){
		_revalue(root, 0);
		return root;
	}
}

private class IThis<This>{
	public function new(){}
	function This():This {return cast this;}
}
