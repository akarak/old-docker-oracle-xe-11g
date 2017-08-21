#!/bin/bash

# Prevent owner issues on mounted folders
chown -R oracle:dba /u01/app/oracle
rm -f /u01/app/oracle/product
ln -s /u01/app/oracle-product /u01/app/oracle/product

# Update hostname
sed -i -E "s/HOST = [^)]+/HOST = $HOSTNAME/g" /u01/app/oracle/product/11.2.0/xe/network/admin/listener.ora
sed -i -E "s/PORT = [^)]+/PORT = 1521/g" /u01/app/oracle/product/11.2.0/xe/network/admin/listener.ora
echo "export ORACLE_HOME=/u01/app/oracle/product/11.2.0/xe" > /etc/profile.d/oracle-xe.sh
echo "export PATH=\$ORACLE_HOME/bin:\$PATH" >> /etc/profile.d/oracle-xe.sh
echo "export ORACLE_SID=XE" >> /etc/profile.d/oracle-xe.sh
. /etc/profile

# Check for mounted database files
if [ "$(ls -A /u01/app/oracle/oradata 2> /dev/null)" ]; then
	echo "Using files in '/u01/app/oracle/oradata' instead of initial database."
	echo "XE:$ORACLE_HOME:N" >> /etc/oratab
	chown oracle:dba /etc/oratab
	chown 664 /etc/oratab
	printf "ORACLE_DBENABLED=false\nLISTENER_PORT=1521\nHTTP_PORT=8080\nCONFIGURE_RUN=true\n" > /etc/default/oracle-xe
	rm -rf /u01/app/oracle-product/11.2.0/xe/dbs
	ln -s /u01/app/oracle/dbs /u01/app/oracle-product/11.2.0/xe/dbs
else
	echo "Initializing database."
	if [ -z "$CHARACTER_SET" ]; then
		export CHARACTER_SET="AL32UTF8"
	fi

	mv /u01/app/oracle-product/11.2.0/xe/dbs /u01/app/oracle/dbs
	ln -s /u01/app/oracle/dbs /u01/app/oracle-product/11.2.0/xe/dbs

	printf 8080\\n1521\\n${DEFAULT_SYS_PASS}\\n${DEFAULT_SYS_PASS}\\ny\\n | service oracle-xe configure
	echo "Setting 'sys/system' passwords"
	echo  alter user sys identified by \"$DEFAULT_SYS_PASS\"\; | su oracle -s /bin/bash -c "$ORACLE_HOME/bin/sqlplus -s / as sysdba" > /dev/null 2>&1
	echo  alter user system identified by \"$DEFAULT_SYS_PASS\"\; | su oracle -s /bin/bash -c "$ORACLE_HOME/bin/sqlplus -s / as sysdba" > /dev/null 2>&1

	echo "Database initialized."
	echo "Please visit http://#containeer:8080/apex to proceed with configuration."
fi

service oracle-xe start

if [ "$ORACLE_ALLOW_REMOTE" = true ]; then
	echo alter system disable restricted session\; | su oracle -s /bin/bash -c "$ORACLE_HOME/bin/sqlplus -s / as sysdba" > /dev/null 2>&1
fi

for f in /docker-entrypoint-initdb.d/*; do
  case "$f" in
    *.sh)     echo "$0: running $f"; . "$f" ;;
    *.sql)    echo "$0: running $f"; su oracle -s /bin/bash -c "$ORACLE_HOME/bin/sqlplus -s / as sysdba" @"$f"; echo ;;
    *)        echo "$0: ignoring $f" ;;
  esac
  echo
done
