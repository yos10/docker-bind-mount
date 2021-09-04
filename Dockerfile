FROM node:14-slim

RUN apt-get update && apt-get install -y locales \
        && locale-gen ja_JP.UTF-8 \
        && localedef -f UTF-8 -i ja_JP ja_JP
ENV LANG ja_JP.UTF-8
ENV TZ Asia/Tokyo

RUN mkdir /home/node/app && chown -R node:node /home/node/app

WORKDIR /home/node/app
USER node
