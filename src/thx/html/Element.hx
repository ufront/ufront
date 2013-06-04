/**
 * ...
 * @author Franco Ponticelli
 */

package thx.html;

import thx.collection.Set;

class Element
{
	/**
	 * Elements whose content should be left untouched (no wrapping, no white-space trimming)
	 */
	public static inline function shouldPreserve(el : String) return _preserve.exists(el);
	static var _preserve = Set.ofArray("pre,textarea".split(","));

	/**
	 * Empty Elements
	 */
	public static inline function isEmpty(el : String) return _empty.exists(el);
	static var _empty = Set.ofArray("area,base,basefont,br,col,frame,hr,img,input,isindex,link,meta,param,embed".split(","));

	/**
	 * Block Elements
	 */
	public static inline function isBlock(el : String) return _block.exists(el);
	static var _block = Set.ofArray("address,applet,blockquote,button,center,dd,del,dir,div,dl,dt,fieldset,form,frameset,h1,h2,h3,h4,h5,h6,hr,iframe,ins,isindex,li,map,menu,noframes,noscript,object,ol,p,pre,script,style,table,tbody,td,textarea,tfoot,th,thead,title,tr,ul".split(","));

	/**
	 * Inline Elements
	 */
	public static inline function isInline(el : String) return _inline.exists(el);
	static var _inline = Set.ofArray("a,abbr,acronym,b,basefont,bdo,big,br,button,cite,code,del,dfn,em,font,i,iframe,img,input,ins,kbd,label,map,object,q,s,samp,script,select,small,span,strike,strong,sub,sup,tt,u,var".split(","));

	/**
	 * Break Elements
	 */
	public static inline function isBreakElement(el : String) return _break.exists(el);
	static var _break = Set.ofArray("br,hr".split(","));
	
	/**
	 * Elements that you can, intentionally, leave open
	 * (and which close themselves)
	 */
	public static inline function isCloseSelf(el : String) return _closeSelf.exists(el);
	static var _closeSelf = Set.ofArray("colgroup,dd,dt,li,options,p,td,tfoot,th,thead,tr".split(","));

	/**
	 * Special Elements (can contain anything)
	 */
	public static inline function isSpecial(el : String) return _special.exists(el);
	static var _special = Set.ofArray("script,style".split(","));
}