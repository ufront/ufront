class ImportAll {
	static function main() {
		// Include all the things we could want, except for macro classes.
		CompileTime.importPackage( "ufront", true, [
			"ufront.web.ControllerMacros",
			"ufront.db.DBMacros",
			"ufront.api.ApiMacros",
			"ufront.app.DispatchApplication",
			"ufront.util.BuildTools"
		]); 
	}
}