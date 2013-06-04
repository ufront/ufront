/**
 * ...
 * @author Franco Ponticelli
 */

package thx.translation;

class PluralForms
{
	public static var pluralRules = [
		function(n) return 0,
		function(n) return n!=1?1:0,
		function(n) return n>1?1:0,
		function(n) return n%10==1&&n%100!=11?1:n!=0?2:0,
		function(n) return n==1?0:n==2?1:2,
		function(n) return n==1?0:n==0||n%100>0&&n%100<20?1:2,
		function(n) return n%10==1&&n%100!=11?0:n%10>=2&&(n%100<10||n%100>=20)?2:1,
		function(n) return n%10==1&&n%100!=11?0:n%10>=2&&n%10<=4&&(n%100<10||n%100>=20)?1:2,
		function(n) return n==1?0:n>=2&&n<=4?1:2,
		function(n) return n==1?0:n%10>=2&&n%10<=4&&(n%100<10||n%100>=20)?1:2,
		function(n) return n%100==1?0:n%100==2?1:n%100==3||n%100==4?2:3,
		function(n) return n==1?0:n==2?1:n>=3&&n<=6?2:n>=7&&n<=10?3:4,
		function(n) return n==1?0:n==2?1:n<=10?2:3,
		function(n) return n==1?0:n==0||n%100>0&&n%100<=10?1:n%100>10&&n%100<20?2:3,
		function(n) return n%10==1?0:n%10==2?1:2
	];
	
	public static var pluralForms = [ 1, 2, 2, 3, 3, 3, 3, 3, 3, 3, 4, 5, 4, 4, 3];
	
	public static var pluralRulesDescriptions = [
		"0",
		"n!=1?1:0",
		"n>1?1:0",
		"n%10==1&&n%100!=11?1:n!=0?2:0",
		"n==1?0:n==2?1:2",
		"n==1?0:n==0||n%100>0&&n%100<20?1:2",
		"n%10==1&&n%100!=11?0:n%10>=2&&(n%100<10||n%100>=20)?2:1",
		"n%10==1&&n%100!=11?0:n%10>=2&&n%10<=4&&(n%100<10||n%100>=20)?1:2",
		"n==1?0:n>=2&&n<=4?1:2",
		"n==1?0:n%10>=2&&n%10<=4&&(n%100<10||n%100>=20)?1:2",
		"n%100==1?0:n%100==2?1:n%100==3||n%100==4?2:3",
		"n==1?0:n==2?1:n>=3&&n<=6?2:n>=7&&n<=10?3:4",
		"n==1?0:n==2?1:n<=10?2:3",
		"n==1?0:n==0||n%100>0&&n%100<=10?1:n%100>10&&n%100<20?2:3",
		"n%10==1?0:n%10==2?1:2"
	];
}