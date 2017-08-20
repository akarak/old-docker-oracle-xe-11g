Oracle Express Edition 11g Release 2 on Ubuntu 16.04 LTS
============================
[![](https://images.microbadger.com/badges/image/akarak/oracle-xe-11g.svg)](https://microbadger.com/images/akarak/oracle-xe-11g "Get your own image badge on microbadger.com")
[![](https://images.microbadger.com/badges/version/akarak/oracle-xe-11g.svg)](https://microbadger.com/images/akarak/oracle-xe-11g "Get your own version badge on microbadger.com")

<a name="whats_inside"></a>
## What's inside the image?

| Component        | Remarks |
| ---------------- | ------------------- |
| Ubuntu 16.04 LTS | The base system. |
| Oracle Express Edition 11g Release 2 | |

<a name="using"></a>
## Using docker-oracle-xe-11g

Installation:
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

### Environment variables

| Name        | Default value | Remarks |
| ---------------- | ------------------- | ------------------- |
| ORACLE_ALLOW_REMOTE | false | Set true, if you want the database to be connected remotely |
| DEFAULT_SYS_PASS | oracle | Custom sys password |

### Connection info

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
