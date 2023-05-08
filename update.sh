#!/bin/sh

WD=$1
COLOR=$2
VERSION=$3

ORIGIN=${WD}/white/docker-compose.yaml
DEST=${WD}/${COLOR}/docker-compose.yaml


if [ ! -d ${WD}/${COLOR} ]; then
  echo "generate "$COLOR" folder"
  cp -r ${WD}/white ${WD}/${COLOR}
fi

sed "s/VERSION/${VERSION}/g" ${ORIGIN} > ${DEST}

