### STAGE 1: Build ###
FROM node:lts as build
ENV NODE_ENV=production
ENV HOST '0.0.0.0'

WORKDIR '/usr/src/app'

COPY src ./src
COPY package.json ./
COPY angular.json ./
COPY tsconfig* ./
COPY karma.conf.js ./

RUN npm i
RUN npm i @angular/cli --no-progress --loglevel=error
RUN npm run build:app

WORKDIR '/usr/src/app/backend'
COPY backend ./
RUN npm i --production
RUN mkdir client
COPY ../dist/* ./client

RUN npm start