FROM ubuntu:14.04
MAINTAINER HerryHou

ENV PG_VERSION 9.4
ENV PG_GIS_VERSION 2.1
RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -sc)-pgdg main" > /etc/apt/sources.list.d/postgresql.list \
     && apt-key adv --keyserver keyserver.ubuntu.com --recv-keys B97B0AFCAA1A47F044F244A07FCC7D46ACCC4CF8 \
     && apt-get update \
     && apt-get install -y \
        postgresql-${PG_VERSION} \
        postgresql-client-${PG_VERSION} \
        postgresql-contrib-${PG_VERSION} \
        postgresql-${PG_VERSION}-${PG_GIS_VERSION} \
        pwgen \
     && apt-get autoclean \
     && apt-get clean \
     && rm -rf /var/lib/postgresql \
     && rm -rf /var/lib/apt/lists/*
ADD start.sh /start.sh
RUN chmod 755 /start.sh

EXPOSE 5432

VOLUME ["/var/lib/postgresql","/run/postgresql"]
CMD ["/start.sh"]

