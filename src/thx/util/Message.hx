/**
 * ...
 * @author Franco Ponticelli
 */

package thx.util;

using Strings;
import haxe.PosInfos;
import thx.culture.Culture;
import thx.translation.ITranslation;

class Message
{
	public var message(default, null) : String;
	public var params(default, null) : Array<Dynamic>;
	public function new(message : String, ?params : Array<Dynamic>, ?param : Dynamic)
	{
		this.message = message;
		if (null == params)
			this.params = [];
		else
			this.params = params;
		if (null != param)
			this.params.push(param);
	}

	public function toString()
	{
		return message.format(params);
	}

	public function translatef(translator : String -> String)
	{
		return translator(message).format(params);
	}

	public function translate(translator : ITranslation, ?domain : String)
	{
		if (null == domain)
			domain = translator.domain;
		var culture = Culture.get(domain);
		if (params.length == 1 && Std.is(params[0], Int))
			return translator.plural(null, message, params[0], domain).format(params, culture);
		else
			return translator.singular(message, domain).format(params, culture);
	}
}