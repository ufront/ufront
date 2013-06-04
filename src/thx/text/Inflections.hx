package thx.text;

/**
Based on the work of Ryan Schuft as reported below.
@author Franco Ponticelli

Copyright (c) 2007 Ryan Schuft (ryan.schuft@gmail.com)

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

This code is based in part on the work done in Ruby to support
infection as part of Ruby on Rails in the ActiveSupport's Inflector
and Inflections classes.  It was initally ported to Javascript by
Ryan Schuft (ryan.schuft@gmail.com).

The code is available at http://code.google.com/p/inflection-js/
*/


class Inflections
{
	public static function pluralize(singular : String)
	{
		return process(singular, plural_rules);
	}

	public static function singularize(plural : String)
	{
		return process(plural, singular_rules);
	}

	static function process(word : String, rules : Array<{ pattern : EReg, replace : String }>)
	{
		if (Lambda.has(uncountable_words, word))
			return word;
		for (rule in rules)
			if (rule.pattern.match(word))
				return rule.pattern.replace(word, rule.replace);
		return word;
	}

	static var uncountable_words = ['equipment','information','rice','money','species','series','fish','sheep','moose','deer','news'];

	static var plural_rules = [
		{ pattern : ~/(m)an$/gi, replace : '$1en' },
		{ pattern : ~/(pe)rson$/gi, replace : '$1ople' },
		{ pattern : ~/(child)$/gi, replace : '$1ren' },
		{ pattern : ~/(ax|test)is$/gi, replace : '$1es' },
		{ pattern : ~/(octop|vir)us$/gi, replace : '$1i' },
		{ pattern : ~/(alias|status)$/gi, replace : '$1es' },
		{ pattern : ~/(bu)s$/gi, replace : '$1ses' },
		{ pattern : ~/(buffal|tomat)o$/gi, replace : '$1oes' },
		{ pattern : ~/([ti])um$/gi, replace : '$1a' },
		{ pattern : ~/sis$/gi, replace : 'ses' },
		{ pattern : ~/(?:([^f])fe|([lr])f)$/gi, replace : '$1$2ves' },
		{ pattern : ~/(hive)$/gi, replace : '$1s' },
		{ pattern : ~/([^aeiouy]|qu)y$/gi, replace : '$1ies' },
		{ pattern : ~/(x|ch|ss|sh)$/gi, replace : '$1es' },
		{ pattern : ~/(matr|vert|ind)ix|ex$/gi, replace : '$1ices' },
		{ pattern : ~/([m|l])ouse$/gi, replace : '$1ice' },
		{ pattern : ~/^(ox)$/gi, replace : '$1en' },
		{ pattern : ~/(quiz)$/gi, replace : '$1zes' },
		{ pattern : ~/s$/gi, replace : 's' },
		{ pattern : ~/$/gi, replace : 's' }
	];

	static var singular_rules = [
		{ pattern : ~/(m)en$/gi, replace : '$1an' },
		{ pattern : ~/(pe)ople$/gi, replace : '$1rson' },
		{ pattern : ~/(child)ren$/gi, replace : '$1' },
		{ pattern : ~/([ti])a$/gi, replace :  '$1um' },
		{ pattern : ~/((a)naly|(b)a|(d)iagno|(p)arenthe|(p)rogno|(s)ynop|(t)he)ses$/gi, replace : '$1$2sis' },
		{ pattern : ~/(hive)s$/gi, replace :  '$1' },
		{ pattern : ~/(tive)s$/gi, replace :  '$1' },
		{ pattern : ~/([lr])ves$/gi, replace :  '$1f' },
		{ pattern : ~/([^fo])ves$/gi, replace :  '$1fe' },
		{ pattern : ~/([^aeiouy]|qu)ies$/gi, replace :  '$1y' },
		{ pattern : ~/(s)eries$/gi, replace :  '$1eries' },
		{ pattern : ~/(m)ovies$/gi, replace :  '$1ovie' },
		{ pattern : ~/(x|ch|ss|sh)es$/gi, replace :  '$1' },
		{ pattern : ~/([m|l])ice$/gi, replace :  '$1ouse' },
		{ pattern : ~/(bus)es$/gi, replace :  '$1' },
		{ pattern : ~/(o)es$/gi, replace :  '$1' },
		{ pattern : ~/(shoe)s$/gi, replace :  '$1' },
		{ pattern : ~/(cris|ax|test)es$/gi, replace :  '$1is' },
		{ pattern : ~/(octop|vir)i$/gi, replace :  '$1us' },
		{ pattern : ~/(alias|status)es$/gi, replace :  '$1' },
		{ pattern : ~/^(ox)en/gi, replace :  '$1' },
		{ pattern : ~/(vert|ind)ices$/gi, replace :  '$1ex' },
		{ pattern : ~/(matr)ices$/gi, replace :  '$1ix' },
		{ pattern : ~/(quiz)zes$/gi, replace :  '$1' },
		{ pattern : ~/s$/gi, replace :  '' }
	];

}