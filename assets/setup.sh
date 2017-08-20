#!/bin/bash

apt-get update && apt-get install -y -q libaio1 net-tools bc curl rlwrap &&
apt-get clean &&
rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/* &&
ln -s /usr/bin/awk /bin/awk &&
mkdir /var/lock/subsys &&
chmod 755 /sbin/chkconfig &&

# Install Oracle
cat /assets/oracle-xe_11.2.0-1.0_amd64.deba* > /assets/oracle-xe_11.2.0-1.0_amd64.deb
dpkg --install /assets/oracle-xe_11.2.0-1.0_amd64.deb
rm -f /assets/oracle-xe_11.2.0-1.0_amd64.deb

mv /assets/init.ora       /u01/app/oracle/product/11.2.0/xe/config/scripts
mv /assets/initXETemp.ora /u01/app/oracle/product/11.2.0/xe/config/scripts

mv /u01/app/oracle/product /u01/app/oracle-product

apt-get clean && rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*