/**
 * ...
 * @author Franco Ponticelli
 */

package thx.error;

using Strings;
import haxe.PosInfos;
import thx.util.Message;

class Error extends Message
{
	public static var errorPositionPattern = "{0}.{1}({2}): ";

	public var pos(default,  null) : PosInfos;
	public var inner(default, null) : Error;
	public function new(message : String, ?params : Array<Dynamic>, ?param : Dynamic, ?pos : PosInfos)
	{
		super(message, params, param);
		this.pos = pos;
	}

	public function setInner(inner : Error)
	{
		this.inner = inner;
		return this;
	}

	public function toStringError(?pattern : String)
	{
		var prefix = Strings.format(null == pattern ? errorPositionPattern : pattern, [pos.className, pos.methodName, pos.lineNumber, pos.fileName, pos.customParams]);
		return prefix + toString();
	}

	override public function toString()
	{
		try {
			return message.format(params);
		} catch(e : Dynamic) {
			var ps = pos.className + "." + pos.methodName + "(" + pos.lineNumber + ")";
			trace("wrong parameters passed for pattern '" + message + "' at " +  ps);
			return "";
//			throw new Error(pa + " for pattern '{1}' at {2}", [params.join(", "), message, ps]);
		}
	}
}