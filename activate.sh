#!/bin/sh

SVC=$1 #backend, frontend ... folder name
VERSION=$2

#############################################
blues=$(docker ps --format '{{ .ID }}\t{{.Image}}\t{{ .Names }}\t{{ .Labels }}' | grep ${SVC}/blue)
if [ ! -z "$blues" ]
then
    echo "blue is active, we prepare to activate green"		
    ENV="green"
    OLD="blue"
else
	echo "green is active, we prepare to activate blue"		
    ENV="blue"
    OLD="green"
fi

#############################################
swd=$(dirname "$0")
ENV_DOCKERCOMPOSEFILE=${swd}/${SVC}/${ENV}/docker-compose.yaml
OLD_DOCKERCOMPOSEFILE=${swd}/${SVC}/${OLD}/docker-compose.yaml

echo "start "${ENV_DOCKERCOMPOSEFILE}
echo "stop "${OLD_DOCKERCOMPOSEFILE}


#############################################
./update.sh ${swd}/${SVC} ${ENV} $VERSION

#############################################
echo "Starting "$ENV" container for "$SVC""
docker-compose -p$ENV$SVC -f ${ENV_DOCKERCOMPOSEFILE} up -d --remove-orphans

echo "Waiting..."
sleep 2

echo "Checking new container are up before stopping the old ones.."
confirmed=$(docker ps --format '{{ .ID }}\t{{.Image}}\t{{ .Names }}\t{{ .Labels }}' | grep ${SVC}/${ENV})

if [ -z "$confirmed" ]
then
	echo "ERROR: New containers did not started => keeping "$OLD" container"	
	echo "ERROR: New containers did not started => clean up "$ENV" container"	
	docker-compose -p$ENV$SVC -f ${ENV_DOCKERCOMPOSEFILE} stop
else
	echo "SUCCESS: New containers started => Stopping "$OLD" container"	
	docker-compose -p$OLD$SVC -f ${OLD_DOCKERCOMPOSEFILE} stop
fi

docker ps
