package ufront.util;

using DateTools;

/** 
* On the server, provide getJsFragment(), which gives you a piece of JS which will tell the current server time
* to the client, so the offset can be calculated.
*
* On the client, provide a ServerDate.now() function which behaves similarly to Date.now(), but with the time being
* offset so that it is approximately the same as the server.
*
* This does nothing to account for HTTP latency etc, it will merely make sure that you're about the same, as in, not minutes
* or hours or years in the wrong date.
* 
*/
class ServerDate
{
	#if server 
		/**
		* Returns a string containing the `script` fragment:
		*
		*     <script type='text/javascript'>window.__ufront_serverTimeAtLoad = 1367375511623;</script>
		* 
		* Insert this anywhere in your HTML, and by the time your DOM is ready, the client can use ServerDate.now() and
		* the offset will be calculated correctly
		*/
		public static function getJsFragment()
		{
			var sb = new StringBuf();
			sb.add("<script type='text/javascript'>");
			sb.add("window.__ufront_serverTimeAtLoad = ");
			sb.add(Date.now().getTime());
			sb.add(";</script>");
			return sb.toString();
		}

		/** Compatibility, so ServerDate.now() can be used on the server or on the client. On the server, it just returns Date.now(). */
		public static inline function now() return Date.now();
	#end 

	#if client 
		/** 
		* Similar to Date.now(), but adjusted for the time offset between the client and the server.
		* 
		* This is based on a "window.__ufront_serverTimeAtLoad" property being present in Javascript.  It is
		* compared to "clieantTimeAtLoad" to figure out the offset.  If "window.__ufront_serverTimeAtLoad" is 
		* undefined, we'll just use the clientTimeAtLoad, and so the offset will be 0, and this will be the same
		* as running Date.now()
		*/
		public static function now()
		{
			return Date.now().delta(getOffset());
		}

		static var offset:Null<Float> = null; // Offset in milliseconds

		static function getOffset()
		{
			if (offset == null)
			{
				var serverTimeAtLoad:Null<Float> = Reflect.field(js.Browser.window, "__ufront_serverTimeAtLoad");
				if (serverTimeAtLoad == null) 
				{
					serverTimeAtLoad = clientTimeAtLoad;
				}

				// Compare clientTimeAtLoad to serverTimeAtLoad.  
				// Offset value is the offset in milliseconds required to get from clientTime to serverTime
				// client = 1000, server = 900, offset = -100
				// client = 1000, server = 1100, offset = 100
				offset = clientTimeAtLoad - serverTimeAtLoad;
			}
			return offset;
		}

		static var clientTimeAtLoad = Date.now().getTime();

	#end
}