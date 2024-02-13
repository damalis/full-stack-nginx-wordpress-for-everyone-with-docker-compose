#!/bin/bash

clear
echo ""
echo "====================================================================="
echo "|                                                                   |"
echo "|    full-stack-nginx-wordpress-for-everyone-with-docker-compose    |"
echo "|                     by Erdal ALTIN                                |"
echo "|                                                                   |"
echo "====================================================================="
sleep 2

# the "lpms" is an abbreviation of Linux Package Management System
lpms=""
for i in apk dnf yum apt zypper
do
	if [ -x "$(command -v $i)" ]; then
		if [ "$i" == "apk" ]
		then
			lpms=$i
			break
		elif [ "$i" == "dnf" ] && ([[ $(grep -Pow 'ID=\K[^;]*' /etc/os-release | tr -d '"') == "fedora" ]] || (([[ $(grep -Pow 'ID=\K[^;]*' /etc/os-release | tr -d '"') != "centos" ]] && [[ $(grep -Pow 'ID_LIKE=\K[^;]*' /etc/os-release | tr -d '"') == *"fedora"* ]]) || ([[ $(grep -Pow 'ID_LIKE=\K[^;]*' /etc/os-release | tr -d '"') == *"rhel"* ]] && [ $(sudo uname -m) == "s390x" ])))
		then
			lpms=$i
			break
		elif [ "$i" == "yum" ] && ([[ $(grep -Pow 'ID=\K[^;]*' /etc/os-release | tr -d '"') == "centos" ]] || (([[ $(grep -Pow 'ID=\K[^;]*' /etc/os-release | tr -d '"') != "fedora" ]] && [[ $(grep -Pow 'ID_LIKE=\K[^;]*' /etc/os-release | tr -d '"') == *"fedora"* ]]) || ([[ $(grep -Pow 'ID_LIKE=\K[^;]*' /etc/os-release | tr -d '"') == *"rhel"* ]] && [ $(sudo uname -m) == "s390x" ])))
		then
			lpms=$i
			break
		elif [ "$i" == "apt" ] && ([[ $(grep -Pow 'ID=\K[^;]*' /etc/os-release | tr -d '"') == *"ubuntu"* ]] || [[ $(grep -Pow 'ID=\K[^;]*' /etc/os-release | tr -d '"') == *"debian"* ]] || [[ $(grep -Pow 'ID_LIKE=\K[^;]*' /etc/os-release | tr -d '"') == *"ubuntu"* ]] || [[ $(grep -Pow 'ID_LIKE=\K[^;]*' /etc/os-release | tr -d '"') == *"debian"* ]])
		then
			lpms=$i
			break
		elif [[ $(grep -Pow 'ID_LIKE=\K[^;]*' /etc/os-release) == *"suse"* ]]
		then
			lpms=$i
			break
		fi
	fi
done

if [ -z $lpms ]; then
	echo ""
	echo "could not be detected package management system"
	echo ""
	exit 0
fi

##########
# set varnish version
##########
varnish_version="stable"
if ([[ $(grep -Pow 'VERSION_ID=\K[^;]*' /etc/os-release | tr -d '"') == 9* ]] && [ $(grep -Pow 'ID=\K[^;]*' /etc/os-release | tr -d '"') == "centos" ]) || [ $(grep -Pow 'ID=\K[^;]*' /etc/os-release | tr -d '"') == "fedora" ]
then
	varnish_version="latest"
fi

##########
# Uninstall old versions
##########
echo ""
echo ""
echo "====================================================================="
echo "| Older versions of Docker were called docker, docker.io, or docker-engine."
echo "| If these are installed or all conflicting packages, uninstall them."
echo "====================================================================="
echo ""
sleep 2

# linux remove command for pms
if [ "$lpms" == "apk" ]
then
	sudo apk del docker podman-docker
elif [ "$lpms" == "dnf" ]
then
	sudo dnf remove docker docker-client docker-client-latest docker-common docker-latest docker-latest-logrotate docker-logrotate docker-selinux docker-engine-selinux docker-engine
elif [ "$lpms" == "yum" ]
then
	sudo yum remove docker docker-client docker-client-latest docker-common docker-latest docker-latest-logrotate docker-logrotate docker-engine podman runc
elif [ "$lpms" == "apt" ]
then
	for pkg in docker docker-engine docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do sudo apt remove $pkg; done
elif [ "$lpms" == "zypper" ]
then
	if [[ $(grep -Pow 'ID=\K[^;]*' /etc/os-release | tr -d '"') == *"sles"* ]]
	then
		sudo zypper remove docker docker-client docker-client-latest docker-common docker-latest docker-latest-logrotate docker-logrotate docker-engine runc
	fi
else
	echo ""
	echo "could not be detected package management system"
	echo ""
	exit 0
fi

echo ""
echo "Done ✓"
echo "====================================================================="

##########
# Install Docker
##########
echo ""
echo ""
echo "====================================================================="
echo "| Install Docker..."
echo "====================================================================="
echo ""
sleep 2

if [ "$lpms" == "apk" ]
then
	sudo apk add --update docker openrc bind-tools
	sudo rc-update add docker boot
	sudo service docker start
elif [ "$lpms" == "dnf" ]
then
	sudo dnf -y install dnf-plugins-core
	if [[ $(grep -Pow 'ID=\K[^;]*' /etc/os-release | tr -d '"') == "fedora" ]] || ([[ $(grep -Pow 'ID=\K[^;]*' /etc/os-release | tr -d '"') == "rhel" ]] && [ $(sudo uname -m) == "s390x" ])
	then
		sudo dnf config-manager --add-repo https://download.docker.com/linux/$(grep -Pow 'ID=\K[^;]*' /etc/os-release | tr -d '"')/docker-ce.repo
		sudo dnf install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin bind-utils
	elif [[ $(grep -Pow 'ID=\K[^;]*' /etc/os-release | tr -d '"') != "rhel" ]]
	then
		sudo dnf install docker
	else
		echo ""
		echo "unsupport operation system and/or architecture"
		echo ""
		exit 0
	fi
elif [ "$lpms" == "yum" ]
then
	sudo yum install -y yum-utils
	if [[ $(grep -Pow 'ID=\K[^;]*' /etc/os-release | tr -d '"') == "centos" ]] || ([[ $(grep -Pow 'ID=\K[^;]*' /etc/os-release | tr -d '"') == "rhel" ]] && [ $(sudo uname -m) == "s390x" ])
	then
		sudo yum-config-manager --add-repo https://download.docker.com/linux/$(grep -Pow 'ID=\K[^;]*' /etc/os-release | tr -d '"')/docker-ce.repo
		sudo yum install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin bind-utils
	elif [[ $(grep -Pow 'ID=\K[^;]*' /etc/os-release | tr -d '"') != "rhel" ]]
	then 
		sudo yum install docker
	else
		echo ""
		echo "unsupport operation system and/or architecture"
		echo ""
		exit 0
	fi
elif [ "$lpms" == "zypper" ]
then
	if [[ $(grep -Pow 'ID=\K[^;]*' /etc/os-release | tr -d '"') == *"sles"* ]] && [ $(sudo uname -m) == "s390x" ]
	then
		# "https://download.opensuse.org/repositories/security:/SELinux/openSUSE_Factory/security:SELinux.repo"
		sudo zypper addrepo "https://download.opensuse.org/repositories/security/$(grep -Pow 'VERSION_ID=\K[^;]*' /etc/os-release | tr -d '"')/security.repo"
		sudo zypper addrepo https://download.docker.com/linux/sles/docker-ce.repo
		sudo zypper install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
	else
		sudo SUSEConnect -p sle-module-containers/$(sudo uname -s)/$(sudo uname -m) -r ''
		sudo zypper install docker
	fi

	#Installed=`sudo zypper search --installed-only -v docker | sed -n '6p' | cut -c 28-40`
	#Candidate=`sudo zypper info docker | sed -n '10p' | cut -c 18-`
elif [ "$lpms" == "apt" ]
then
	sudo apt update
	sudo apt install ca-certificates curl gnupg lsb-release
	sudo mkdir -m 0755 /etc/apt/keyrings
	curl -fsSL https://download.docker.com/linux/$(grep -Pow 'ID=\K[^;]*' /etc/os-release | tr -d '"')/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
	sudo chmod a+r /etc/apt/keyrings/docker.gpg
	# Add the repository to Apt sources:
	echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/$(grep -Pow 'ID=\K[^;]*' /etc/os-release | tr -d '"') $(grep -Po 'VERSION_CODENAME=\K[^;]*' /etc/os-release) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
	sudo apt update
	sudo apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

	#Installed=`sudo apt-cache policy docker-ce | sed -n '2p' | cut -c 14-`
	#Candidate=`sudo apt-cache policy docker-ce | sed -n '3p' | cut -c 14-`
else
	echo ""
	echo "could not be detected package management system"
	echo ""
	exit 0
fi

#sudo apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
#if [[ "$Installed" != "$Candidate" ]]; then
#	sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
#elif [[ "$Installed" == "$Candidate" ]]; then
#	echo ""
#	echo 'docker currently version already installed.'
#fi

if [ $? -ne 0 ]
then
	exit 0
fi

if [ $lpms != "apk" ]
then
	sudo systemctl enable docker.service
	sudo systemctl enable containerd.service
	sudo systemctl start docker
fi

echo ""
echo "Done ✓"
echo "====================================================================="

##########
# Run Docker without sudo rights
##########
echo ""
echo ""
echo "====================================================================="
echo "| Running Docker without sudo rights..."
echo "====================================================================="
echo ""
sleep 2

sudo groupadd docker
sudo usermod -aG docker ${USER}
# su - ${USER} &

echo ""
echo "Done ✓"
echo "====================================================================="

##########
# Install Docker Compose
##########
echo ""
echo ""
echo "====================================================================="
echo "| Installing Docker Compose v2.23.3..."
echo "====================================================================="
echo ""
sleep 2

sudo mkdir -p /usr/local/lib/docker/cli-plugins
sudo curl -SL "https://github.com/docker/compose/releases/download/v2.23.3/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/lib/docker/cli-plugins/docker-compose
sudo chmod +x /usr/local/lib/docker/cli-plugins/docker-compose

echo ""
echo "Done ✓"
echo "====================================================================="

##########
# permission for Docker daemon socket
##########
echo ""
echo ""
echo "====================================================================="
echo "| permission for Docker daemon socket..."
echo "====================================================================="
echo ""
sleep 2

sudo chmod 666 /var/run/docker.sock

echo ""
echo "Done ✓"
echo "====================================================================="

##########
# Setup project variables
##########
echo ""
echo ""
echo "====================================================================="
echo "| Please enter project related variables..."
echo "====================================================================="
echo ""
sleep 2

# set your domain name
domain_name=""
read -p 'Enter Domain Name(e.g. : example.com): ' domain_name
[ -z $domain_name ] && domain_name="NULL"
host -N 0 $domain_name 2>&1 > /dev/null
while [ $? -ne 0 ]
do
	echo "Try again"
	read -p 'Enter Domain Name(e.g. : example.com): ' domain_name
	[ -z $domain_name ] && domain_name="NULL"
	host -N 0 $domain_name 2>&1 > /dev/null
done
echo "Ok."

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
db_authentication_plugin="mysql_native_password"
db_authentication_password="USING PASSWORD('"$pma_password"')"
db_package_manager="apt-get update \&\& apt-get install -y gettext-base"
db_admin_commandline="mariadb-admin"
PS3="Select the database: "
select db in mariadb mysql
do
	which_db=$db
	if [ $REPLY -eq 2 ]
	then
		db_authentication_plugin="caching_sha2_password"
		db_authentication_password="BY '"$pma_password"'"
		db_package_manager="microdnf install -y gettext"
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
read -p 'Enter container local Timezone(default : America/Los_Angeles, to see the other timezones, https://docs.diladele.com/docker/timezones.html): ' local_timezone
: ${local_timezone:=America/Los_Angeles}
while [[ ! $local_timezone =~ $local_timezone_regex ]]
do
	echo "Try again (can only contain numerals 0-9, basic Latin letters, both lowercase and uppercase, positive, minus sign and underscore)"
	read -p 'Enter container local Timezone(default : America/Los_Angeles, to see the other local timezones, https://docs.diladele.com/docker/timezones.html): ' local_timezone
	sleep 1
	: ${local_timezone:=America/Los_Angeles}
done
local_timezone=${local_timezone//[\/]/\\\/}
echo "Ok."

read -p "Apply changes (y/n)? " choice
case "$choice" in
  y|Y ) echo "Yes! Proceeding now...";;
  n|N ) echo "No! Aborting now..."; exit 0;;
  * ) echo "Invalid input! Aborting now..."; exit 0;;
esac

cp ./phpmyadmin/apache2/sites-available/default-ssl.sample.conf ./phpmyadmin/apache2/sites-available/default-ssl.conf
cp ./database/phpmyadmin/sql/create_tables.sql.template.example ./database/phpmyadmin/sql/create_tables.sql.template

cp env.example .env

sed -i 's/db_authentication_plugin/'$db_authentication_plugin'/' ./database/phpmyadmin/sql/create_tables.sql.template
sed -i "s/db_authentication_password/${db_authentication_password}/" ./database/phpmyadmin/sql/create_tables.sql.template
sed -i 's/db_authentication_plugin/'$db_authentication_plugin'/' .env
sed -i "s|db_package_manager|${db_package_manager}|" .env
sed -i 's/db_admin_commandline/'$db_admin_commandline'/' .env
sed -i 's/example.com/'$domain_name'/' .env
sed -i 's/example.com/'$domain_name'/g' ./phpmyadmin/apache2/sites-available/default-ssl.conf
sed -i 's/email@domain.com/'$email'/' .env
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
	echo ""
	wait $pid
	if [ $? -eq 0 ]
	then
		# installing portainer
		docker compose -f portainer-docker-compose.yml -p portainer up -d & export pid=$!
		echo ""
		echo "portainer installing proceeding..."
		wait $pid
		if [ $? -ne 0 ]; then
			echo "Error! could not installed portainer" >&2
			exit 1
		else
			echo ""
			until [ -n "$(sudo find ./certbot/live -name '$domain_name' 2>/dev/null | head -1)" ]; do
				echo "waiting for Let's Encrypt certificates for $domain_name"
				sleep 5s & wait ${!}
				if sudo [ -d "./certbot/live/$domain_name" ]; then break; fi
			done
			echo "Ok."
			#until [ ! -z `docker compose ps -a --filter "status=running" --services | grep webserver` ]; do
			#	echo "waiting starting webserver container"
			#	sleep 2s & wait ${!}
			#	if [ ! -z `docker compose ps -a --filter "status=running" --services | grep webserver` ]; then break; fi
			#done
			echo ""
			echo "Reloading webserver ssl configuration"
			docker container restart webserver > /dev/null 2>&1
			echo "Ok."
			echo ""
			echo "completed setup"
			echo ""
			echo "Website: https://$domain_name"
			echo "Portainer: https://$domain_name:9001"
			echo "phpMyAdmin: https://$domain_name:9090"
			echo ""
			echo "Ok."
		fi
	else
		echo ""
		echo "Error! could not installed WordPress and the other services with docker compose" >&2
		echo ""
		exit 1
	fi
else
	echo ""
	echo "not found docker and/or docker compose, Install docker and/or docker compose" >&2
	echo ""
	exit 1
fi
