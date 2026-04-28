# [full stack nginx WordPress for everyone with docker compose](https://github.com/damalis/full-stack-nginx-wordpress-for-everyone-with-docker-compose)

If You want to build a website with WordPress at short time;

#### Full stack Nginx WordPress:
[![WordPress](https://img.shields.io/badge/WordPress-21759B?style=flat&logo=wordpress&logoColor=white)](https://wordpress.org/)
[![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat&logo=docker&logoColor=white)](https://www.docker.com/)
[![MariaDB](https://img.shields.io/badge/MariaDB-003545?style=flat&logo=mariadb&logoColor=white)](https://mariadb.org/)
[![MySQL](https://img.shields.io/badge/MySQL-4479A1?style=flat&logo=mysql&logoColor=white)](https://dev.mysql.com/)
[![Nginx](https://img.shields.io/badge/Nginx-009639?style=flat&logo=nginx&logoColor=white)](https://www.nginx.com)
[![PHP](https://img.shields.io/badge/PHP-777BB4?style=flat&logo=php&logoColor=white)](https://www.php.net)
[![Redis](https://img.shields.io/badge/Redis-DC382D?style=flat&logo=redis&logoColor=white)](https://redis.io)
[![Varnish](https://img.shields.io/badge/Varnish-Software-5FBB4F?logo=varnish&logoColor=white)](https://www.varnish-software.com/)
[![phpMyAdmin](https://img.shields.io/badge/phpMyAdmin-6C78AF?style=flat&logo=phpmyadmin&logoColor=white)](https://www.phpmyadmin.net/)
[![Certbot](https://img.shields.io/badge/Certbot-003A70?style=flat&logo=letsencrypt&logoColor=white)](https://certbot.eff.org/)
[![Let's Encrypt](https://img.shields.io/badge/Let's%20Encrypt-003A70?style=flat&logo=letsencrypt&logoColor=white)](https://letsencrypt.org/)
[![Portainer](https://img.shields.io/badge/Portainer-13BEF9?style=flat&logo=portainer&logoColor=white)](https://www.portainer.io/?hsLang=en)
[![Docker Compose](https://img.shields.io/badge/Docker%20Compose-2496ED?style=flat&logo=docker&logoColor=white)](https://docs.docker.com/compose/)
[![Bash](https://img.shields.io/badge/Bash-4EAA25?style=flat&logo=gnubash&logoColor=white)](https://www.gnu.org/software/bash/)
[![Backup](https://img.shields.io/badge/Backup-6C757D?style=flat&logo=icloud&logoColor=white)](https://www.offen.dev/)

Plus, manage docker containers with Portainer.

#### Supported CPU architectures:
![Linux-arm64/aarch64](https://img.shields.io/badge/Linux-arm64/aarch64-lightgrey)
![Linux-x86-64](https://img.shields.io/badge/Linux-X86--64-lightgrey)

#### Supported Linux Package Manage Systems:
![apk](https://img.shields.io/badge/apk-0D597F)
![dnf-yum](https://img.shields.io/badge/dnf-yum-73BA25)
![apt/apt-get](https://img.shields.io/badge/apt-apt--get-E95420)
![zypper](https://img.shields.io/badge/zypper-73BA25)
![pacman](https://img.shields.io/badge/pacman-1793D1)
 
#### Supported Linux Operation Systems:
[![Alpine Linux](https://img.shields.io/badge/alpine_linux-0D597F?style=flat&logo=alpine-linux&logoColor=white)](https://alpinelinux.org/)
[![Fedora](https://img.shields.io/badge/Fedora-blue?style=flat&logo=Fedora&logoColor=white)](https://fedoraproject.org/)
[![CentOS](https://img.shields.io/badge/CentOS-262577?style=flat-square&logo=CentOS&logoColor=white)](https://www.centos.org/)
[![Debian](https://img.shields.io/badge/debian-red?style=flat&logo=debian&logoColor=orange&color=darkred)](https://www.debian.org/)
[![Ubuntu](https://img.shields.io/badge/Ubuntu-E95420?style=flat&logo=Ubuntu&logoColor=white)](https://www.ubuntu.com/)
[![Red Hat](https://img.shields.io/badge/Red_Hat-EE0000?style=flat&logo=redhat&logoColor=white)](https://www.redhat.com/en/technologies/linux-platforms/enterprise-linux)
[![openSUSE](https://img.shields.io/badge/openSUSE-73BA25?style=flat&logo=SUSE&logoColor=white)](https://www.opensuse.org/)
[![Arch Linux](https://img.shields.io/badge/Arch%20Linux-1793D1?style=flat&logo=arch-linux&logoColor=fff)](https://archlinux.org/)
[![Raspberry Pi](https://img.shields.io/badge/Raspberry%20Pi-red?logo=raspberrypi)](https://www.raspberrypi.com/)

##### Note: Fedora 37, 39 and alpine linux x86-64 compatible, could not try sles IBM Z s390x, rhel IBM Z s390x and raspberrypi.
##### After installing the repository, a system reboot is required on Red Hat OS, Arch Linux.

#### With this project you can quickly run the following:

- [WordPress (php-fpm)](https://hub.docker.com/_/wordpress)
- [webserver (nginx)](https://hub.docker.com/_/nginx)
- [certbot (letsencrypt)](https://hub.docker.com/r/certbot/certbot)
- [phpMyAdmin](https://hub.docker.com/r/phpmyadmin/phpmyadmin/)
- [Mariadb](https://hub.docker.com/_/mariadb) [Mysql](https://hub.docker.com/_/mysql)
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

#### Note

To optimize upload images, look at [the damalis repository](https://github.com/damalis/full-stack-nodejs-image-optimizer-for-everyone-with-damalis-repository)

#### Required Ram

require up to 2 GB of RAM for **Docker** and **Docker Compose**.

#### Contents:

- [Auto Configuration and Installation](#automatic)
- [Manual Configuration and Installation](#manual)
	- [Requirements](#requirements)
	- [Configuration](#configuration)
	- [Installation](#installation)
- [Portainer Installation](#portainer)
- [Usage](#usage)
	- [Website](#website)
	- [Webserver](#webserver)
	- [Redis Plugin](#redis-plugin)
	- [Varnish Plugin](#varnish-plugin)
	- [phpMyAdmin](#phpmyadmin)
	- [backup](#backup)

### Automatic

#### Exec install shell script for auto installation and configuration

download with

```
git clone https://github.com/damalis/full-stack-nginx-wordpress-for-everyone-with-docker-compose.git
```

Open a terminal and `cd` to the folder in which `docker-compose.yml` is saved and run:

```
cd full-stack-nginx-wordpress-for-everyone-with-docker-compose
chmod +x install.sh
LC_ALL=C.UTF-8 ./install.sh # LC_ALL=C.UTF-8 if not os language english
```

### Manual

#### Requirements

Make sure you have the latest versions of **Docker** and **Docker Compose** installed on your machine and require up to 2 GB of RAM.

- [How install docker](https://docs.docker.com/engine/install/)
- [How install docker compose](https://docs.docker.com/compose/install/)

Clone this repository or copy the files from this repository into a new folder.

Make sure to [add your user to the `docker` group](https://docs.docker.com/install/linux/linux-postinstall/#manage-docker-as-a-non-root-user).

#### Configuration

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

Edit the `.env` file to change values of

|```LOCAL_TIMEZONE```|```DOMAIN_NAME```|```DIRECTORY_PATH```|```LETSENCRYPT_EMAIL```|
|```WORDPRESS_DB_USER```|```WORDPRESS_DB_PASSWORD```|```WORDPRESS_DB_NAME```|```WORDPRESS_TABLE_PREFIX```|```MYSQL_ROOT_PASSWORD```|```DATABASE_IMAGE_NAME```|
|```DATABASE_CONT_NAME```|```DATABASE_PACKAGE_MANAGER```|```DATABASE_ADMIN_COMMANDLINE```|```PMA_CONTROLUSER```|```PMA_CONTROLPASS```|
|```PMA_HTPASSWD_USERNAME```|```PMA_HTPASSWD_PASSWORD```|```VARNISH_VERSION```|```VARNISH_VERSION```|```SSL_SNIPPET```|

<table><thead>
  <tr>
    <th>Variable </th>
    <th colspan="2">Value</th>
  </tr></thead>
<tbody>
  <tr>
    <td><code>LOCAL_TIMEZONE</code></td>
    <td colspan="2"><code><a href="https://en.wikipedia.org/wiki/List_of_tz_database_time_zones#List" rel="nofollow">to see local timezones</a></code></td>
  </tr>
  <tr>
    <td><code>DIRECTORY_PATH</code></td>
    <td colspan="2"><code>pwd</code> at command line</td>
  </tr>
  <tr>
    <td><code>WORDPRESS_TABLE_PREFIX</code></td>
    <td colspan="2"><code>wp_</code> or <code><a href="https://mariadb.com/docs/server/reference/sql-structure/sql-language-structure/identifier-names" rel="nofollow" alt="custom value">custom value</a></code></td>
  </tr>
  <tr>
    <td><code>DATABASE_IMAGE_NAME</code></td>
    <td colspan="2"><code>mariadb</code> or <code>mysql</code></td>
  </tr>
  <tr>
    <td><code>DATABASE_CONT_NAME</code></td>
    <td colspan="2"><code>mariadb</code>, <code>mysql</code> or <code><a href="https://docs.docker.com/reference/compose-file/services/#container_name" rel="nofollow" alt="custom name">custom name</a></code></td>
  </tr>
  <tr>
    <td rowspan="2"><code>DATABASE_PACKAGE_MANAGER</code></td>
    <td>mariadb</td>
    <td><code>apt-get update && apt-get install -y gettext-base</code></td>
  </tr>
  <tr>
    <td>mysql</td>
    <td><code>microdnf update -y && microdnf install -y gettext</code></td>
  </tr>
  <tr>
    <td rowspan="2"><code>DATABASE_ADMIN_COMMANDLINE</code></td>
    <td>mariadb</td>
    <td><code>mariadb-admin</code></td>
  </tr>
  <tr>
    <td>mysql</td>
    <td><code>mysqladmin</code></td>
  </tr>
  <tr>
    <td rowspan="2"><code>VARNISH_VERSION</code></td>
    <td>centos version 9+ and fedora</td>
    <td><code>latest</code></td>
  </tr>
  <tr>
    <td>the others</td>
    <td><code>stable</code></td>
  </tr>
  <tr>
    <td rowspan="2"><code>SSL_SNIPPET</code></td>
    <td>localhost</td>
    <td><code>echo 'Generated Self-signed SSL Certificate at localhost'</code></td>
  </tr>
  <tr>
    <td>remotehost</td>
    <td><code>certbot certonly --webroot --webroot-path /tmp/acme-challenge --rsa-key-size 4096 --non-interactive --agree-tos --no-eff-email --force-renewal --email ${LETSENCRYPT_EMAIL} -d ${DOMAIN_NAME} -d www.${DOMAIN_NAME} -d mail.${DOMAIN_NAME}</code></td>
  </tr>
</tbody>
</table>

#### Installation

Firstly: will create external volume

```
docker volume create --driver local --opt type=none --opt device=${PWD}/certbot --opt o=bind certbot-etc
```

Localhost ssl: Generate Self-signed SSL Certificate with guide [mkcert repository](https://github.com/FiloSottile/mkcert).

```
docker compose up -d
```

then reloading for webserver ssl configuration

```
docker container restart webserver
```

The containers are now built and running. You should be able to access the WordPress installation with the configured IP in the browser address. `https://DOMAIN_NAME`.

For convenience you may add a new entry into your hosts file.

### Portainer

```
docker compose -f portainer-docker-compose.yml -p portainer up -d 
```

manage docker with [Portainer](https://www.portainer.io/) is the definitive container management tool for Docker, Docker Swarm with it's highly intuitive GUI and API. 

You can also visit `https://DOMAIN_NAME:9001` to access portainer after starting the containers.

### Usage

#### You could manage docker containers without command line with portainer.

#### Here’s a quick reference of commonly used Docker Compose commands

```
docker ps -a # Lists all containers managed by the compose file
```

```
docker compose start # Starts previously stopped containers
```

```
docker compose stop # Stops all running containers
```

```
docker compose down # Stops and removes containers, networks, etc.
```

```
docker compose down -v # Add --volumes to remove volumes explicitly
```

```
docker rm -f $(docker ps -a -q) # Removes portainer and the other containers
```

```
docker volume rm $(docker volume ls -q) # Removes all volumes
```

```
docker network prune # Remove all unused networks
```

```
docker system prune # Removes unused data (containers, networks, images, and optionally volumes)
```

```
docker system prune -a # Removes all unused images, not just dangling ones
```

```
docker rmi $(docker image ls -q) # Removes portainer and the other images
```

```
docker container logs container_name_or_id # Shows logs from all services
```

#### Project from existing source

Copy all files into a new directory:

```
docker compose up -d # Starts services in detached mode (in the background)
```

#### Docker run reference

[https://docs.docker.com/reference/cli/docker/compose/](https://docs.docker.com/reference/cli/docker/compose/)

#### Website

You should see the "Wordpress installation" page in your browser. If not, please check if your PHP installation satisfies WordPress's requirements.

```
https://DOMAIN_NAME
```

add or remove code in the ./php-fpm/php/conf.d/security.ini file for custom php.ini configurations

[https://www.php.net/manual/en/configuration.file.php](https://www.php.net/manual/en/configuration.file.php)

You should make changes custom host configurations ```./php-fpm/php-fpm.d/z-www.conf``` then must restart service, FPM uses php.ini syntax for its configuration file - php-fpm.conf, and pool configuration files.

[https://www.php.net/manual/en/install.fpm.configuration.php](https://www.php.net/manual/en/install.fpm.configuration.php)

```
docker container restart wordpress
```

add and/or remove wordpress site folders and files with any ftp client program in ```./wordpress``` folder.
<br />You can also visit `https://DOMAIN_NAME` to access website after starting the containers.

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

Proxy Cahe -> Settings -> Configure Custom IP -> Set Custom IP: `varnish`

Configuration file: ```./varnish/default.vcl```

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

#### phpMyAdmin

You can add your own custom config.inc.php settings (such as Configuration Storage setup) by creating a file named config.user.inc.php with the various user defined settings in it, and then linking it into the container using:

```
./phpmyadmin/config.user.inc.php
```

You can also visit `https://DOMAIN_NAME:9090` to access phpMyAdmin after starting the containers.

The first authorize screen(htpasswd;username or password) and phpmyadmin login screen the username and the password is the same as supplied in the `.env` file.

#### backup

This will back up the all files and folders in database/dump sql and html volumes, once per day, and write it to ```./backups``` with a filename like backup-2023-01-01T10-18-00.tar.gz

##### can run on a custom cron schedule

```BACKUP_CRON_EXPRESSION: '20 01 * * *'``` the UTC timezone.
