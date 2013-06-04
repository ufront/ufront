package thx.culture;

import thx.culture.core.NumberInfo;

class FormatNumber {
	public static function decimal(v : Float, ?decimals : Int, ?culture : Culture) {
		if (null == culture)
			culture = Culture.defaultCulture;
		return crunch(v, decimals, culture.percent, culture.number.patternNegative, culture.number.patternPositive, culture, null, null);
	}
	public static function percent(v : Float, ?decimals : Int, ?culture : Culture) {
		if (null == culture)
			culture = Culture.defaultCulture;
		return crunch(v, decimals, culture.percent, culture.percent.patternNegative, culture.percent.patternPositive, culture, '%', culture.symbolPercent);
	}
	public static function permille(v : Float, ?decimals : Int, ?culture : Culture) {
		if (null == culture)
			culture = Culture.defaultCulture;
		return crunch(v, decimals, culture.percent, culture.percent.patternNegative, culture.percent.patternPositive, culture, '%', culture.symbolPermille);
	}
	public static function currency(v : Float, ?symbol : String, ?decimals : Int, ?culture : Culture) {
		if (null == culture)
			culture = Culture.defaultCulture;
		return crunch(v, decimals, culture.currency, culture.currency.patternNegative, culture.currency.patternPositive, culture, '$', (symbol == null ? culture.currencySymbol : symbol));
	}
	public static function int(v : Float, ?culture : Culture) {
		if (null == culture)
			culture = Culture.defaultCulture;
		return decimal(v, 0, culture);
	}

	/**
	* Transforms a string of digit from the international format (0...9) to the locale format.
	* Be sure to include only characters in the 0...9 range.
	*/
	public static function digits(v : String, ?culture : Culture) {
		if (null == culture)
			culture = Culture.defaultCulture;
		return processDigits(v, culture.digits);
	}

	static function crunch(v : Float, decimals : Null<Int>, info : NumberInfo, negative : String, positive : String, culture : Culture, symbol : String, replace : String) {
		if(Math.isNaN(v))
			return culture.symbolNaN;
		else if(!Math.isFinite(v))
			return v == Math.NEGATIVE_INFINITY ? culture.symbolNegInf : culture.symbolPosInf;
		var fv = value(v, info, decimals == null ? info.decimals : (decimals < 0 ? 0 : decimals), culture.digits);
		if(symbol != null)
			return StringTools.replace(StringTools.replace(v < 0 ? negative : positive, 'n', fv), symbol, replace);
		else
			return StringTools.replace(v < 0 ? negative : positive, 'n', fv);
	}

	static function processDigits(s : String, digits : Array<String>) {
		if(digits == null) return s;
		var o = [];
		for(i in 0...s.length)
			o.push(digits[Std.parseInt(s.substr(i, 1))]);
		return o.join('');
	}

	static function value(v : Float, info : NumberInfo, decimals : Int, digits : Array<String>) {
		var fv = '' + Math.abs(v);
		var pos = fv.indexOf('E');
		if(pos > 0) {
			var e = Std.parseInt(fv.substr(pos+1));
			var ispos = true;
			if(e < 0) {
				ispos = false;
				e = -e;
			}
			var s = StringTools.replace(fv.substr(0, pos), '.', '');
			if(ispos) {
				fv = StringTools.rpad(s, '0', e+1);
			} else {
				fv = '0'+StringTools.rpad('.', '0', e)+s;
			}
		}
		var parts = fv.split('.');
		var temp = parts[0];

		var intparts = [];
		var group = 0;
		while(true) {
			if(temp.length == 0)
				break;
			var len = info.groups[group];
			if(temp.length <= len) {
				intparts.unshift(processDigits(temp, digits));
				break;
			}
			intparts.unshift(processDigits(temp.substr(-len), digits));
			temp = temp.substr(0, -len);
			if(group < info.groups.length - 1)
				group++;
		}
		var intpart = intparts.join(info.groupsSeparator);

		if(decimals > 0) {
			var decpart = parts.length == 1 ? StringTools.lpad('', '0', decimals) : (parts[1].length > decimals ? parts[1].substr(0, decimals) : StringTools.rpad(parts[1], '0', decimals));
			return intpart + info.decimalsSeparator + processDigits(decpart, digits);
		} else {
			return intpart;
		}
	}
}