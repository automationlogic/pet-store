#!/bin/bash
# Build and deploy pet-store app on Docker

if [ $# -eq 0 ]
then
    echo "Image version not provided."
    exit 1
fi

mvn clean package
#docker build -t lwilts/cicd_demo:$1 .
echo "*** Building dockerfile ***"
curl --request POST -H "Content-Type:application/tar" --data-binary @dockerfile http://172.17.42.1:2375/build
#docker login -u lwilts
#docker push lwilts/cicd_demo

# LOCAL DEPLOY
#docker kill pet-store && docker rm pet-store
echo "*** Removing old pet-store ***"
curl --request DELETE http://172.17.42.1:2375/containers/pet-store?force=true
#docker run --name pet-store -p 80:8080 -d lwilts/cicd_demo:$1
echo "*** Creating new pet-store ***"
curl --request POST -H "Content-Type:application/json" --data-binary @container.json http://172.17.42.1:2375/containers

exit 0
