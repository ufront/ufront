/**
 * ...
 * @author Franco Ponticelli
 */

package thx.util;
import haxe.PosInfos;
using Strings;

class Results
{
	public static function toString(value : Result, ?glue = "\n")
	{
		switch(value)
		{
			case Ok:
				return "Ok";
			case Failure(messages):
				var arr = [];
				for (msg in messages)
					arr.push(msg.toString());
					return arr.join(glue);
		}
	}

	inline public static function failure(msg : String, ?params : Array<Dynamic>, ?param : Dynamic, ?pos : PosInfos) : Result
	{
		return Result.Failure([new Message(msg, params, param)]);
	}
}