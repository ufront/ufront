package thx.sys.db;

#if php
typedef Sqlite = php.db.Sqlite;
#elseif neko
typedef Sqlite = neko.db.Sqlite;
#end