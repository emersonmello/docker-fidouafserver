# FIDO UAF Demo Server inside Docker container

This project show how to run [eBay FIDO UAF Demo Server](https://github.com/emersonmello/UAF.git) inside docker container. This project makes use of Apache Tomcat 8.5 as application server and MySQL as database.

## Requirements

* [Docker Engine 1.11](https://docs.docker.com/linux/) or higher
* [Docker Compose 1.7.1](https://docs.docker.com/compose/install/) or higher

## Running FIDO UAF Demo Server & MySQL inside docker containers

1. `git clone http://github.com/emersonmello/docker-fidouafserver`
1. `cd docker-fidouafserver`
1. `docker-compose up`
1. Apache Tomcat's container exposes port 8000 on host machine, so to access FIDO UAF Demo Server, you shall to point to `http://host-ip-address:8000/....`. You can find [UAF Server endpoints here](https://github.com/emersonmello/UAF/tree/master/fidouaf)

### Using mysql client inside a MySQL container

1. Use `docker ps` to discovery the container' name of MySQL
   - For example:
   ```
   $ docker ps --format "Name: {{.Names}}"
   Name: dockerfidouafserver_tomcat_1
   Name: dockerfidouafserver_db_1
   ```
1. Execute an interactive shell
    - For example:
    ```
    $ docker exec -it dockerfidouafserver_db_1 /bin/bash
    ```
1. Execute mysql client
    - For example:
    ```
    $ mysql fido -u fidouaf -pfidoUAF
    ```

## Modifying FIDO UAF Demo Server code

1. `cd docker-fidouafserver`
1. `docker-compose stop`
1. `cd ..`
1. `git clone https://github.com/emersonmello/UAF.git`
1. `cd UAF`
1. Do your changes on FIDO UAF Demo Server code
1. Be sure that JDBC properties in [fidouaf/src/main/resources/META-INF/persistence.xml](https://github.com/emersonmello/UAF/blob/master/fidouaf/src/main/resources/META-INF/persistence.xml) are like below (or feel free to change username, password, database, etc...but remember to update [docker-compose.yml](docker-compose.yml)):

    ```
    <properties>
	   <property name="javax.persistence.jdbc.url" value="jdbc:mysql://db:3306/fido"/>
	   <property name="javax.persistence.jdbc.user" value="fidouaf"/>
	   <property name="javax.persistence.jdbc.driver" value="com.mysql.jdbc.Driver"/>
	   <property name="javax.persistence.jdbc.password" value="fidoUAF"/>
	   <property name="javax.persistence.schema-generation.database.action" value="create"/>
    </properties>
    ```
8. If you intend to change the database structure (i.e. create a new table, etc.), you should put the respective SQL instructions inside of a file (i.e. `mychanges.sql`) and:
    1. Copy `mychanges.sql` to `mysql` subdirectory of this docker project
    1. Edit [mysql/Dockerfile](./mysql/Dockerfile) and add the line below:
    
        `ADD mychanges.sql /docker-entrypoint-initdb.d/`

9. Build the .WAR file of `fidouaf` - you can follow [Building and Running UAF Server Using Maven (CLI only) instructions](https://github.com/eBay/UAF/wiki)
10. Copy the generated .WAR file (you have to rename it to fidouaf.war) to `tomcat` subdirectory of this docker project
11. `cd docker-fidouafserver`
12. `docker-compose build`
13. `docker-compose up`