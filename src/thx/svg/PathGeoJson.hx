/**
 * ...
 * @author Franco Ponticelli
 */

package thx.svg;
import thx.error.Error;
import thx.geo.AlbersUsa;
import thx.geo.IProjection;
import thx.geom.Polygon;
import thx.json.GeoJson;
using Arrays;

class PathGeoJson
{
	public var pointRadius(default, set) : Float;
	public var projection(default, set) : IProjection;
	public var pathCircle : String;
	var pathTypes : PathTypes;
	var centroidTypes : CentroidTypes;
	var areaTypes : AreaTypes;
	public function new()
	{
		pointRadius = 4.5;
		projection = new AlbersUsa();
		pathTypes = new PathTypes(this);
		centroidTypes = new CentroidTypes(this);
		areaTypes = new AreaTypes(this);
	}

	public function path(d : Geometry, ?_)
	{
		return pathTypes.path(d);
	}

	public function centroid(d : Geometry, ?_)
	{
		return centroidTypes.centroid(d);
	}

	public function area(d : Geometry, ?_)
	{
		return areaTypes.area(d);
	}

	function set_pointRadius(r : Float)
	{
		this.pointRadius = r;
		this.pathCircle = circle(r);
		return r;
	}

	function set_projection(projection : IProjection)
	{
		return this.projection = projection;
	}

	static function circle(r : Float)
	{
		return "m0," + r
			+ "a" + r + "," + r + " 0 1,1 0," + (-2 * r)
			+ "a" + r + "," + r + " 0 1,1 0," + ( 2 * r)
			+ "z";
	}

	public static function bounds(d : Geometry)
	{
		var left   = Math.POSITIVE_INFINITY,
			bottom = Math.POSITIVE_INFINITY,
			right  = Math.NEGATIVE_INFINITY,
			top    = Math.NEGATIVE_INFINITY;

		applyBounds(d, function(x : Float, y : Float) {
			if (x < left) left = x;
			if (x > right) right = x;
			if (y < bottom) bottom = y;
			if (y > top) top = y;
		});
		return [[left, bottom], [right, top]];
	}

	static function applyBounds(d : Geometry, f : Float -> Float -> Void)
	{
		switch(d.type)
		{
			case "Feature":
				applyBounds(d.geometry, f);
			case "FeatureCollection":
				for (feature in d.features)
					applyBounds(feature.geometry, f);
			case "LineString", "MultiPoint":
				var coordinates : Array<Array<Float>> = d.coordinates;
				for (coords in coordinates)
					f(coords[0], coords[1]);
			case "MultiLineString":
				var coordinates : Array<Array<Array<Float>>> = d.coordinates;
				for (coords in coordinates)
					for (scoords in coords)
						f(scoords[0], scoords[1]);
			case "MultiPolygon":
				var coordinates : Array<Array<Array<Array<Float>>>> = d.coordinates;
				for (coords in coordinates)
					for (scoords in coords[0])
						f(scoords[0], scoords[1]);
			case "Point":
				var coordinates : Array<Float> = d.coordinates;
				f(coordinates[0], coordinates[1]);
			case "Polygon":
				var coordinates : Array<Array<Array<Float>>> = d.coordinates;
				for (coords in coordinates[0])
					f(coords[0], coords[1]);
			default:
				throw new Error("invalid geomtry type '{0}'", d.type);
		}
	}
}

class PathTypes
{
	var geo : PathGeoJson;
	public function new(geo : PathGeoJson)
	{
		this.geo = geo;
	}

	public function path(geo : Geometry) : String
	{
		var field = Reflect.field(this, Strings.lcfirst(geo.type));
		if (null == field)
			return "";
		return Reflect.callMethod(this, field, [geo]);
	}

	public function featureCollection(f : Geometry)
	{
		var p = [],
			features = f.features;
		for(i in 0...features.length)
			p.push(path(features[i].geometry));
		return p.join("");
	}

	public function feature(f : Geometry)
	{
		return path(f.geometry);
	}

	public function point(o : Geometry)
	{
		return "M" + project(o.coordinates) + geo.pathCircle;
	}

	public function multiPoint(o : Geometry)
	{
		var p = [],
			coordinates = o.coordinates;
		for(i in 0...coordinates.length)
			p.push("M" + project(coordinates[i]) + geo.pathCircle);
		return p.join("");
	}

	public function lineString(o : Geometry)
	{
		var p = [],
			coordinates = o.coordinates;
		for (i in 0...coordinates.length)
			p.push(project(coordinates[i]));
		return "M"+p.join("L");
	}

	public function multiLineString(o : Geometry)
	{
		var p = [],
			coords : Array<Array<Array<Float>>> = o.coordinates;
		for (coordinates in coords)
		{
			p.push("M");
			for (i in 0...coordinates.length)
			{
				p.push(project(coordinates[i]));
				p.push("L");
			}
			p.pop();
		}
		return p.join("");
	}

	public function polygon(o : Geometry)
	{
		var p = [],
			coords : Array<Array<Array<Float>>> = o.coordinates;
		for (coordinates in coords)
		{
			p.push("M");
			for (j in 0...coordinates.length)
			{
				p.push(project(coordinates[j]));
				p.push("L");
			}
			p[p.length - 1] = "Z";
		}
		return p.join("");
	}

	public function multiPolygon(o : Geometry)
	{
		var p = [],
			coords : Array<Array<Array<Array<Float>>>> = o.coordinates;
		for (coordinates in coords)
		{
			for (subcoordinates in coordinates)
			{
				p.push("M");
				for (scoords in subcoordinates)
				{
					p.push(project(scoords));
					p.push("L");
				}
				p[p.length - 1] = "Z";
			}
		}
		return p.join("");
	}

	public function geometryCollection(o : Geometry)
	{
		var p = [];
		for (geometry in o.geometries)
			p.push(path(geometry));
		return p.join("");
	}

	function project(coords : Array<Float>) return geo.projection.project(coords).join(",");
}

class AreaTypes
{
	var geo : PathGeoJson;
	public function new(geo : PathGeoJson)
	{
		this.geo = geo;
	}

	public function area(geo : Geometry) : Float
	{
		var field = Reflect.field(this, Strings.lcfirst(geo.type));
		if (null == field)
			return 0.0;
		return Reflect.callMethod(this, field, [geo]);
	}

	public function featureCollection(f : Geometry)
	{
		var a = 0.0;
		for (feat in f.features)
			a += area(feat.geometry);
		return a;
	}

	public function feature(f : Geometry)
	{
		return area(f.geometry);
	}

	public function point(o : Geometry) return 0.0;
	public function multiPoint(o : Geometry) return 0.0;
	public function lineString(o : Geometry) return 0.0;
	public function multiLineString(o : Geometry) return 0.0;
	public function polygon(o : Geometry) return polygonArea(o.coordinates);

	public function multiPolygon(o : Geometry)
	{
		var sum = 0.0,
			coords : Array<Array<Array<Array<Float>>>> = o.coordinates;
		for (coordinates in coords)
			sum += polygonArea(coordinates);
		return sum;
	}

	public function geometryCollection(o : Geometry)
	{
		var sum = 0.0;
		for (geometry in o.geometries)
			sum += area(geometry);
		return sum;
	}

	function polygonArea(coords : Array<Array<Array<Float>>>)
	{
		var sum = parea(coords[0]);
		for (i in 1...coords.length)
			sum -= parea(coords[i]);
		return sum;
	}

	function parea(coords : Array<Array<Float>>) return Math.abs(new Polygon(Arrays.map(coords, project)).area());
	function project(d : Array<Float>, _) return geo.projection.project(d);
}

class CentroidTypes
{
	var geo : PathGeoJson;
	public function new(geo : PathGeoJson)
	{
		this.geo = geo;
	}

	public function centroid(geo : Geometry) : Array<Float>
	{
		var field = Reflect.field(this, Strings.lcfirst(geo.type));
		if (null == field)
			return [0.0, 0.0];
		return Reflect.callMethod(this, field, [geo]);
	}

    // TODO FeatureCollection
    // TODO MultiPoint
    // TODO LineString
    // TODO MultiLineString
    // TODO GeometryCollection

	public function point(o : Geometry) return project(o.coordinates);

	public function feature(f : Geometry) return centroid(f.geometry);

	public function polygon(o : Geometry)
	{
		var centroid = polygonCentroid(o.coordinates);
		return [centroid[0] / centroid[2], centroid[1] / centroid[2]];
	}

	public function multiPolygon(o : Geometry)
	{
		var area = 0.0,
			x = 0.0,
			y = 0.0,
			z = 0.0,
			centroid,
			coords : Array<Array<Array<Array<Float>>>> = o.coordinates;
		for (coordinates in coords)
		{
			centroid = polygonCentroid(coordinates);
			x += centroid[0];
			y += centroid[1];
			z += centroid[2];
		}
		return [x / z, y / z];
	}

	function polygonCentroid(coordinates : Array<Array<Array<Float>>>)
	{
		var polygon = new Polygon(Arrays.map(coordinates[0], project)), // exterior ring
			centroid = polygon.centroid(1),
			x = centroid[0],
			y = centroid[1],
			z = Math.abs(polygon.area());
		for (i in 1...coordinates.length)
		{
			polygon = new Polygon(Arrays.map(coordinates[i], project));
			centroid = polygon.centroid(1);
			x -= centroid[0];
			y -= centroid[1];
			z -= Math.abs(polygon.area());
		}
		return [x, y, 6 * z]; // weighted centroid
	}

	function project(d : Array<Float>, ?_) return geo.projection.project(d);
}