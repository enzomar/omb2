#!/bin/sh


checkSSL ()
{
	status_code=$(curl -k --write-out %{http_code} --silent --output /dev/null $1)

	if [[ "$status_code" -ne 200 ]] ; then
	  	echo $2 "KO"
	else
		echo $2 "OK"
	fi
}



for ((n=0;n<1;n++))
do
	checkSSL https://127.0.0.1 "FRONTEND"
	checkSSL https://127.0.0.1/api "BACKEND"
done
