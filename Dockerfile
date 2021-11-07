FROM node:14-slim

RUN mkdir /home/node/app && chown -R node:node /home/node/app

WORKDIR /home/node/app
USER node
