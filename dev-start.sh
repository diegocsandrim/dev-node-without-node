#/bin/bash
set -e

HOST_PORT=${1:-3000}
APP_NAME=${PWD##*/}

#Delete old container
docker kill $APP_NAME || true
docker rm $APP_NAME | true

#Build the new docker image
docker build -t $APP_NAME .

#Run the docker image
docker run -d -p $HOST_PORT:3000 -v $(pwd):/usr/src/$APP_NAME --name $APP_NAME $APP_NAME

echo -e '\033[1;32mType ctrl+p+q to exit docker\033[0m'

#Enter the container
docker exec -it $APP_NAME /bin/bash

#Fix ownership of project files from docker to current user
chown -R $USER .
