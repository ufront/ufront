package thx.validation;
import thx.collection.Set;
import thx.util.Result;
using thx.util.Results;

/**
 * ...
 * @author Franco Ponticelli
 */

class OptionValidator<T> extends Validator<T>
{
	public var options : Array<Option<T>>;
	public var showOptionsInFailureMessage : Bool;
	public function new(?options : Iterable<Option<T>>, ?it : Iterable<T>, ?showOptionsInFailureMessage = true)
	{
		this.options = [];
		if (null != options)
			for(o in options)
				this.options.push( o );

		if (null != it)
			for(v in it)
				this.options.push( { value : v, label : Std.string(v) } );

		this.showOptionsInFailureMessage = showOptionsInFailureMessage;
	}
	
	public function valueExists(v : T)
	{
		return Lambda.exists(options, function(a) {
			return a.value == v;
		});
	}
	
	public function labels()
	{
		var arr = [];
		for (option in options)
			arr.push(option.label);
		return arr;
	}
	
	public function descriptions()
	{
		var arr = [];
		for (option in options)
		{
			if(option.label != cast option.value)
				arr.push(option.label + " (" + option.value + ")");
			else
				arr.push(option.label);
		}
		return arr;
	}
	
	override public function validate(value : T)
	{
		if (valueExists(value))
			return Ok;
		else if(showOptionsInFailureMessage)
			return "value must be one of the following options: {0}".failure([descriptions()]);
		else
			return "value is not a valid option".failure([]);
	}
}