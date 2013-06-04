/**
 * ...
 * @author Franco Ponticelli
 */

package thx.json;

typedef Geometry = {
	public var type : String; //  "Point", "MultiPoint", "LineString", "MultiLineString", "Polygon", "MultiPolygon", "GeometryCollection", "Feature", or "FeatureCollection"	
	public var coordinates : Null<Dynamic>;
	public var geometries : Null<Array<Geometry>>;
	public var bbox : Null<Array<Float>>;
	public var features : Null<Array<Geometry>>;
	public var geometry : Null<Geometry>;
	public var properties : Null<Dynamic>;
	public var id : Null<String>;
}

// extends Dynamic
typedef GeoJson = {> Geometry,
	crs : Null<CoordinateReferenceSystem>
}

typedef CoordinateReferenceSystem = {
	type : String, // name || link
	properties :
	{
		name : Null<String>, // used in conjuntion with type:"name"
		href : Null<String>, // used in conjunction with type:"link" and properties.type
		type : Null<String>  // "proj4", "ogcwkt", "esriwkt" ...
	}
}