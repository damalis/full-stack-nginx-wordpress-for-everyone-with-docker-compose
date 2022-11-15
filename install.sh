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

# Uninstall old versions
echo "Older versions of Docker were called docker, docker.io, or docker-engine. If these are installed, uninstall them"

sudo apt-get remove docker docker-engine docker.io containerd runc

echo ""
echo "Done ✓"
echo "============================================"

# install start
sudo apt-get update
sudo apt-get install ca-certificates curl gnupg lsb-release
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(grep -Po 'UBUNTU_CODENAME=\K[^;]*' /etc/os-release) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo chmod 666 /var/run/docker.sock
sudo apt-get update

Installed=`sudo apt-cache policy docker-ce | sed -n '2p' | cut -c 14-`
Candidate=`sudo apt-cache policy docker-ce | sed -n '3p' | cut -c 14-`

if [[ "$Installed" != "$Candidate" ]]; then 
	sudo apt-get install docker-ce docker-ce-cli containerd.io
elif [[ "$Installed" == "$Candidate" ]]; then
	echo ""
	echo 'docker currently version already installed.'
fi


echo ""
echo "Done ✓"
echo "============================================"

##########
# Run Docker without sudo rights
##########
echo ""
echo ""
echo "============================================"
echo "| Running Docker without sudo rights..."
echo "============================================"
echo ""
sleep 2

sudo groupadd docker
sudo usermod -aG docker ${USER}
# su - ${USER} &

echo ""
echo "Done ✓"
echo "============================================"

##########
# Install Docker Compose
##########
echo ""
echo ""
echo "============================================"
echo "| Installing Docker Compose v2.12.2..."
echo "============================================"
echo ""
sleep 2

sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# permission for Docker daemon socket
sudo chmod 666 /var/run/docker.sock

echo ""
echo "Done ✓"
echo "============================================"

##########
# Setup project variables
##########
echo ""
echo ""
echo "============================================"
echo "| Please enter project related variables..."
echo "============================================"
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

local_timezone_regex="^[a-zA-Z0-9/+-_]{1,}$"
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
sed -i 's/example.com/'$domain_name'/g' ./phpmyadmin/apache2/sites-available/default-ssl.conf

cp env.example .env

sed -i 's/example.com/'$domain_name'/' .env
sed -i 's/email@domain.com/'$email'/' .env
sed -i 's/db_username/'$db_username'/g' .env
sed -i 's/db_password/'$db_password'/g' .env
sed -i 's/db_name/'$db_name'/' .env
sed -i 's/db_table_prefix/'$db_table_prefix'/' .env
sed -i 's/mysql_root_password/'$mysql_root_password'/' .env
sed -i 's/pma_username/'$pma_username'/' .env
sed -i 's/pma_password/'$pma_password'/' .env
sed -i "s@directory_path@$(pwd)@" .env
sed -i 's/local_timezone/'$local_timezone'/' .env

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
		docker volume create portainer_data > /dev/null
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
			until [ ! -z `docker ps -q -f "status=running" --no-trunc | grep $(docker compose ps -q webserver)` ]; do
				echo "waiting starting webserver container"
				sleep 2s & wait ${!}
				if [ ! -z `docker ps -q -f "status=running" --no-trunc | grep $(docker compose ps -q webserver)` ]; then break; fi
			done			
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
		exit 1
	fi
else
	echo ""
    echo "not found docker and/or docker compose, Install docker and/or docker compose" >&2
	exit 1
fi