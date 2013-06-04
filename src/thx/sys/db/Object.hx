package thx.sys.db;

#if php
typedef Object = php.db.Object;
#elseif neko
typedef Object = neko.db.Object;
#end