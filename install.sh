#!/bin/bash

clear
echo
echo "======================================================================="
echo "|                                                                     |"
echo "|     full-stack-nginx-wordpress-for-everyone-with-docker-compose     |"
echo "|                      by Erdal ALTIN                                 |"
echo "|                                                                     |"
echo "======================================================================="
sleep 2

echo
# ----------------------- OS Information -------------------------------------
echo "[+] OS Information"
echo "-----------------------------------------------------------------------"

if [[ -f /etc/os-release ]]; then
	. /etc/os-release
	echo "Distro       : $PRETTY_NAME"
	echo "ID           : $ID"
	echo "ID_LIKE      : $ID_LIKE"
	id_like=$(grep -Pow 'ID_LIKE=\K[^;]*' /etc/os-release | tr -d '"' | grep -obe 'debian' -e 'ubuntu' -e 'centos' -e 'fedora' -e 'suse' -e 'rhel' | grep -oE '[A-Za-z]+' | head -n 1)
	echo "Version      : $VERSION_ID"
	echo "Codename     : $VERSION_CODENAME (or $UBUNTU_CODENAME)"
elif [[ -f /usr/lib/os-release ]]; then
	. /usr/lib/os-release
        echo "Distro       : $PRETTY_NAME"
        echo "ID           : $ID"
	echo "ID_LIKE      : $ID_LIKE"
	id_like=$(grep -Pow 'ID_LIKE=\K[^;]*' /usr/lib/os-release | tr -d '"' | grep -obe 'debian' -e 'ubuntu' -e 'centos' -e 'fedora' -e 'suse' -e 'rhel' | grep -oE '[A-Za-z]+' | head -n 1)
        echo "Version      : $VERSION_ID"
        echo "Codename     : $VERSION_CODENAME (or $UBUNTU_CODENAME)"
else
	echo "Cannot detect OS or os-release file not found"
#	exit 0
fi

unames=$(sudo uname -s)
unamem=$(sudo uname -m)
echo "Kernel       : $(sudo uname -r)"
echo "Architecture : $unamem"
echo "Hostname     : $(sudo hostname)"
#echo "Uptime       : $(sudo uptime -p 2>/dev/null || uptime)"

operation_system_id=("centos", "debian", "fedora", "raspbian", "rhel", "sles", "static", "ubuntu")
if [[ ${operation_system_id[@]} =~ "$ID" ]]
then
	operation_system="$ID"
	codename="$VERSION_CODENAME"
else
	operation_system="$id_like"
	upper_operation_system="${id_like^^}"
	declare -n codename="${upper_operation_system}_CODENAME"
fi

echo
echo "Done ✓"
echo "======================================================================="

# the "lpms" is an abbreviation of Linux Package Management System
lpms=""
for i in apk dnf yum apt apt-get dpkg zypper pacman
do
	if [ -x "$(command -v $i)" ]; then
		if [ "$i" == "apk" ]
		then
			lpms=$i
			sudo apk add --no-cache --upgrade grep
			break
		elif [ "$i" == "dnf" ] && ([ "$ID" == "fedora" ] || ([ "$ID" != "centos" ] && [[ "$ID_LIKE" == *"fedora"* ]]) || ([[ "$ID_LIKE" == *"rhel"* ]] && [ "$unamem" == "s390x" ]))
		then
			lpms=$i
			break
		elif [ "$i" == "yum" ] && ([ "$ID" == "centos" ] || ([ "$ID" != "fedora" ] && [[ "$ID_LIKE" == *"fedora"* ]]) || ([[ "$ID_LIKE" == *"rhel"* ]] && [ "$unamem" == "s390x" ]))
		then
			lpms=$i
			break
		elif ([ "$i" == "apt" ] || [ "$i" == "apt-get" ]) && ([[ "$ID" == *"ubuntu"* ]] || [[ "$ID" == *"debian"* ]] || [[ "$ID_LIKE" == *"ubuntu"* ]] || [[ "$ID_LIKE" == *"debian"* ]])
		then
			lpms=$i
			break
		elif [ "$i" == "dpkg" ]
		then
			lpms=$i
			break
		elif [[ "$ID_LIKE" == *"suse"* ]]
		then
			lpms=$i
			break
		elif [ "$i" == "pacman" ]
		then
			lpms=$i
			break
		fi
	fi
done

if [ -z $lpms ]; then
	echo
	echo "No supported package manager found"
	echo
	exit 0
fi

echo
echo "[+] Detected Package Manager: $lpms"

echo
echo "Done ✓"
echo "======================================================================="

##########
# set varnish version
##########
varnish_version="stable"
if ([ "$VERSION_ID" == "9*" ] && [ "$ID" == "centos" ]) || [ "$ID" == "fedora" ]
then
	varnish_version="latest"
fi

##########
# Uninstall old versions
##########
echo
echo
echo "======================================================================="
echo "| Older versions of Docker were called docker, docker.io, or docker-engine."
echo "| If these are installed or all conflicting packages, uninstall them."
echo "======================================================================="
echo
sleep 2

# linux remove command for pms
if [ "$lpms" == "apk" ]
then
	sudo apk del docker podman-docker
elif [ "$lpms" == "dnf" ]
then
	sudo dnf -y remove podman-docker docker docker-client docker-client-latest docker-common docker-latest docker-latest-logrotate docker-logrotate docker-selinux docker-engine-selinux docker-engine
elif [ "$lpms" == "yum" ]
then
	sudo yum -y remove docker docker-client docker-client-latest docker-common docker-latest docker-latest-logrotate docker-logrotate docker-engine podman podman-docker runc
elif [ "$lpms" == "apt" ] || [ "$lpms" == "apt-get" ] || [ "$lpms" == "dpkg" ]
then
	for pkg in docker docker-engine docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do sudo $lpms -y remove $pkg; done
elif [ "$lpms" == "zypper" ]
then
	if [[ "$ID" == *"sles"* ]]
	then
		sudo zypper remove -y docker docker-client docker-client-latest docker-common docker-latest docker-latest-logrotate docker-logrotate docker-engine runc
	fi
elif [ "$lpms" == "pacman" ]
then
	sudo pacman -Rssn --noconfirm podman-docker podman-compose
else
	echo
	echo "No supported package manager found"
	echo
	exit 0
fi

echo
echo "Done ✓"
echo "======================================================================="

##########
# Install Docker
##########
echo
echo
echo "======================================================================="
echo "| Install Docker..."
echo "======================================================================="
echo
sleep 2

if [ "$lpms" == "apk" ]
then
	sudo apk add --update docker openrc bind-tools
	sudo rc-update add docker boot
	sudo service docker start
elif [ "$lpms" == "dnf" ]
then
	sudo dnf -y update
	sudo dnf -y install dnf-plugins-core yum-utils openssl-libs
	if [ "$ID" == "fedora" ] || ([ "$ID" == "rhel" ] && [ "$unamem" == "s390x" ])
	then
		sudo dnf config-manager addrepo --from-repofile=https://download.docker.com/linux/$ID/docker-ce.repo
	elif [ "$ID" == "rhel" ] || [ "$id_like" == "rhel" ]
	then
		sudo dnf config-manager --add-repo https://download.docker.com/linux/rhel/docker-ce.repo
	else
		echo
		echo "unsupport operation system and/or architecture"
		echo
		exit 0
	fi
	sudo dnf -y install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin bind-utils
elif [ "$lpms" == "yum" ]
then
	sudo yum -y update
	sudo yum -y install yum-utils
	if [ "$ID" == "centos" ] || ([ "$ID" == "rhel" ] && [ "$unamem" == "s390x" ])
	then
		sudo yum-config-manager --add-repo https://download.docker.com/linux/$ID/docker-ce.repo
	elif [ "$id_like" == "rhel" ] || [ "$id_like" == "rhel" ]
	then
		sudo yum-config-manager --add-repo https://download.docker.com/linux/rhel/docker-ce.repo
	else
		echo
		echo "unsupport operation system and/or architecture"
		echo
		exit 0
	fi
	sudo yum -y install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin bind-utils
elif [ "$lpms" == "zypper" ]
then
	sudo zypper update -y
	sudo zypper install -y bind-utils
	if [[ "$ID" == *"sles"* ]] && [ "$unamem" == "s390x" ]
	then
		# "https://download.opensuse.org/repositories/security:/SELinux/openSUSE_Factory/security:SELinux.repo"
		sudo zypper addrepo "https://download.opensuse.org/repositories/security/$VERSION_ID/security.repo"
		sudo zypper addrepo https://download.docker.com/linux/sles/docker-ce.repo
		sudo zypper install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
	else
		sudo SUSEConnect -p sle-module-containers/$unames/$unamem -r ''
		sudo zypper install -y docker
	fi

	#Installed=`sudo zypper search --installed-only -v docker | sed -n '6p' | cut -c 28-40`
	#Candidate=`sudo zypper info docker | sed -n '10p' | cut -c 18-`
elif [ "$lpms" == "apt" ] || [ "$lpms" == "apt-get" ] || [ "$lpms" == "dpkg" ]
then
	sudo $lpms update
	sudo $lpms -y install ca-certificates curl gnupg lsb-release
	sudo mkdir -m 0755 /etc/apt/keyrings
	sudo curl -fsSL https://download.docker.com/linux/$operation_system/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
	sudo chmod a+r /etc/apt/keyrings/docker.gpg
	# Add the repository to Apt sources:
	echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/$operation_system $codename stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
	sudo $lpms update
	sudo $lpms -y install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

	#Installed=`sudo apt-cache policy docker-ce | sed -n '2p' | cut -c 14-`
	#Candidate=`sudo apt-cache policy docker-ce | sed -n '3p' | cut -c 14-`
elif [ "$lpms" == "pacman" ]
then
	sudo pacman-key --init
	sudo pacman-key --populate
	sudo pacman -Syu --noconfirm
	sudo pacman -S --noconfirm docker docker-buildx bind-tools
else
	echo
	echo "No supported package manager found"
	echo
	exit 0
fi

#sudo apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
#if [[ "$Installed" != "$Candidate" ]]; then
#	sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
#elif [[ "$Installed" == "$Candidate" ]]; then
#	echo
#	echo 'docker currently version already installed.'
#fi

if [ $? -ne 0 ]
then
	exit 0
fi

if ps -p 1 -o comm= | grep -q systemd
then
	sudo systemctl daemon-reload
fi

if [ $lpms != "apk" ]
then
	sudo systemctl enable docker.service
	sudo systemctl enable containerd.service
	sudo systemctl start docker
fi

echo
echo "Done ✓"
echo "======================================================================="

##########
# Run Docker without sudo rights
##########
echo
echo
echo "======================================================================="
echo "| Running Docker without sudo rights..."
echo "======================================================================="
echo
sleep 2

sudo groupadd docker
sudo usermod -aG docker ${USER}
# su - ${USER} &

echo
echo "Done ✓"
echo "======================================================================="

##########
# Install Docker Compose
##########
echo
echo
echo "======================================================================="
echo "| Installing Docker Compose v2.32.4..."
echo "======================================================================="
echo
sleep 2

sudo mkdir -p /usr/local/lib/docker/cli-plugins
sudo curl -SL "https://github.com/docker/compose/releases/download/v2.32.4/docker-compose-$unames-$unamem" -o /usr/local/lib/docker/cli-plugins/docker-compose
sudo chmod +x /usr/local/lib/docker/cli-plugins/docker-compose

echo
echo "Done ✓"
echo "======================================================================="

##########
# permission for Docker daemon socket
##########
echo
echo
echo "======================================================================="
echo "| permission for Docker daemon socket..."
echo "======================================================================="
echo
sleep 2

sudo chmod 666 /var/run/docker.sock

echo
echo "Done ✓"
echo "======================================================================="

clear
##########
# Setup project variables
##########
echo
echo "======================================================================="
echo "| Please enter project related variables..."
echo "======================================================================="
echo
sleep 2

# set the host
which_h=""
items=("localhost" "remotehost")
PS3="which computer command line are you on? Select the host: "
select h in "${items[@]}"
do
	case $REPLY in
		1)
			which_h=$h
			break;;
		2)
			which_h=$h
			break;;
		*)
			echo "Invalid choice $REPLY";;
	esac
done
echo "Ok."

# set your domain name
if [ "$which_h" == "localhost" ]
then
	read -p 'Enter Domain Name(default : localhost or e.g. : example.com): ' domain_name
	: ${domain_name:=localhost}
	[ "$domain_name" != "localhost" ] && sudo -- sh -c -e "grep -qxF '127.0.1.1  $domain_name' /etc/hosts || echo '127.0.1.1  $domain_name' >> /etc/hosts"
	ping -c 1 $domain_name 2>&1 > /dev/null
else
	domain_name=""
	read -p 'Enter Domain Name(e.g. : example.com): ' domain_name
	#[ "$domain_name" != "localhost" ] && sudo -- sh -c -e "sed -i '/$domain_name/d' /etc/hosts"
	[ -z $domain_name ] && domain_name="NULL"
	host -N 0 $domain_name 2>&1 > /dev/null
fi
#[ -z $domain_name ] && domain_name="NULL"
#host -N 0 $domain_name 2>&1 > /dev/null
while [ $? -ne 0 ]
do
	echo "Try again"
	sudo -- sh -c -e "sed -i '/$domain_name/d' /etc/hosts"
	if [ "$which_h" == "localhost" ]
	then
		read -p 'Enter Domain Name(default : localhost or e.g. : example.com): ' domain_name
		: ${domain_name:=localhost}
		[ "$domain_name" != "localhost" ] && sudo -- sh -c -e "grep -qxF '127.0.1.1  $domain_name' /etc/hosts || echo '127.0.1.1  $domain_name' >> /etc/hosts"
		ping -c 1 $domain_name 2>&1 > /dev/null
	else
		read -p 'Enter Domain Name(e.g. : example.com): ' domain_name
		#[ "$domain_name" != "localhost" ] && sudo -- sh -c -e "sed -i '/$domain_name/d' /etc/hosts"
		[ -z $domain_name ] && domain_name="NULL"
		host -N 0 $domain_name 2>&1 > /dev/null
	fi
	#[ -z $domain_name ] && domain_name="NULL"
	#host -N 0 $domain_name 2>&1 > /dev/null
done
echo "Ok."

ssl_snippet=""
if [ "$which_h" == "localhost" ]
then
	ssl_snippet="echo 'Generated Self-signed SSL Certificate at localhost'"
	if [ "$lpms" == "apk" ]
	then
		sudo apk add --no-cache nss-tools go git
	elif [ "$lpms" == "dnf" ]
	then
		sudo dnf install nss-tools go git
	elif [ "$lpms" == "yum" ]
	then
		sudo yum install nss-tools go git
	elif [ "$lpms" == "zypper" ]
	then
		sudo zypper install mozilla-nss-tools go git
	elif [ "$lpms" == "apt" ]
	then
		sudo apt install libnss3-tools go git
	elif [ "$lpms" == "pacman" ]
	then
		sudo pacman -S nss go git
	else
		echo
		echo "No supported package manager found"
		echo
		exit 0
	fi
	sudo rm -Rf mkcert && git clone https://github.com/FiloSottile/mkcert &&
	cd ./mkcert
	sudo go build -ldflags "-X main.Version=$(git describe --tags)"
	sudo ./mkcert -uninstall && ./mkcert -install && ./mkcert -key-file privkey.pem -cert-file chain.pem $domain_name *.$domain_name && sudo cat privkey.pem chain.pem > fullchain.pem && sudo mkdir -p ../certbot/live/$domain_name && sudo mv *.pem ../certbot/live/$domain_name
	cd ..
	echo "Ok."
else
	ssl_snippet="certbot certonly --webroot --webroot-path \/tmp\/acme-challenge --rsa-key-size 4096 --non-interactive --agree-tos --no-eff-email --force-renewal --email \$\{LETSENCRYPT_EMAIL\} -d \$\{DOMAIN_NAME\} -d www.\$\{DOMAIN_NAME\}"
fi

# set parameters in env.example file
email=""
regex="^[a-zA-Z0-9\._-]+\@[a-zA-Z0-9._-]+\.[a-zA-Z]+\$"
read -p 'Enter Email Address for letsencrypt ssl(e.g. : email@domain.com): ' email
while [ -z $email ] || [[ ! $email =~ $regex ]]
do
	echo "Try again"
	read -p 'Enter Email Address for letsencrypt ssl(e.g. : email@domain.com): ' email
	sleep 1
done
echo "Ok."

db_username=""
db_regex="^[0-9a-zA-Z\$_]{6,}$"
read -p 'Enter Database Username(at least 6 characters): ' db_username
while [[ ! $db_username =~ $db_regex ]]
do
	echo "Try again (can only contain numerals 0-9, basic Latin letters, both lowercase and uppercase, dollar sign and underscore)"
	read -p 'Enter Database Username(at least 6 characters): ' db_username
	sleep 1
done
echo "Ok."

db_password=""
password_regex="^[a-zA-Z0-9\._-]{6,}$"
read -p 'Enter Database Password(at least 6 characters): ' db_password
while [[ ! $db_password =~ $password_regex ]]
do
	echo "Try again (can only contain numerals 0-9, basic Latin letters, both lowercase and uppercase, dot, underscore and minus sign)"
	read -p 'Enter Database Password(at least 6 characters): ' db_password
	sleep 1
done
echo "Ok."

db_name=""
read -p 'Enter Database Name(at least 6 characters): ' db_name
while [[ ! $db_name =~ $db_regex ]]
do
	echo "Try again (can only contain numerals 0-9, basic Latin letters, both lowercase and uppercase, dollar sign and underscore)"
	read -p 'Enter Database Name(at least 6 characters): ' db_name
	sleep 1
done
echo "Ok."

db_table_prefix_regex="^[0-9a-zA-Z\$_]{3,}$"
read -p 'Enter Database Table Prefix(at least 3 characters, default : wp_): ' db_table_prefix
: ${db_table_prefix:=wp_}
while [[ ! $db_table_prefix =~ $db_table_prefix_regex ]]
do
	echo "Try again (can only contain numerals 0-9, basic Latin letters, both lowercase and uppercase, dollar sign and underscore)"
	read -p 'Enter Database Table Prefix(at least 3 characters, default : wp_): ' db_table_prefix
	: ${db_table_prefix:=wp_}
	sleep 1
done
echo "Ok."

mysql_root_password=""
read -p 'Enter MariaDb/Mysql Root Password(at least 6 characters): ' mysql_root_password
while [[ ! $mysql_root_password =~ $password_regex ]]
do
	echo "Try again (can only contain numerals 0-9, basic Latin letters, both lowercase and uppercase, dot, underscore and minus sign)"
	read -p 'Enter MariaDb/Mysql Root Password(at least 6 characters): ' mysql_root_password
	sleep 1
done
echo "Ok."

pma_username=""
read -p 'Enter PhpMyAdmin Username(at least 6 characters): ' pma_username
while [[ ! $pma_username =~ $db_regex ]]
do
	echo "Try again (can only contain numerals 0-9, basic Latin letters, both lowercase and uppercase, dollar sign and underscore)"
	read -p 'Enter PhpMyAdmin Username(at least 6 characters): ' pma_username
	sleep 1
done
echo "Ok."

pma_password=""
read -p 'Enter PhpMyAdmin Password(at least 6 characters): ' pma_password
while [[ ! $pma_password =~ $password_regex ]]
do
	echo "Try again (can only contain numerals 0-9, basic Latin letters, both lowercase and uppercase, dot, underscore and minus sign)"
	read -p 'Enter PhpMyAdmin Password(at least 6 characters): ' pma_password
	sleep 1
done
echo "Ok."

which_db=""
db_authentication_password=$pma_password
db_package_manager="apt-get update \&\& apt-get install -y gettext-base"
db_admin_commandline="mariadb-admin"
PS3="Select the database: "
select db in mariadb mysql
do
	which_db=$db
	if [ $REPLY -eq 2 ]
	then
		db_package_manager="microdnf update -y \&\& microdnf install -y gettext"
		db_admin_commandline="mysqladmin"
	fi
	if [ $REPLY -eq 1 ] || [ $REPLY -eq 2 ]
	then
		break
	else
		PS3="Select the database: "
	fi
done
echo "Ok."

local_timezone_regex="^[a-zA-Z0-9/+_-]{1,}$"
read -p 'Enter container local Timezone(default : America/Los_Angeles, to see the other timezones, https://en.wikipedia.org/wiki/List_of_tz_database_time_zones#List): ' local_timezone
: ${local_timezone:=America/Los_Angeles}
while [[ ! $local_timezone =~ $local_timezone_regex ]]
do
	echo "Try again (can only contain numerals 0-9, basic Latin letters, both lowercase and uppercase, positive, minus sign and underscore)"
	read -p 'Enter container local Timezone(default : America/Los_Angeles, to see the other local timezones, https://en.wikipedia.org/wiki/List_of_tz_database_time_zones#List): ' local_timezone
	sleep 1
	: ${local_timezone:=America/Los_Angeles}
done
local_timezone=${local_timezone//[\/]/\\\/}
echo "Ok."

read -p "Apply changes (y/n)? " choice
case "$choice" in
  y|Y ) clear; echo; echo "Yes! Proceeding now...";;
  n|N ) echo "No! Aborting now..."; exit 0;;
  * ) echo "Invalid input! Aborting now..."; exit 0;;
esac

\cp ./phpmyadmin/apache2/sites-available/default-ssl.sample.conf ./phpmyadmin/apache2/sites-available/default-ssl.conf
\cp ./database/phpmyadmin/sql/create_tables.sql.template.example ./database/phpmyadmin/sql/create_tables.sql.template

\cp env.example .env

sed -i "s/db_authentication_password/${db_authentication_password}/" ./database/phpmyadmin/sql/create_tables.sql.template
sed -i "s|db_package_manager|${db_package_manager}|" .env
sed -i 's/db_admin_commandline/'$db_admin_commandline'/' .env
sed -i 's/example.com/'$domain_name'/' .env
sed -i 's/example.com/'$domain_name'/g' ./phpmyadmin/apache2/sites-available/default-ssl.conf
sed -i 's/email@domain.com/'$email'/' .env
sed -i "s/ssl_snippet/$ssl_snippet/" .env
sed -i 's/which_db/'$which_db'/g' .env
sed -i 's/db_username/'$db_username'/g' .env
sed -i 's/db_password/'$db_password'/g' .env
sed -i 's/db_name/'$db_name'/' .env
sed -i 's/db_table_prefix/'$db_table_prefix'/' .env
sed -i 's/mysql_root_password/'$mysql_root_password'/' .env
sed -i 's/pma_username/'$pma_username'/' .env
sed -i 's/pma_password/'$pma_password'/' .env
sed -i 's/pma_controluser/'$pma_username'/g' ./database/phpmyadmin/sql/create_tables.sql.template
sed -i "s@directory_path@$(pwd)@" .env
sed -i 's/local_timezone/'$local_timezone'/' .env
sed -i 's/varnish_version/'$varnish_version'/' .env

if [ -x "$(command -v docker)" ] && [ "$(docker compose version)" ]; then
	# Firstly: create external volume
	docker volume create --driver local --opt type=none --opt device=`pwd`/certbot --opt o=bind certbot-etc > /dev/null
	# installing WordPress and the other services
	docker compose up -d & export pid=$!
	echo "WordPress and the other services installing proceeding..."
	echo
	wait $pid
	if [ $? -eq 0 ]
	then
		# installing portainer
		docker compose -f portainer-docker-compose.yml -p portainer up -d & export pid=$!
		echo
		echo "portainer installing proceeding..."
		wait $pid
		if [ $? -ne 0 ]; then
			echo "Error! could not installed portainer" >&2
			exit 1
		else
			echo
			until [ -n "$(sudo find ./certbot/live -name '$domain_name' 2>/dev/null | head -1)" ]; do
				echo "waiting Let's Encrypt certificates for $domain_name"
				sleep 5s & wait ${!}
				if sudo [ -d "./certbot/live/$domain_name" ]; then break; fi
			done
			echo "Ok."
			#until [ ! -z `docker compose ps -a --filter "status=running" --services | grep webserver` ]; do
			#	echo "waiting starting webserver container"
			#	sleep 2s & wait ${!}
			#	if [ ! -z `docker compose ps -a --filter "status=running" --services | grep webserver` ]; then break; fi
			#done
			echo
			echo "Loading webserver ssl configuration"
			docker container restart webserver > /dev/null 2>&1
			echo "Ok."
			echo
			echo "completed setup"
			echo
			echo "Website: https://$domain_name"
			echo "Portainer: https://$domain_name:9001"
			echo "phpMyAdmin: https://$domain_name:9090"
			echo
			echo "Ok."
		fi
	else
		echo
		echo "Error! could not installed WordPress and the other services with docker compose" >&2
		echo
		exit 1
	fi
else
	echo
	echo "not found docker and/or docker compose, Install docker and/or docker compose" >&2
	echo
	exit 1
fi
