# [full stack nginx WordPress for everyone with docker compose](https://github.com/damalis/full-stack-nginx-wordpress-for-everyone-with-docker-compose)

If You want to build a website with WordPress at short time;

#### Full stack Nginx WordPress:
<p align="left"> <a href="https://wordpress.org/" target="_blank" rel="noreferrer"> <img src="https://avatars.githubusercontent.com/u/276006?s=200&v=4" alt="wordPress" height="40" width="40"/> </a>&nbsp;&nbsp;&nbsp; 
<a href="https://www.docker.com/" target="_blank" rel="noreferrer"> <img src="https://raw.githubusercontent.com/github/explore/80688e429a7d4ef2fca1e82350fe8e3517d3494d/topics/docker/docker.png" alt="docker" width="40" height="40" width="40"/> </a>&nbsp;&nbsp;&nbsp; 
<a href="https://mariadb.org/" target="_blank" rel="noreferrer"> <img src="https://avatars.githubusercontent.com/u/5877084?s=200&v=4" alt="mariadb" height="50" width="50"/> </a>&nbsp;&nbsp;&nbsp; 
<a href="https://dev.mysql.com/" target="_blank" rel="noreferrer"> <img src="https://avatars.githubusercontent.com/u/2452804?s=200&v=4" alt="mysql" height="50" width="50"/> </a>&nbsp;&nbsp;&nbsp; 
<a href="https://www.nginx.com" target="_blank" rel="noreferrer"> <img src="https://avatars.githubusercontent.com/u/1412239?s=200&v=4" alt="nginx" height="40" width="40"/> </a>&nbsp;&nbsp;&nbsp; 
<a href="https://www.php.net" target="_blank" rel="noreferrer"> <img src="https://avatars.githubusercontent.com/u/25158?s=200&v=4" alt="php" height="40" width="40"/> </a>&nbsp;&nbsp;&nbsp; 
<a href="https://redis.io" target="_blank" rel="noreferrer"> <img src="https://avatars.githubusercontent.com/u/1529926?s=200&v=4" alt="redis" height="40" width="40"/> </a>&nbsp;&nbsp;&nbsp; 
<a href="https://www.varnish-software.com/" target="_blank" rel="noreferrer"> <img src="https://avatars.githubusercontent.com/u/577014?s=200&v=4" alt="varnish" height="40" width="40"/> </a>&nbsp;&nbsp;&nbsp; 
<a href="#" target="_blank" rel="noreferrer"> <img src="https://raw.githubusercontent.com/github/explore/80688e429a7d4ef2fca1e82350fe8e3517d3494d/topics/bash/bash.png" alt="Bash" height="50" width="50" /> </a>&nbsp;&nbsp;&nbsp;
<a href="https://www.phpmyadmin.net/" target="_blank" rel="noreferrer"> <img src="https://avatars.githubusercontent.com/u/1351977?s=200&v=4" alt="phpmyadmin" height="40" width="40"/> </a>&nbsp;&nbsp;&nbsp; 
<a href="https://letsencrypt.org/" target="_blank" rel="noreferrer"> <img src="https://avatars.githubusercontent.com/u/17889013?s=200&v=4" alt="letsencrypt" height="40" width="40"/> </a>&nbsp;&nbsp;&nbsp; 
<a href="https://www.portainer.io/?hsLang=en" target="_blank" rel="noreferrer"> <img src="https://avatars.githubusercontent.com/u/22225832?s=200&v=4" alt="portainer" height="40" width="40"/> </a>&nbsp;&nbsp;&nbsp; 
<a href="https://www.offen.dev/" target="_blank" rel="noreferrer"> <img src="https://avatars.githubusercontent.com/u/47735043?s=200&v=4" alt="backup" height="35" width="35"/> </a> </p>

Plus, manage docker containers with Portainer.

#### Supported CPU architectures:
<p align="left"> arm64/aarch64, x86-64 </p>

#### Supported Linux Package Manage Systems:
<p align="left"> apk, dnf, yum, apt/apt-get, zypper </p>
 
#### Supported Linux Operation Systems:
<p align="left"> <a href="https://alpinelinux.org/" target="_blank" rel="noreferrer"> <img src="https://avatars.githubusercontent.com/u/7600810?s=200&v=4" alt="alpine linux" height="40" width="40"/> </a>&nbsp;&nbsp;&nbsp; 
<a href="https://fedoraproject.org/" target="_blank" rel="noreferrer"> <img src="https://fedoraproject.org/assets/images/logos/fedora-blue.png" alt="fedora" height="40" width="auto"/> </a>&nbsp;&nbsp;&nbsp; 
<a href="https://www.centos.org/" target="_blank" rel="noreferrer"> <img src="https://avatars.githubusercontent.com/u/79192?s=200&v=4" alt="centos" height="40" width="40"/> </a>&nbsp;&nbsp;&nbsp; 
<a href="https://www.debian.org/" target="_blank" rel="noreferrer"> <img src="https://avatars.githubusercontent.com/u/1854028?s=200&v=4" alt="debian" height="40" width="40"/> </a>&nbsp;&nbsp;&nbsp; 
<a href="https://ubuntu.com/" target="_blank" rel="noreferrer"> <img src="https://avatars.githubusercontent.com/u/4604537?s=200&v=4" alt="ubuntu" height="40" width="40"/> </a>&nbsp;&nbsp;&nbsp; 
<a href="https://www.raspberrypi.com/" target="_blank" rel="noreferrer"> <img src="https://avatars.githubusercontent.com/u/1294177?s=200&v=4" alt="ubuntu" height="40" width="40"/> </a>&nbsp;&nbsp;&nbsp; 
<a href="https://www.redhat.com/en/technologies/linux-platforms/enterprise-linux" target="_blank" rel="noreferrer"> <img src="https://avatars.githubusercontent.com/u/33972111?s=200&v=4" alt="redhat on s390x (IBM Z)" height="40" width="40"/> </a>&nbsp;&nbsp;&nbsp; 
<a href="https://www.suse.com/products/server/" target="_blank" rel="noreferrer"> <img src="https://avatars.githubusercontent.com/u/623819?s=200&v=4" alt="opensuse on s390x (IBM Z)" height="40" width="40"/> </a> </p>

##### Note: Fedora 37, 39 and alpine linux x86-64 compatible, could not try sles IBM Z s390x, rhel IBM Z s390x and raspberrypi.

#### With this project you can quickly run the following:

- [WordPress (php-fpm)](https://hub.docker.com/_/wordpress)
- [webserver (nginx)](https://hub.docker.com/_/nginx)
- [certbot (letsencrypt)](https://hub.docker.com/r/certbot/certbot)
- [phpMyAdmin](https://hub.docker.com/r/phpmyadmin/phpmyadmin/)
- [databaseMariadb](https://hub.docker.com/_/mariadb) [databaseMysql](https://hub.docker.com/_/mysql)
- [redis](https://hub.docker.com/_/redis)
- [varnish](https://hub.docker.com/_/varnish)
- [backup](https://hub.docker.com/r/offen/docker-volume-backup)

#### For certbot (letsencrypt) certificate:

- [Set DNS configuration of your domain name](https://support.google.com/a/answer/48090?hl=en)

#### IPv4/IPv6 Firewall
Create rules to open ports to the internet, or to a specific IPv4 address or range.

- http: 80
- https: 443
- portainer: 9001
- phpmyadmin: 9090

#### Contents:

- [Auto Configuration and Installation](#automatic)
- [Requirements](#requirements)
- [Manual Configuration and Installation](#manual)
- [Portainer Installation](#portainer)
- [Usage](#usage)
	- [Website](#website)
	- [Webserver](#webserver)
	- [Redis Plugin](#redis-plugin)
	- [Varnish Plugin](#varnish-plugin)
	- [phpMyAdmin](#phpmyadmin)
	- [backup](#backup)

## Automatic

### Exec install shell script for auto installation and configuration

download with
```
git clone https://github.com/damalis/full-stack-nginx-wordpress-for-everyone-with-docker-compose.git
```

Open a terminal and `cd` to the folder in which `docker-compose.yml` is saved and run:

```
cd full-stack-nginx-wordpress-for-everyone-with-docker-compose
chmod +x install.sh
./install.sh
```

## Requirements

Make sure you have the latest versions of **Docker** and **Docker Compose** installed on your machine and require up to 2 GB of RAM.

- [How install docker](https://docs.docker.com/engine/install/)
- [How install docker compose](https://docs.docker.com/compose/install/)

Clone this repository or copy the files from this repository into a new folder.

Make sure to [add your user to the `docker` group](https://docs.docker.com/install/linux/linux-postinstall/#manage-docker-as-a-non-root-user).

## Manual
		 
### Configuration

download with
```
git clone https://github.com/damalis/full-stack-nginx-wordpress-for-everyone-with-docker-compose.git
```

Open a terminal and `cd` to the folder in which `docker-compose.yml` is saved and run:

```
cd full-stack-nginx-wordpress-for-everyone-with-docker-compose
```

Copy the example environment into `.env`

```
cp env.example .env
```

Edit the `.env` file to change values of ```LOCAL_TIMEZONE```, ```DOMAIN_NAME```, ```DIRECTORY_PATH```, ```LETSENCRYPT_EMAIL```, ```WORDPRESS_DB_USER```, ```WORDPRESS_DB_PASSWORD```, ```WORDPRESS_DB_NAME```, ```WORDPRESS_TABLE_PREFIX```, ```MYSQL_ROOT_PASSWORD```, ```DATABASE_IMAGE_NAME```, ```DATABASE_CONT_NAME```, ```DATABASE_PACKAGE_MANAGER```, ```DATABASE_AUTHENTICATION_PLUGIN```, ```DATABASE_ADMIN_COMMANDLINE```, ```PMA_CONTROLUSER```, ```PMA_CONTROLPASS```, ```PMA_HTPASSWD_USERNAME```, ```PMA_HTPASSWD_PASSWORD``` and ```VARNISH_VERSION```.

LOCAL_TIMEZONE=[to see local timezones](https://docs.diladele.com/docker/timezones.html)

DIRECTORY_PATH=```pwd``` at command line\
DATABASE_IMAGE_NAME=```mariadb``` or ```mysql```\
DATABASE_CONT_NAME=```mariadb```, ```mysql``` or ```custom name```\
DATABASE_PACKAGE_MANAGER=```apt-get -y update && apt-get install -y gettext-base``` for mariadb, ```microdnf install -y gettext``` for mysql\
DATABASE_AUTHENTICATION_PLUGIN=```mysql_native_password``` for mariadb, ```caching_sha2_password``` for mysql\
DATABASE_ADMIN_COMMANDLINE=```mariadb-admin``` for mariadb, ```mysqladmin``` for mysql\

and

```
cp ./phpmyadmin/apache2/sites-available/default-ssl.sample.conf ./phpmyadmin/apache2/sites-available/default-ssl.conf
```

change example.com to your domain name in ```./phpmyadmin/apache2/sites-available/default-ssl.conf``` file.

### Installation

Firstly: will create external volume
```
docker volume create --driver local --opt type=none --opt device=${PWD}/certbot --opt o=bind certbot-etc
```

```
docker compose up -d
```

then reloading for webserver ssl configuration

```
docker container restart webserver
```

The containers are now built and running. You should be able to access the WordPress installation with the configured IP in the browser address. `https://example.com`.

For convenience you may add a new entry into your hosts file.

## Portainer

```
docker compose -f portainer-docker-compose.yml -p portainer up -d 
```
manage docker with [Portainer](https://www.portainer.io/) is the definitive container management tool for Docker, Docker Swarm with it's highly intuitive GUI and API. 

You can also visit `https://example.com:9001` to access portainer after starting the containers.

## Usage

#### You could manage docker containers without command line with portainer.

### Show both running and stopped containers

The docker ps command only shows running containers by default. To see all containers, use the -a (or --all) flag:

```
docker ps -a
```

### Starting containers

You can start the containers with the `up` command in daemon mode (by adding `-d` as an argument) or by using the `start` command:

```
docker compose start
```

### Stopping containers

```
docker compose stop
```

### Removing containers

To stop and remove all the containers use the `down` command:
```
docker compose down
```

to remove portainer and the other containers:
```
docker rm -f $(docker ps -a -q)
```

Use `-v` if you need to remove the database volume which is used to persist the database:
```
docker compose down -v
```

to remove external certbot-etc and portainer and the other volumes:
```
docker volume rm $(docker volume ls -q)
```

Delete all images, containers, volumes, and networks that are not associated with a container (dangling):
```
docker system prune
```

To additionally remove any stopped containers and all unused images (not just dangling ones), add the -a flag to the command:
```
docker system prune -a
```

to remove portainer and the other images:
```
docker rmi $(docker image ls -q)
```

### Project from existing source

Copy all files into a new directory:

You can now use the `up` command:

```
docker compose up -d
```

### Docker run reference

[https://docs.docker.com/engine/reference/run/](https://docs.docker.com/engine/reference/run/)

### Website

You should see the "Wordpress installation" page in your browser. If not, please check if your PHP installation satisfies WordPress's requirements.

```
https://example.com
```

add or remove code in the ./php-fpm/php/conf.d/security.ini file for custom php.ini configurations

[https://www.php.net/manual/en/configuration.file.php](https://www.php.net/manual/en/configuration.file.php)

You should make changes custom host configurations ```./php-fpm/php-fpm.d/z-www.conf``` then must restart service, FPM uses php.ini syntax for its configuration file - php-fpm.conf, and pool configuration files.

[https://www.php.net/manual/en/install.fpm.configuration.php](https://www.php.net/manual/en/install.fpm.configuration.php)

```
docker container restart wordpress
```

add and/or remove wordpress site folders and files with any ftp client program in ```./wordpress``` folder.
<br />You can also visit `https://example.com` to access website after starting the containers.

#### Webserver

add or remove code in the ```./webserver/templates/nginx.conf.template``` file for custom nginx configurations

[https://docs.nginx.com/nginx/admin-guide/basic-functionality/managing-configuration-files/](https://docs.nginx.com/nginx/admin-guide/basic-functionality/managing-configuration-files/)

#### Redis Plugin

add and active [Redis Cache](https://wordpress.org/plugins/redis-cache/) plugin and

must add below code in wp-config.php file.

```
define('WP_REDIS_HOST', 'redis');
define('WP_CACHE_KEY_SALT', 'wp-docker-7f1a7682-9aec-4d4b-9a10-46bbadec41ba');
define('WP_REDIS_PREFIX', $_SERVER['HTTP_HOST']);
define('WP_REDIS_CONFIG', [
	'prefix' => getenv('WP_REDIS_PREFIX') ?: null,
    'timeout' => 0.5,
    'read_timeout' => 0.5,
    'async_flush' => true,
    'compression' => 'zstd',
    'serializer' => 'igbinary',
    'split_alloptions' => true,
    'debug' => false,
    'save_commands' => false,
]);
```

#### Varnish Plugin

add and active [Proxy Cache Purge](https://wordpress.org/plugins/varnish-http-purge/) plugin.

#####
Go to the WordPress dashboard<br />
Click on Plugins<br />
Click on Add New<br />
Search for the Redis Cache / the Proxy Cache Purge plugin<br />
Click on Install Now and confirm<br />
Finally, activate the plugin

add this code to connect always with ssl in wp-config.php file.

```
define('FORCE_SSL_LOGIN', true);
define('FORCE_SSL_ADMIN', true);
```

after every change in the wordpress and the varnish configuration or if You get error "502 Bad Gateway":

```
docker container restart varnish
```

### phpMyAdmin

You can add your own custom config.inc.php settings (such as Configuration Storage setup) by creating a file named config.user.inc.php with the various user defined settings in it, and then linking it into the container using:

```
./phpmyadmin/config.user.inc.php
```

You can also visit `https://example.com:9090` to access phpMyAdmin after starting the containers.

The first authorize screen(htpasswd;username or password) and phpmyadmin login screen the username and the password is the same as supplied in the `.env` file.

### backup

This will back up the all files and folders in database/dump sql and html volumes, once per day, and write it to ./backups with a filename like backup-2023-01-01T10-18-00.tar.gz

#### can run on a custom cron schedule

```BACKUP_CRON_EXPRESSION: '20 01 * * *'``` the UTC timezone.
