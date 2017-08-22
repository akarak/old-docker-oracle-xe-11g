FROM ubuntu:16.04

LABEL maintainer="Alexey Karak <alexey.karak@gmail.com>"

ADD assets /assets
RUN /assets/setup.sh

ENV ORACLE_HOME=/u01/app/oracle/product/11.2.0/xe \
    PATH=$ORACLE_HOME/bin:$PATH \
    ORACLE_SID=XE \
    ORACLE_CUSTOM_SYS_PASS=oracle \
    ORACLE_ALLOW_REMOTE=true

EXPOSE 1521 8080
VOLUME ["/u01/app/oracle"]

ENTRYPOINT ["/assets/startup.sh"]
CMD [""]