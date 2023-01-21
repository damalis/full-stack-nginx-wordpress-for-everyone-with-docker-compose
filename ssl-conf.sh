#!/bin/sh
set -e

if [ -z $1 ]; then
	echo "DOMAIN environment variable is not set"
	exit 1;
fi

if [ ! -f $2/ssl-dhparam.pem 2>/dev/null ]; then
	openssl dhparam -out $2/ssl-dhparam.pem 2048
fi

use_lets_encrypt_certificates() {
	echo "switching webserver to use Let's Encrypt certificate for $1"
	sed '/#location.\/./,/#}/ s/#//; s/#listen/listen/g; s/#ssl_/ssl_/g' $3/conf.d/default.conf > $3/conf.d/default.conf.bak
}

reload_webserver() {
	cp $1/conf.d/default.conf.bak $1/conf.d/default.conf
	rm $1/conf.d/default.conf.bak
	echo "Starting webserver nginx service"
	nginx -t
}

wait_for_lets_encrypt() {
	if [ -d "$2/live/$1" ]; then
		break 
	else
		until [ -d "$2/live/$1" ]; do
			echo "waiting for Let's Encrypt certificates for $1"
			sleep 5s & wait ${!}
			if [ -d "$2/live/$1" ]; then break; fi
		done
	fi;
	use_lets_encrypt_certificates "$1" "$2" "$3"
	reload_webserver "$3"
}

if [ ! -d "$2/live/$1" ]; then
	wait_for_lets_encrypt "$1" "$2" "$3" &
else
	use_lets_encrypt_certificates "$1" "$2" "$3"
	reload_webserver "$3"
fi

nginx -g 'daemon off;'
