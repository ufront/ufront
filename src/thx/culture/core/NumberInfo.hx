package thx.culture.core;

class NumberInfo {
	public var decimals(default, null) : Int;
	public var decimalsSeparator(default, null) : String;
	public var groups(default, null) : Array<Int>;
	public var groupsSeparator(default, null) : String;
	public var patternNegative(default, null) : String;
	public var patternPositive(default, null) : String;

	public function new(decimals : Int, decimalsSeparator : String, groups : Array<Int>, groupsSeparator : String, patternNegative : String, patternPositive : String) {
		this.decimals = decimals;
		this.decimalsSeparator = decimalsSeparator;
		this.groups = groups;
		this.groupsSeparator = groupsSeparator;
		this.patternNegative = patternNegative;
		this.patternPositive = patternPositive;
	}
}