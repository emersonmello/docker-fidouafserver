<!-- TOC depthFrom:1 depthTo:6 withLinks:1 updateOnSave:1 orderedList:0 -->

- [FIDO UAF Demo Server inside Docker container](#fido-uaf-demo-server-inside-docker-container)
	- [Requirements](#requirements)
	- [Running FIDO UAF Demo Server & MySQL inside docker containers](#running-fido-uaf-demo-server-mysql-inside-docker-containers)
	- [Using mysql client inside a MySQL container](#using-mysql-client-inside-a-mysql-container)
	- [Modifying database connection properties](#modifying-database-connection-properties)
	- [Modifying database structure](#modifying-database-structure)
	- [Modifying FIDO UAF Demo Server code](#modifying-fido-uaf-demo-server-code)
	- [Automatically start container](#automatically-start-container)

<!-- /TOC -->

# FIDO UAF Demo Server inside Docker container

This project show how to run [eBay FIDO UAF Demo Server](https://github.com/emersonmello/UAF.git) inside docker container. This project makes use of Apache Tomcat 8.5 as application server and MySQL as database.

## Requirements

* [Docker Engine 1.11](https://docs.docker.com/linux/) or higher
* [Docker Compose 1.7.1](https://docs.docker.com/compose/install/) or higher

## Running FIDO UAF Demo Server & MySQL inside docker containers

1. `git clone http://github.com/emersonmello/docker-fidouafserver`
1. `cd docker-fidouafserver`
1. `docker-compose up`
1. Apache Tomcat's container exposes port 8000 on host machine, so to access FIDO UAF Demo Server, you shall to point to `http://host-ip-address:8000/....`.
    - You can find [UAF Server endpoints here](https://github.com/emersonmello/UAF/tree/master/fidouaf)

## Using mysql client inside a MySQL container

1. Use `docker ps` to discovery the container' name of MySQL
   - For example:
   ```
   $ docker ps --format "Name: {{.Names}}"
   Name: dockerfidouafserver_tomcat_1
   Name: dockerfidouafserver_db_1
   ```
1. Execute MySQL client
    - For example:
    ```
    $ docker exec -it dockerfidouafserver_db_1 mysql fido -u fidouaf -pfidoUAF
    ```

## Modifying database connection properties

If you intend to change database connection properties (i.e hostname, port, username, password, database) you should edit [tomcat/context.xml](./tomcat/context.xml) file (Current MySQL container hostname is **db**):
```
<Resource name="jdbc/fidoDB" auth="Container" type="javax.sql.DataSource"
               maxActive="100" maxIdle="30" maxWait="10000"
               username="fidouaf"
               password="fidoUAF"
               driverClassName="com.mysql.jdbc.Driver"
               url="jdbc:mysql://db:3306/fido"/>
```



and then:

1. Remember to update [docker-compose.yml](docker-compose.yml):
1. `docker-compose stop`
1. `docker-compose build`
1. `docker-compose up`

## Modifying database structure

If you intend to change the database structure (i.e. create a new table, etc.), you should put the respective SQL instructions inside of a file (i.e. `mychanges.sql`) and:

1. Copy `mychanges.sql` to [mysql](mysql) subdirectory of this docker project
1. Edit [mysql/Dockerfile](./mysql/Dockerfile) and add the line below:    
    - `ADD mychanges.sql /docker-entrypoint-initdb.d/`
1. `docker-compose stop`
1. `docker-compose build`
1. `docker-compose up`


## Modifying FIDO UAF Demo Server code

1. `cd docker-fidouafserver`
1. `docker-compose stop`
1. `cd ..`
1. `git clone https://github.com/emersonmello/UAF.git`
1. `cd UAF`
1. Do your changes on FIDO UAF Demo Server code
1. Build the .WAR file of `fidouaf` - you can follow [Building and Running UAF Server Using Maven (CLI only) instructions](https://github.com/eBay/UAF/wiki)
1. Copy the generated .WAR file (you have to rename it to fidouaf.war) to [tomcat](./tomcat) subdirectory of this docker project
1. `cd docker-fidouafserver`
1. `docker-compose build`
1. `docker-compose up`

Ps: Database properties stored in [fidouaf/src/main/webapp/META-INF/context.xml](https://github.com/emersonmello/UAF/blob/master/fidouaf/src/main/webapp/META-INF/context.xml) are overwritten by properties present in [tomcat/context.xml](./tomcat/context.xml)

## Automatically start container

From [docker official documentation](https://docs.docker.com/engine/admin/host_integration/):

> As of Docker 1.2, restart policies are the built-in Docker mechanism for restarting containers when they exit. If set, restart policies will be used when the Docker daemon starts up, as typically happens after a system boot. Restart policies will ensure that linked containers are started in the correct order.

This project uses [docker-compose multiple files concept](https://docs.docker.com/compose/extends/#/multiple-compose-files), so you need to follow these steps:

1. `cd docker-fidouafserver`
1. `docker-compose stop`
1. `docker-compose -f docker-compose.yml -f docker-compose.prod.yml up -d`
