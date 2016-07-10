FROM mysql:5.7

ADD database.sql /docker-entrypoint-initdb.d/

RUN usermod -u 1000 mysql


