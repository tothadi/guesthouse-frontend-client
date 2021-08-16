### STAGE 1: Build ###
FROM node:lts as build
ENV NODE_ENV=production
ENV HOST '0.0.0.0'

WORKDIR '/usr/src/app'

COPY backend ./backend
COPY src ./src
RUN ls backend
COPY package.json ./
COPY angular.json ./
COPY tsconfig* ./
COPY karma.conf.js ./

RUN npm i
RUN npm i @angular/cli --no-progress --loglevel=error
RUN npm run build:app
RUN cd backend
RUN npm i --production

RUN npm start

