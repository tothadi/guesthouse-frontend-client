### STAGE 1: Build ###
FROM node:lts as build
WORKDIR '/usr/src/app'
COPY src ./src
COPY package.json ./
COPY angular.json ./
COPY tsconfig* ./
COPY karma.conf.js ./

RUN npm i
RUN npm i @angular/cli --no-progress --loglevel=error
RUN npm run build:app

### STAGE 2: Setup ###
FROM nginx:alpine
COPY --from=build /usr/src/app/dist /usr/share/nginx/html
#CMD [nginx -g]