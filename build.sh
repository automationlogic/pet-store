#!/bin/bash
# Build and deploy pet-store app on Docker

if [ $# -eq 0 ]
then
    echo "Image version not provided."
    exit 1
fi

cd /root/repos/pet-store
mvn clean package
docker build -t lwilts/cicd_demo:$1 .
docker login -u lwilts
docker push lwilts/cicd_demo

# LOCAL DEPLOY
docker kill pet-store
docker rm pet-store
docker run --name pet-store -p 80:8080 -d lwilts/cicd_demo:$1 

exit 0
