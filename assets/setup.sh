#!/bin/bash

apt-get update && apt-get install -y -q libaio1 net-tools bc &&

# Prepare to install Oracle
ln -s /usr/bin/awk /bin/awk &&
mkdir /var/lock/subsys &&
mv /assets/chkconfig /sbin/chkconfig &&
chmod 755 /sbin/chkconfig &&

# Install Oracle
cat /assets/oracle-xe_11.2.0-1.0_amd64.deba* > /assets/oracle-xe_11.2.0-1.0_amd64.deb
dpkg --install /assets/oracle-xe_11.2.0-1.0_amd64.deb

mv /assets/init.ora       /u01/app/oracle/product/11.2.0/xe/config/scripts
mv /assets/initXETemp.ora /u01/app/oracle/product/11.2.0/xe/config/scripts

mv /u01/app/oracle/product /u01/app/oracle-product

# Install startup script for container
mv /assets/startup.sh /usr/sbin/startup.sh &&
chmod +x /usr/sbin/startup.sh &&

# Remove installation files
apt-get clean && rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/* && rm -r /assets/
