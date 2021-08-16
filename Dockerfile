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
COPY nginx.conf /etc/nginx/nginx.conf
COPY --from=build /usr/src/app/dist /var/www/konczevolgyi-vendeghaz.hu/html/
COPY konczevolgyi-vendeghaz.hu /etc/nginx/sites-enabled/konczevolgyi-vendeghaz.hu
