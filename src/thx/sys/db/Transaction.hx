package thx.sys.db;

#if php
typedef Transaction = php.db.Transaction;
#elseif neko
typedef Transaction = neko.db.Transaction;
#end