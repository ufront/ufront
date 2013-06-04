package thx.sys.db;

#if php
typedef Manager<T : php.db.Object> = php.db.Manager<T>;
#elseif neko
typedef Manager<T : neko.db.Object> = neko.db.Manager<T>;
#end