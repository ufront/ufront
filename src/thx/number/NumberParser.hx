package thx.number;
import thx.culture.Culture;
import thx.error.Error;
import thx.text.ERegs;
using Arrays;

/**
 * ...
 * @author Justin Donaldson
 */

class NumberParser 
{
	public static function parse(val:String, ?cul:Culture):Float{
		if (cul == null) cul = Culture.defaultCulture;
		var reg = cultureNumberEReg(cul);
		var fval = val;
		var nval = Math.NaN;
		var ni = cul.number;
		var gsep = ERegs.escapeERegChars(ni.groupsSeparator);
		var dsep = ERegs.escapeERegChars(ni.decimalsSeparator);
		
		if (canParse(val, cul)){
			fval = new EReg(gsep,'gi').replace(fval ,'');		
			fval = new EReg(dsep,'gi').replace(fval ,'.');
			nval =  Std.parseFloat(fval);
			if (new EReg(ERegs.escapeERegChars(cul.signNeg),'').match(val)){
				if (nval > 0) nval *= -1;
			}
		}
		return nval;
		
	}
	
	static function cultureNumberEReg(cul:Culture){
		var ni = cul.number;
		var groups = ni.groups.copy();
		var digits = '';
		var gsep = ERegs.escapeERegChars(ni.groupsSeparator);
		var dsep = ERegs.escapeERegChars(ni.decimalsSeparator);
		
		
		if (cul.digits != null){
			throw("unsupported digit characters"); //javascript can't regex arbitrary unicode
/*			digits = "[" + ERegs.escapeERegChars(cul.digits.join("")) + "]";*/
		} else {
			digits = "[0-9]";
		}
		var regex = new StringBuf();
		regex.add("(");
		var group_length = 0;
		if (groups.length > 2) throw("too many groups!");
		if (groups.length == 2){

			if (groups[1] == 0){
				regex.add( "(" + digits + "*" + gsep + ")"); // if group count is 0, treat as *
			}else{
				regex.add( "((" + digits + "{1," + groups[1] + "}" + gsep + ")"); // {1,initial group_count} number of digits
				regex.add( "(" + digits + "{" + groups[1] + "}" + gsep + ")*" + digits + "{" + groups[0] + "})|"); // {1,initial group_count} number of digits
			}
			
			if (groups[0] == 0){
				regex.add( "(" + digits + "*" + gsep + ")"); // if group count is 0, treat as star
			}else{
				regex.add( "(" + digits + "+)"); // {1, final_group_count} number of digits (alone)	
			}
		}
		
		if (groups.length == 1){
			group_length = groups[0];
			regex.add( "((" + digits + "{1," + groups[0] + "})"); // {1,initial group_count} number of digits
			regex.add( "("+ gsep + digits + "{" + groups[0] + "}" + ")+)|"); // {1,initial group_count} number of digits
			regex.add( "(" + digits + "+)"); // {1, final_group_count} number of digits (alone)
		}
		
		regex.add(")");
		
		var last_group= 0;

				
		regex.add("(" + dsep + digits + "*)?");
		regex.add("([eE][+\\-]?\\d+)?");
		
		var reg_string = regex.toString();
		var negative = false;
		
		if (ni.patternNegative != '-n'){
			var neg_match = ~/([^n]+)/g.replace(ERegs.escapeERegChars(ni.patternNegative),"($1)?");
			reg_string = ~/n/.replace(neg_match, reg_string);
		}else{
			reg_string  = "[+-]?" + reg_string;
		}
		reg_string = "^"+ reg_string + "$";
		var reg = new EReg(reg_string,'gi');
		return reg;
		
	}
	
	public static function canParse(val:String, ?cul:Culture){
		if (cul == null) cul = Culture.defaultCulture;
		var reg = cultureNumberEReg(cul);
		if (reg.match(val)) {

			return true;
		}
		else return false;
	}

}