package mcli;
import mcli.DispatchError;
import mcli.internal.Data;
#if macro
import haxe.macro.Expr;
import haxe.macro.Type in MType;
import haxe.macro.Context;
import haxe.macro.TypeTools;
#end
using mcli.internal.Tools;
using Lambda;

class Dispatch
{

	/**
		Formats an argument definition to String.
		[argSize] maximum argument string length
		[screenSize] maxium characters until a line break should be forced
	**/
	public static function argToString(arg:Argument, argSize=30, screenSize=80)
	{
		var postfix = getPostfix(arg);
		var versions = getAliases(arg);

		if (versions.length == 0)
			if (arg.description != null)
				return arg.description;
			else
				return "";
		versions.sort(function(s1,s2) return Reflect.compare(s1.length, s2.length));

		var desc = (arg.description != null ? arg.description : "");

		var ret = new StringBuf();
		ret.add("  ");
		var argsTxt = StringTools.rpad(versions.map(function(v) return v).join(", ") + postfix, " ", argSize);
		ret.add(argsTxt);
		if (argsTxt.length > argSize)
		{
			ret.add("\n");
			for (i in 0...argSize)
				ret.add(" ");
		}

		ret.add("   ");
		if (arg.description != null)
			ret.add(arg.description);
		var consolidated = ret.toString();
		if (consolidated.length > screenSize)
		{
			ret = new StringBuf();
			var c = consolidated.split(" "), ccount = 0;
			for (word in c)
			{
				ccount += word.length + 1;
				if (ccount >= screenSize)
				{
					ret.addChar("\n".code);
					for (i in 0...(argSize + 5))
					ret.add(" ");
					ccount = argSize + 5;
				}
				ret.add(word);
				ret.add(" ");
			}
			return ret.toString();
		} else {
			return consolidated;
		}
	}

	/**
		With an argument definition array, it formats to show the standard usage help screen
		[screenSize] maximum number of characters before a line break is forced
	**/
	public static function showUsageOf(args:Array<Argument>, screenSize=80):String
	{
		var maxSize = 0;
		for (arg in args)
		{
			if (arg.name == "runDefault") continue;
			var postfixSize = getPostfix(arg).length;
			var size = arg.command.length + postfixSize + 3;
			if (arg.aliases != null) for (a in arg.aliases)
			{
				size += a.length + 3;
			}

			if (size > maxSize)
				maxSize = size;
		}

		if (maxSize > 30) maxSize = 30;
		var buf = new StringBuf();
		for (arg in args)
		{
			if (arg.name == "runDefault") continue;
			var str = argToString(arg, maxSize, screenSize);
			if (str.length > 0)
			{
				buf.add(str);
				buf.addChar('\n'.code);
			}
		}
		return buf.toString();
	}

	private static function getAliases(arg:Argument)
	{
		var versions = arg.aliases != null ? arg.aliases.concat([arg.command]) : [arg.command];
		versions = versions.filter(function(s) return s != null && s != "");

		var prefix = "-";
		if (arg.kind == SubDispatch || arg.kind == Message)
			prefix = "";
		return versions.map(function(v) return (v.length == 1) ? prefix + v.toDashSep() : prefix + prefix + v.toDashSep());
	}

	private static function getPostfix(arg:Argument)
	{
		return switch(arg.kind)
		{
			case VarHash(k,v,_):
				" " + k.name + "[=" + v.name +"]";
			case Var(_):
				" <" + arg.name + ">";
			case Function(args,vargs):
				var postfix = " ";
				for (arg in args)
					postfix += (arg.opt ? "[" : "<") + arg.name.toDashSep() + (arg.opt ? "]" : ">");
				if (vargs != null)
					postfix += " [arg1 [arg2 ...[argN]]]";
				postfix;
			default:
				"";
		};
	}

	private static var decoders:Map<String,Decoder<Dynamic>>;

	/**
		Registers a custom Decoder<T> that will be used to decode 'T' types.
		This function is type-checked and calling it will avoid the 'no Decoder was declared' warnings.

		IMPORTANT: this function must be called before the first .dispatch() that uses the custom type is called
	**/
	macro public static function addDecoder(decoder:ExprOf<Decoder<Dynamic>>)
	{
		var t = Context.typeof(decoder);
		var field = null;
		switch(Context.follow(t))
		{
			case TInst(c,_):
				for (f in c.get().fields.get())
				{
					if (f.name == "fromString")
					{
						field = f;
						break;
					}
				}
			case TAnonymous(a):
				for(f in a.get().fields)
				{
					if (f.name == "fromString")
					{
						field =f;
						break;
					}
				}
			default:
				throw new Error("Unsupported decoder type :" + TypeTools.toString(t), decoder.pos);
		}
		if (field == null)
			throw new Error("The type '" + TypeTools.toString(t) + "' is not compatible with a Decoder type", decoder.pos);
		var type = switch(Context.follow(field.type))
		{
			case TFun([arg],ret): //TODO test arg for string
				ret;
			default:
				throw new Error("The type '" + TypeTools.toString(field.type) + "' is not compatible with a Decoder type", decoder.pos);
		};

		var name = mcli.internal.Macro.convertType(type, decoder.pos);
		mcli.internal.Macro.registerDecoder(name);
		var name = { expr:EConst(CString(name)), pos: decoder.pos };

		return macro mcli.Dispatch.addDecoderRuntime($name, $decoder);
	}

	public static function addDecoderRuntime<T>(name:String, d:Decoder<T>):Void
	{
		if (decoders == null)
			decoders = new Map();
		decoders.set(name,d);
	}

	static function decode(a:String, type:String):Dynamic
	{
		return switch(type)
		{
			case "Int":
				var ret = Std.parseInt(a);
				if (ret == null) throw ArgumentFormatError(type,a);
				ret;
			case "Float":
				var ret = Std.parseFloat(a);
				if (Math.isNaN(ret))
					throw ArgumentFormatError(type,a);
				ret;
			case "String":
				a;
			default:
				var d = decoders != null ? decoders.get(type) : null;
				if (d == null)
				{
					var dt = Type.resolveClass(type);
					if (dt != null && Reflect.hasField(dt, "fromString"))
						d = cast dt;
				}
				if (d == null)
				{
					var dt2 = Type.resolveClass(type + "Decoder");
					if (dt2 != null && Reflect.hasField(dt2, "fromString"))
						d = cast dt2;
				}
				if (d == null)
				{
					var e = Type.resolveEnum(type);
					if (e != null)
					{
						var all = Type.allEnums(e);
						if (all.length > 0 && all.length == Type.getEnumConstructs(e).length)
						{
							for (v in all)
							{
								if (a == Std.string(v).toDashSep())
									return v;
							}
							throw ArgumentFormatError(type,a);
						}
					}
				}

				if (d == null) throw DecoderNotFound(type);
				d.fromString(a);
		};
	}

	public var args(default,null):Array<String>;

	public function new(args)
	{
		this.args = args.copy();
		this.args.reverse();
	}

	private function errln(s:String)
	{
#if sys
		Sys.stderr().writeString(s + "\n");
#else
		trace(s);
#end
	}

	public function dispatch(v:mcli.CommandLine, handleExceptions = true):Void
	{
		if (handleExceptions)
		{
			try
			{
				dispatch(v,false);
			}
			catch(e:DispatchError)
			{
				switch(e)
				{
					case UnknownArgument(a):
						errln('ERROR: Unknown argument: $a');
					case ArgumentFormatError(t,p):
						errln('ERROR: Unrecognized format for $t. Passed $p');
					case DecoderNotFound(t):
						errln('[mcli error] No Decoder found for type $t');
					case MissingOptionArgument(opt,name) if (opt == "--run-default"):
						errln('ERROR: The argument $name is required');
					case MissingOptionArgument(opt,name):
						name = name != null ? " (" + name + ")" : "";
						errln('ERROR: The option $opt requires an argument $name, but no argument was passed');
					case MissingArgument:
						errln('ERROR: Missing arguments');
					case TooManyArguments:
						errln("ERROR: Too many arguments");
				}
				errln(v.showUsage());
#if sys
				Sys.exit(1);
#end
			}

			return;
		}

		var defs = v.getArguments();
		var names = new Map();
		for (arg in defs)
			for (a in getAliases(arg)) 
				names.set(a, arg);

		var didCall = false, defaultRan = false;
		var delays = [];
		function runArgument(arg:String, argDef:Argument)
		{
			switch(argDef.kind)
			{
				case Flag:
					Reflect.setProperty(v, argDef.name, true);
				case VarHash(key,val,arr):
					var map:Map.IMap<Dynamic,Dynamic> = Reflect.getProperty(v, argDef.name);
					var n = args.pop();
					var toAdd = [];
					while(n != null && n.charCodeAt(0) == '-'.code)
					{
						toAdd.push(n);
						n = args.pop();
					}
					if (n == null)
						throw MissingOptionArgument(arg, key.name);
					var kv = n.split("=");
					var k = decode(kv[0], key.t);
					var v = null;
					if (kv[1] != null)
						v = decode(kv[1], val.t);
					var oldv = map.get(k);
					if (oldv != null)
					{
						if (arr)
							oldv.push(v);
						// else //TODO
							// throw RepeatedArgument(arg
					} else {
						if (arr)
							map.set(k, [v]);
						else
							map.set(k,v);
					}
					if (toAdd.length > 0)
					{
						toAdd.reverse();
						args = args.concat(toAdd);
					}
				case Var(t):
					var n = args.pop();
					var toAdd = [];
					while(n != null && n.charCodeAt(0) == '-'.code)
					{
						toAdd.push(n);
						n = args.pop();
					}
					if (n == null)
						throw MissingOptionArgument(arg);
					var val = decode(n, t);
					Reflect.setProperty(v, argDef.name, val);
					if (toAdd.length > 0)
					{
						toAdd.reverse();
						args = args.concat(toAdd);
					}
				case Function(fargs,varArg):
					didCall = true;
					var applied:Array<Dynamic> = [];
					var toAdd = [];
					var origArg = arg;
					for (fa in fargs)
					{
						arg = args.pop();
						while (arg != null && arg.charCodeAt(0) == '-'.code)
						{
							toAdd.push(arg);
							arg = args.pop();
						}
						if (arg == null && !fa.opt)
							throw MissingOptionArgument(origArg, fa.name);
						applied.push(decode(arg, fa.t));
					}
					if (varArg != null)
					{
						var va = [];
						while (args.length > 0)
						{
							var arg = args.pop();
							if (arg.charCodeAt(0) == '-'.code)
							{
								args.push(arg);
								break;
							} else {
								va.push(decode(arg,varArg));
							}
						}
						applied.push(va);
					}
					delays.push(function() Reflect.callMethod(v, Reflect.field(v, argDef.name), applied));
					if (toAdd.length != 0)
					{
						toAdd.reverse();
						args = args.concat(toAdd);
					}
				case SubDispatch:
					didCall = true;
					for (d in delays) d();
					delays = [];
					Reflect.callMethod(v, Reflect.field(v, argDef.name), [this]);
				case Message:
					throw UnknownArgument(arg);
			}
		}

		function getDefaultAlias() {
			return
				if (names.exists("--run-default")) "--run-default";
				else if (names.exists("run-default")) "run-default";
				else "";
		}

		while (args.length > 0)
		{
			var arg = args.pop();
			var argDef = names.get(arg);
			if (argDef == null)
			{
				if (arg.charCodeAt(0) != '-'.code)
				{
					if (!defaultRan)
					{
						argDef = names.get(getDefaultAlias());
						if (argDef != null)
							defaultRan = true;
						args.push(arg);
					}
				} else if (arg.length > 2 && arg.charCodeAt(1) != '-'.code) {
					var a = arg.substr(1).split('').map(function(v) return '-' + v);
					a.reverse();
					args = args.concat(a);
					continue;
				}
			}
			if (argDef == null)
				if (arg != null) {
					if (didCall == false) {
						throw UnknownArgument(arg);
					}
					else 
						continue;
				}
				else
					throw MissingArgument;

			runArgument(arg, argDef);
		}

		var defaultAlias = getDefaultAlias();
		var argDef = names.get(defaultAlias);
		if (argDef == null)
		{
			if (!didCall)
				throw MissingArgument;
		} else {
			if (!didCall)
			{
				runArgument(defaultAlias, argDef);
			} else if (!defaultRan) switch(argDef.kind) {
				case Function(args,_) if (!args.exists(function(a) return !a.opt)):
					runArgument(defaultAlias, argDef); //only run default if compatible
				default:
			}
		}

		for (d in delays) d();
	}
}
