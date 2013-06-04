/**
 * ...
 * @author Franco Ponticelli
 */

package thx.util;

class Version
{
	public var major(default, null) : Int;
	public var minor(default, null) : Int;
	public var maintenance(default, null) : Int;
	public var build(default, null) : Int;

	public function new(major : Int, minor : Int, maintenance : Int, build : Int)
	{
		this.major = major;
		this.minor = minor;
		this.maintenance = maintenance;
		this.build = build;
	}

	public function fullVersion() return major + "." + minor + "." + maintenance + "." + build;

	public function toString() return "V." + fullVersion();

	public static function fromString(s : String)
	{
		if(null == s)
			return new Version(0,0,0,0);
		var parts = s.split('.'),
			nums = [];
		for(i in 0...4)
		{
			nums.push(Std.parseInt(parts[i]));
		}
		return new Version(nums[0], nums[1], nums[2], nums[3]);
	}

	public function incrementBuild()
	{
		return new Version(major, minor, maintenance, build + 1);
	}

	public function incrementMaintenance()
	{
		return new Version(major, minor, maintenance + 1, build + 1);
	}

	public function incrementMinor()
	{
		return new Version(major, minor + 1, 0, build + 1);
	}

	public function incrementMajor()
	{
		return new Version(major + 1, 0, 0, build + 1);
	}
}