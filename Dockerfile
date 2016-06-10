FROM node:4.4.3

#Add the package.json
COPY ./package.json /usr/src/dev-node-without-node/package.json

#Set the workdir to app source
WORKDIR /usr/src/dev-node-without-node

#Install dependences
RUN npm install --production

#Add source code
COPY . /usr/src/dev-node-without-node

#Run
CMD ["npm", "start"]
