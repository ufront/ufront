package tink.core;

abstract Pair<A, B>(MPair<A, B>) {
	
	public var a(get, never):A;
	public var b(get, never):B;
	
	public inline function new(a:A, b:B) this = new MPair(a, b);
	
	inline function get_a():A return this.a;
	inline function get_b():B return this.b;
	
	@:to inline function toBool() 
		return this != null;
		
	@:op(!a) public function isNil() 
		return this == null;
	
	static public function nil<A, B>():Pair<A, B> 
		return null;
}

private class Data<A, B> {
	public var a:A;
	public var b:B;
	public function new(a, b) {
		this.a = a;
		this.b = b;
	}
}

abstract MPair<A, B>(Data<A, B>) {
	public var a(get, set):A;
	public var b(get, set):B;
	
	public inline function new(a:A, b:B) this =
		new Data(a, b);
	
	inline function get_a():A 
		return this.a;
		
	inline function get_b():B 
		return this.b;
		
	inline function set_a(v:A):A
		return this.a = v;
		
	inline function set_b(v:B):B
		return this.b = v;
}	