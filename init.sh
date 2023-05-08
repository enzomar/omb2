#!/bin/bash


cd revproxy
docker-compose up -d
cd ..



cd db 
docker-compose up -d

sleep 2

cd conf
sh setup_db.sh
cd ..


docker ps

docker network ls