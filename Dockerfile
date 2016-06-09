FROM node:4.4.3

# Add global dependences
RUN npm install -g nodemon

#Add the package.json
COPY ./package.json /usr/src/node-test/package.json

#Set the workdir to app source
WORKDIR /usr/src/node-test

#Install dependences
RUN npm install --production

#Add source code
COPY . /usr/src/node-test

#Run
CMD nodemon ./bin/www
