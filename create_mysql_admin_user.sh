#!/bin/bash

if [ -f /.mysql_admin_created ]; then
  echo "MySQL 'admin' user already created!"
  exit 0
fi

/usr/bin/mysqld_safe > /dev/null 2>&1 &

until $(mysqladmin ping > /dev/null 2>&1)
do
    :
done

PASS=$(pwgen -s 12 1)
echo "=> Creating MySQL admin user with random password"
mysql -uroot -e "CREATE USER 'admin'@'%' IDENTIFIED BY '$PASS'"
mysql -uroot -e "GRANT ALL PRIVILEGES ON *.* TO 'admin'@'%' WITH GRANT OPTION"

mysqladmin -uroot shutdown

echo "=> Done!"
touch /.mysql_admin_created

echo "========================================================================"
echo "You can now connect to this MySQL Server using:"
echo ""
echo "    mysql -uadmin -p$PASS -h<host> -P<port>"
echo ""
echo "Please remember to change the above password as soon as possible!"
echo "MySQL user 'root' has no password but only allows local connections"
echo "========================================================================"
