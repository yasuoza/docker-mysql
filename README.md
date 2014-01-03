docker-mysql
==================

Base docker image to run a MySQL database server


Usage
-----

To create the image `yasuoza/mysql`, execute the following command on the docker-mysql folder:

    sudo docker build -t yasuoza/mysql .

The first time that you run your container, a new user `admin` with all privileges
will be created in MySQL with a random password. To get the password, check the logs
of the container by running:

 sudo docker logs $CONTAINER_ID

You will see an output like the following:

    ========================================================================
    You can now connect to this MySQL Server using:

        mysql -uadmin -p47nnf4FweaKu -h<host> -P<port>

    Please remember to change the above password as soon as possible!
    MySQL user 'root' has no password but only allows local connections
    ========================================================================

In this case, `47nnf4FweaKu` is the password allocated to the `admin` user. To get
the allocated port to MySQL, execute:

    sudo docker port $CONTAINER_ID 3306

It will print the allocated port (like 4751). You can then connect to MySQL:

    mysql -uadmin -p47nnf4FweaKu -h127.0.0.1 -P4751

Remember that the `root` user has no password but it's only accesible from within the container.


Running the MySQL server
------------------------

CMD the `/run.sh` script to start MySQL (via supervisor):

    ID=$(sudo docker run -d -name mysql -p 3306 yasuoza/mysql)

It will store the new container ID (like `d35bf1374e88`) in $ID. Get the allocated external port:

    sudo docker port $ID 3306

It will print the allocated port (like 4751). Test your deployment:

    mysql -uadmin -p47nnf4FweaKu -h 127.0.0.1 -P 4751


Use the MySQL server
--------------------

Once MySQL server container started, use the MySQL:

    sudo docker run -i -t -volumes-from mysql -link mysql:mysql ubuntu /bin/bash

Inside the container, connect MySQL:

    mysql -uadmin -p47nnf4FweaKu -h $MYSQL_PORT_3306_TCP_ADDR
