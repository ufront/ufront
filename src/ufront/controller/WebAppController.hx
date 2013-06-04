package ufront.controller;

import ufront.web.mvc.Controller;
import ufront.web.mvc.ContentResult;
import ufront.web.routing.RouteCollection;

class WebAppController extends Controller
{
    static public function addRoutes(routes:RouteCollection)
    {
    	routes
		.addRoute("/cache.manifest", { controller : "WebAppController", action : "cacheManifest" } )
		;
    }

    public function appManifest() 
    {
    	var content = sys.io.File.getContent("out/app.html");
        return new ContentResult(content, "text/html");
    }

    public function cacheManifest() 
    {
    	// http://www.html5rocks.com/en/tutorials/appcache/beginner/
    	// http://developers.facebook.com/html5/blog/post/2012/07/16/mastering-the-application-cache-manifest-for-offline-web-apps-and-performance/

    	var content = new StringBuf();

    	// First line must be "CACHE MANIFEST"
    	content.add("CACHE MANIFEST\n");

    	// Cache file must change if you want cache to refresh, so we have a comment with the version number
    	content.add('# ${AppConfig.appName} v${AppConfig.appVersion} build at ${AppConfig.appBuildDate}\n');

        content.add("index.html \n");
        content.add("js/client.js \n");
        content.add("css/screen.css \n");

        return new ContentResult(content.toString(), "text/cache-manifest");
    }

    public static function getMobileAppHeaders()
    {
    	var sb = new StringBuf();

    	// Various metadatas
    	sb.add('<meta name="apple-mobile-web-app-capable" content="yes" />');
        sb.add('<meta name="apple-mobile-web-app-title" content="' + AppConfig.appShortName + '" />');
        sb.add('<meta name="format-detection" content="telephone=no" />');
        sb.add('<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable = no" />');

        // iOS Icons

    	// iPhone
        sb.add('<link href="img/icons/apple-touch-icon-57x57.png" sizes="57x57" rel="apple-touch-icon" />');
        // iPad
        sb.add('<link href="img/icons/apple-touch-icon-72x72.png" sizes="72x72" rel="apple-touch-icon" />');
        // iPhone (Retina)
        sb.add('<link href="img/icons/apple-touch-icon-114x114.png" sizes="114x114" rel="apple-touch-icon" />');
        // iPad (Retina)
        sb.add('<link href="img/icons/apple-touch-icon-144x144.png" sizes="144x144" rel="apple-touch-icon" />');
        // Precomposed (told it works on Android?)
        sb.add('<link href="img/icons/apple-touch-icon-144x144.png" rel="apple-touch-icon-precomposed" />');

        // iOS Splashscreens

        // iPhone
        sb.add('<link href="img/splash/apple-touch-startup-image-320x460.png" media="(device-width: 320px)" rel="apple-touch-startup-image" />');
        // iPhone (Retina)
        sb.add('<link href="img/splash/apple-touch-startup-image-640x920.png" media="(device-width: 320px) and (-webkit-device-pixel-ratio: 2)" rel="apple-touch-startup-image" />');
        // iPhone5 (Retina)
        sb.add('<link href="img/splash/apple-touch-startup-image-640x1096.png" media="(device-width: 320px) and (device-height: 568px) and (-webkit-device-pixel-ratio: 2)" rel="apple-touch-startup-image" />');
        // iPad (portrait)
        sb.add('<link href="img/splash/apple-touch-startup-image-768x1004.png" media="(device-width: 768px) and (orientation: portrait)" rel="apple-touch-startup-image" />');
        // iPad (landscape)
        sb.add('<link href="img/splash/apple-touch-startup-image-748x1024.png" media="(device-width: 768px) and (orientation: landscape)" rel="apple-touch-startup-image" />');
        // iPad (Retina, portrait)
        sb.add('<link href="img/splash/apple-touch-startup-image-1536x2008.png" media="(device-width: 1536px) and (orientation: portrait) and (-webkit-device-pixel-ratio: 2)" rel="apple-touch-startup-image" />');
        // iPad (Retina, landscape)
        sb.add('<link href="img/splash/apple-touch-startup-image-1496x2048.png" media="(device-width: 1536px)  and (orientation: landscape) and (-webkit-device-pixel-ratio: 2)" rel="apple-touch-startup-image" />');

        return sb.toString();
    }
}