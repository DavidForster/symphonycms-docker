# Docker Container for Symphony CMS

[Symphony](http://www.getsymphony.com) is an XSLT-powered open source content management system

[![Build Status](https://travis-ci.org/DavidForster/symphonycms-docker.svg?branch=master)](https://travis-ci.org/DavidForster/symphonycms-docker)
[![](https://badge.imagelayers.io/davidforster/symphonycms:latest.svg)](https://imagelayers.io/?images=davidforster/symphonycms:latest "Get your own badge on imagelayers.io")

## Usage

### Requirements

Symphony stores data in a MySQL (or compatible) database, so you need have one of those running. I currently use the official MariaDB container as follows:

    docker run \
        -d \
        -e MYSQL_ROOT_PASSWORD=<rootpassword> \
        -e MYSQL_DATABASE=<databasename> \
        -e MYSQL_USER=<dbusername> \
        -e MYSQL_PASSWORD=<dbpassword> \
        -p 3306:3306 \
        --name symphonydb \
        mariadb

### Running

Once you have a MySQL database container up and running, you can start the Symphony CMS container and link it with the database container like so:

    docker run \
        -d \
        --link symphonydb \
        -p 80:80 \
        --name symphonycms \
        davidforster/symphonycms

You should then be able to access apache and be redirected to the Symphony installation page by browsing to the IP address of your docker server. If you linked the database container as per the example above, you would use the following database connection details on the installation page:

| Field    | Value            |
| -------- | ---------------- |
| Database | `<databasename>` |
| Username | `<dbusername>`   |
| Password | `<dbpassword>`   |
| Host     | symphonydb       |
| Port     | 3306             |
