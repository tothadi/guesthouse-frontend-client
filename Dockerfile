### STAGE 1: Build ###
FROM node:lts as build
ENV NODE_ENV=production
ENV HOST '0.0.0.0'

WORKDIR '/usr/src/app/'

RUN mkdir frontend
RUN mkdir dist
COPY backend ./
RUN npm i --production
COPY src ./frontend/src
COPY package.json ./frontend/
COPY angular.json ./frontend/
COPY tsconfig* ./frontend/
COPY karma.conf.js ./frontend/
RUN cd frontend
RUN npm i
RUN npm run build:app
RUN cd ..
RUN npm start