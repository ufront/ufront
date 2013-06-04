// Node-link tree diagram using the Reingold-Tilford "tidy" algorithm
package thx.geom.layout;
import thx.svg.Diagonal;
import thx.geom.layout.Hierarchy;
using Arrays;

/**
 * Based on D3.js by Michael Bostock
 * @author Justin Donaldson
 */

class Tree<T> extends AbstractTree<T,Tree<T>>{

	public function new(){
		super();
	}
	// Returns an array of source+target objects for the specified nodes.
	public static function treeLinks<T>(nodes:Array<TreeNode<T>>) : Array<SourceTarget<TreeNode<T>>> {

		return Arrays.flatten(nodes.map( function(parent,_) {
			var map_arr = parent.children != null ? parent.children: new Array<TreeNode<T>>();

			return map_arr.map(function(child:TreeNode<T>,_) {
				return {source: parent, target: child};
			});
		}));
	}


	public static function treeLinkDiagonal(){
		return new Diagonal()
			.sourcef(function(x:SourceTarget<TreeNode<Dynamic>>,_){
				return [x.source.x, x.source.y];
			})
			.targetf(function(x,_){
				return [x.target.x, x.target.y];
			});

	}


	public static function treeSeparation<T>(a:TreeNode<T>, b:TreeNode<T>) {
		return a.parent == b.parent ? 1 : 2;
	}
		// function SeparationRadial(a, b) {
	//	return (a.parent == b.parent ? 1 : 2) / a.depth;
	// }

	public static function left<T>(node:TreeNode<T>)  {
		return node.children != null ? node.children[0] : node._tree.thread;
	}
	public static function right<T>(node:TreeNode<T>) {
		return node.children != null ? node.children[node.children.length - 1] : node._tree.thread;
	}
	public static function search<T>(node:TreeNode<T>, compare:TreeNode<T>->TreeNode<T>->Float) {
		var children = node.children;
		if (children != null) {
			var child,
			n = children.length,
			i = -1;
			while (++i < n) {
				var child = Tree.search(children[i], compare);
				if (compare(child, node) > 0) {
					node = child;
				}
			}
		}
		return node;
	}
	public static function rightmost<T>(a:TreeNode<T>, b:TreeNode<T>) {
		return a.x - b.x;
	}
	public static function leftmost<T>(a:TreeNode<T>, b:TreeNode<T>) {
		return b.x - a.x;
	}
	public static function deepest<T>(a:TreeNode<T>, b:TreeNode<T>) {
		return a.depth - b.depth;
	}
	public static function visit<T>(node:TreeNode<T>, previousSibling:TreeNode<T>, callbackf:TreeNode<T>->TreeNode<T>->Void) {
		var children = node.children;
		if (children != null) {
			var child,
			previousChild = null,
			i = -1,
			n = children.length;
			while (++i < n) {
				child = children[i];
				visit(child, previousChild, callbackf);
				previousChild = child;
			}
		}
		if (callbackf != null) callbackf(node, previousSibling);
	}
	public static function visitAfter(node, callbackf) {
		visit(node, null, callbackf);
	}
	public static function shift<T>(node:TreeNode<T>) {
		var shift = 0.0,
		change = 0.0,
		children = node.children,
		i = children.length,
		child;
		while (--i >= 0) {
			child = children[i]._tree;
			child.prelim += shift;
			child.mod += shift;
			shift += child.shift + (change += child.change);
		}
	}
	public static function move<T>(ancestor:TreeNode<T>, node:TreeNode<T>, shift:Float) {
		var ancestor = ancestor._tree;
		var node = node._tree;
		var change = shift / (node.number - ancestor.number);
		ancestor.change += change;
		node.change -= change;
		node.shift += shift;
		node.prelim += shift;
		node.mod += shift;
	}
	public static function ancestor<T>(vim:TreeNode<T>, node:TreeNode<T>, ancestor:TreeNode<T>) {
		return vim._tree.ancestor.parent == node.parent
		? vim._tree.ancestor
		: ancestor;
	}
}


class AbstractTree<T,This> extends AbstractHierarchy<T,This>{

	var _separation:TreeNode<T>->TreeNode<T>->Float;
	var _size : Array<Float>;
	var _links : Array<Node<T>>->Array<Link<T>>;
	var _treeHierarchy : T->Int->Array<Node<T>>;

	public function new(){
		super();
		_treeHierarchy = hierarchy;
		_separation = Tree.treeSeparation;
	}

	public function links(x){
		_links = x;
		return this;
	}
	public function getLinks(x){
		return _links;
	}

	public function separation(x){
		_separation = x;
		return this;
	}

	public function getSeparation(x){
		return _separation;
	}

	public function size(x) {
		_size = x;
		return this;
	}
	public function getSize(x){
		return _size;
	}

	public function treeHierarchy(x){
		_treeHierarchy = x;
		return this;
	}
	public function getTreeHierarchy(x){
		return _treeHierarchy;
	}

	function apportion(node:TreeNode<T>, previousSibling:TreeNode<T>, ancestor:TreeNode<T>) {
		if (previousSibling != null) {
			var vip = node;
			var vop = node;
			var vim = previousSibling;
			var vom = node.parent.children[0];
			var sip = vip._tree.mod;
			var sop = vop._tree.mod;
			var sim = vim._tree.mod;
			var som = vom._tree.mod;

			var shift = Math.NaN;
			vim = Tree.right(vim);
			vip = Tree.left(vip);


			while (vim != null && vip != null) {
				vom = Tree.left(vom);
				vop = Tree.right(vop);
				vop._tree.ancestor = node;
				shift = vim._tree.prelim + sim - vip._tree.prelim - sip + _separation(vim, vip);
				if (shift > 0) {
					Tree.move(Tree.ancestor(vim, node, ancestor), node, shift);
					sip += shift;
					sop += shift;
				}
				sim += vim._tree.mod;
				sip += vip._tree.mod;
				som += vom._tree.mod;
				sop += vop._tree.mod;
				vim = Tree.right(vim);
				vip = Tree.left(vip);
			}
			if (vim != null && Tree.right(vop) == null) {
				vop._tree.thread = vim;
				vop._tree.mod += sim - sop;
			}
			if (vip != null && Tree.left(vom) == null) {
				vom._tree.thread = vip;
				vom._tree.mod += sip - som;
				ancestor = node;
			}
		}
	return ancestor;
	}
	function firstWalk(node:TreeNode<T>, previousSibling:TreeNode<T>) {
		var children = node.children;
		var layout = node._tree;
		if (children != null && children.length > 0) {
			var n = children.length;
			var firstChild = children[0];
			var previousChild :TreeNode<T> = null;
			var ancestor = firstChild;
			var child:TreeNode<T> = null;
			var i = -1;
			while (++i < n) {
				child = children[i];
				firstWalk(child, previousChild);
				ancestor = apportion(child, previousChild, ancestor);
				previousChild = child;
			}
			Tree.shift(node);
			var midpoint = .5 * (firstChild._tree.prelim + child._tree.prelim);
			if (previousSibling != null) {
				layout.prelim = previousSibling._tree.prelim + _separation(node, previousSibling);
				layout.mod = layout.prelim - midpoint;
			} else {
				layout.prelim = midpoint;
			}
		} else {

			if (previousSibling!= null && previousSibling._tree != null) {
				layout.prelim = previousSibling._tree.prelim + _separation(node, previousSibling);
			}
		}
	}

	function secondWalk(node : TreeNode<T>, x:Float) {
		node.x = node._tree.prelim + x;
		var children = node.children;
		if (children != null) {
			var i = -1,
			n = children.length;
			x += node._tree.mod;
			while (++i < n) {
			secondWalk(children[i], x);
			}
		}
	}

	public function tree(d:T, ?i:Int) {
		var nodes = cast _treeHierarchy(d, i);
		var root = nodes[0];

		// Initialize temporary layout variables.
		Tree.visitAfter(root, function(node:TreeNode<T>, previousSibling:TreeNode<T>) {
			node._tree = cast {
				ancestor: node,
				prelim: 0,
				mod: 0,
				change: 0,
				shift: 0,
				number: previousSibling != null ? previousSibling._tree.number + 1 : 0,
			};
		});

		// Compute the layout using Buchheim et al.'s algorithm.
		firstWalk(root, null);
		secondWalk(root, -root._tree.prelim);
		// Compute the left-most, right-most, and depth-most nodes for extents.
		var left = Tree.search(root, Tree.leftmost),
		right = Tree.search(root, Tree.rightmost),
		deep = Tree.search(root, Tree.deepest),
		x0 = left.x - _separation(left, right) / 2,
		x1 = right.x + _separation(right, left) / 2,
		y1 = deep.depth;
		var t = this;

		// if these numbers are the same, then it's a single node tree, or
		// every branch has one child.  Therefore, center it in the middle.
		if (x0 == x1){
			x0 = -.5;
			x1 = -.5;
		}

		// Clear temporary layout variables; transform x and y.


		Tree.visitAfter(root, function(node:TreeNode<T>,_) {
			node.x = (node.x - x0) * t._size[0];
			node.y = node.depth * t._size[1];
			if (x1-x0 != 0) node.x /= (x1-x0);
			if (y1 != 0) node.y /= y1;
			node._tree = null;
		});

		return nodes;
	}
}

typedef Link<T> = {
	parent:Node<T>,
	child:Node<T>
}

typedef SourceTarget<T> = {
	source : T,
	target : T
}

typedef PosType = {
	x:Float,
	y:Float
}



typedef TreeNode<T> = {
	> PosType,
	depth:Int,
	data:T,
	children:Array<TreeNode<T>>,
	parent:Null<TreeNode<T>>,
	value:Float,
	_tree:TreeData<T>,
	ancestor:TreeNode<T>
}

typedef TreeData<T> ={
	ancestor:TreeNode<T>,
	prelim:Float,
	mod:Float,
	change:Float,
	shift:Float,
	thread:TreeNode<T>,
	number:Float
}