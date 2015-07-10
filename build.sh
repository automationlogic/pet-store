#!/bin/bash
# Build and deploy pet-store app on Docker

if [ $# -eq 0 ]
then
    echo "Image version not provided."
    exit 1
fi

mvn clean package
#docker build -t lwilts/pet_store_demo:$1 .
echo "*** Building dockerfile ***"
tar zcf dockerfile.tar.gz dockerfile
curl --verbose --request POST -H "Content-Type:application/tar" --data-binary '@dockerfile.tar.gz' http://172.17.42.1:2375/build?t=lwilts/pet_store_demo:$1&nocache=true
#docker login -u lwilts
#docker push lwilts/pet_store_demo

# REMOTE DEPLOY
#docker kill pet-store && docker rm pet-store
echo "*** Removing old pet-store ***"
curl --verbose --request DELETE http://172.17.42.1:2375/containers/pet-store?force=true
#docker run --name pet-store -p 80:8080 -d lwilts/pet_store_demo:$1
echo "*** Creating new pet-store ***"
sed -i "s/BUILD_NUMBER/$1/g" container.json
curl --verbose --request POST -H "Content-Type:application/json" --data-binary '@container.json' http://172.17.42.1:2375/containers/create?name=pet-store
curl --verbose --request POST http://172.17.42.1:2375/containers/pet-store/start
exit 0
