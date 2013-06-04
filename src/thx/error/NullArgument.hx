/**
 * ...
 * @author Franco Ponticelli
 */

package thx.error;
import haxe.PosInfos;

class NullArgument #if !macro extends Error #end
{
#if !macro
	public function new(argumentName : String, ?message : String, ?posInfo : PosInfos)
	{
		if (null == message)
			message = "invalid null or empty argument '{0}' for method {1}.{2}()";
		super(message, [argumentName, posInfo.className, posInfo.methodName], posInfo);
	}
#else
	static function error(value : haxe.macro.Expr)
	{
		haxe.macro.Context.error("argument must be an identifier", value.pos);
	}
#end
	macro public static function throwIfNull(value : haxe.macro.Expr)
	{
		var name = null;
		switch(value.expr)
		{
			case EConst(c):
				switch(c)
				{
#if haxe3
					case CIdent(s):
#else
					case CType(s), CIdent(s):
#end
						name = s;
					default:
						error(value);
				}
			default:
				error(value);
		};

		var cond = "if(null == " + name + ") throw new NullArgument('" + name + "', 'invalid null argument \\\'{0}\\\' for method {1}.{2}()')";

		return haxe.macro.Context.parse(cond, value.pos);
	}

	macro public static function throwIfNullOrEmpty(value : haxe.macro.Expr)
	{
		var name = null;
		switch(value.expr)
		{
			case EConst(c):
				switch(c)
				{
#if haxe3
					case CIdent(s):
#else
					case CType(s), CIdent(s):
#end
						name = s;
					default:
						error(value);
				}
			default:
				error(value);
		}
		var cond = "";
		switch(haxe.macro.Context.typeof(value))
		{
			case TAnonymous(_):
				cond = "null == " + name + " || 0 == Reflect.fields(" + name + ").length";
			case TInst(t, _):
				var s = t.toString();
				switch(s)
				{
					case "String", "Array", "List":
						cond = "null == " + name + " || 0 == " + name + ".length";
				}
			default:
				throw "cannot apply throwIfNullOrEmpty() to the type " + Std.string(haxe.macro.Context.typeof(value));
		}

		return haxe.macro.Context.parse("if(" + cond + ") throw new NullArgument('" + name + "')", value.pos);
	}
}