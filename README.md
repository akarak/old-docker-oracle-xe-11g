docker-oracle-xe-11g
============================
[![](https://images.microbadger.com/badges/image/akarak/oracle-xe-11g.svg)](https://microbadger.com/images/akarak/oracle-xe-11g "Get your own image badge on microbadger.com")
[![](https://images.microbadger.com/badges/version/akarak/oracle-xe-11g.svg)](https://microbadger.com/images/akarak/oracle-xe-11g "Get your own version badge on microbadger.com")

Oracle Express Edition 11g Release 2 [Docker](https://www.docker.com) image based on [wnameless/docker-oracle-xe-11g](https://github.com/wnameless/docker-oracle-xe-11g) and [sath89/oracle-xe-11g](https://github.com/MaksymBilenko/docker-oracle-xe-11g). This [image](https://registry.hub.docker.com/u/akarak/oracle-xe-11g/) is a trusted build of [Docker Registry](https://registry.hub.docker.com/).

## What's inside the image?

| Component        | Remarks |
| ---------------- | ------------------- |
| Ubuntu 16.04 LTS | The base OS version |
| Oracle Express Edition 11g Release 2 | The Oracle DB version |

## Using docker-oracle-xe-11g

Installation:
```
docker pull akarak/oracle-xe-11g
```

Run with 8080 and 1521 ports opened:
```
docker run -d -p 8080:8080 -p 1521:1521 --name ora akarak/oracle-xe-11g
```

Run with data on host and reuse it:
```
docker run -d -p 8080:8080 -p 1521:1521 --name ora -v /my/oracle/data:/u01/app/oracle akarak/oracle-xe-11g
```

Auto import of sh sql and dmp files:
```
docker run -d -p 8080:8080 -p 1521:1521 --name ora -v /my/oracle/data:/u01/app/oracle -v /my/oracle/scripts/init.sql:/docker-entrypoint-initdb.d akarak/oracle-xe-11g
```

### Environment variables

| Name        | Default value | Remarks |
| ---------------- | ------------------- | ------------------- |
| ORACLE_ALLOW_REMOTE | false | Set true, if you want the database to be connected remotely |
| ORACLE_CUSTOM_SYS_PASS | oracle | Custom SYS password |

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
