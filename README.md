Oracle Express Edition 11g Release 2 on Ubuntu 16.04 LTS
============================
[![](https://images.microbadger.com/badges/image/akarak/oracle-xe-11g.svg)](https://microbadger.com/images/akarak/oracle-xe-11g "Get your own image badge on microbadger.com")

[![](https://images.microbadger.com/badges/version/akarak/oracle-xe-11g.svg)](https://microbadger.com/images/akarak/oracle-xe-11g "Get your own version badge on microbadger.com")


Installation
```
docker pull akarak/oracle-xe-11g
```

Run with 8080 and 1521 ports opened:
```
docker run -d -p 8080:8080 -p 1521:1521 akarak/oracle-xe-11g
```

Run with data on host and reuse it:
```
docker run -d -p 8080:8080 -p 1521:1521 -v /my/oracle/data:/u01/app/oracle akarak/oracle-xe-11g
```

Run this, if you want the database to be connected remotely:
```
docker run -d -p 1521:1521 -e ORACLE_ALLOW_REMOTE=true akarak/oracle-xe-11g
```

Run with custom sys password:
```
docker run -d -p 8080:8080 -p 1521:1521 -e DEFAULT_SYS_PASS=sYs-p@ssw0rd akarak/oracle-xe-11g
```

Connect database with following setting:
```
hostname: localhost
port: 1521
sid: xe
username: system
password: oracle
```

Connect to Oracle Application Express web management console with following settings:
```
http://localhost:8080/apex
workspace: INTERNAL
user: ADMIN
password: oracle
```

Auto import of sh sql and dmp files:
```
docker run -d -p 8080:8080 -p 1521:1521 -v /my/oracle/data:/u01/app/oracle -v /my/oracle/init/sh_sql_dmp_files:/docker-entrypoint-initdb.d akarak/oracle-xe-11g
```
In case of using DMP imports dump file should be named like ${IMPORT_SCHEME_NAME}.dmp. User credentials for imports are ${IMPORT_SCHEME_NAME}/${IMPORT_SCHEME_NAME}.


Custom DB Initialization:
```
# Dockerfile
FROM akarak/oracle-xe-11g

ADD init.sql /docker-entrypoint-initdb.d/
```
