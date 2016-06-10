#/bin/bash
set -e

#Get parameters, fill defaults
FROM_IMAGE=${1:-'node:4.4.3'}
HOST_PORT=${2:-3000}

#Get app name: this dir name
APP_NAME=${PWD##*/}

#Stop old container
docker kill $APP_NAME || true
docker rm $APP_NAME || true

#Run the docker image, sharing your workdir
docker run -di \
  -w /usr/src/dev \
  -p $HOST_PORT:3000 \
  -v $(pwd):/usr/src/dev \
  --name $APP_NAME \
  $FROM_IMAGE /bin/bash

#Install dependences and run node
docker exec -d $APP_NAME npm install
docker exec -d $APP_NAME npm run dev

#Know how to exit docker
echo -e '\033[1;32mType ctrl+p+q to exit docker\033[0m'

#Connect to the container, a machine with Node.js installed!
docker exec -it $APP_NAME /bin/bash

#Stop container
docker kill $APP_NAME || true
docker rm $APP_NAME || true

#You are the owner of the files
sudo chown -R $USER .
