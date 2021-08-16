FROM nginx
WORKDIR '/app'
COPY src ./src
COPY package.json ./
COPY angular.json ./
COPY tsconfig* ./
COPY .browserlistsrc ./
COPY karma.conf.js ./
RUN pwd
RUN ls
RUN curl -sL https://deb.nodesource.com/setup_14.x -o nodesource_setup.sh
RUN bash nodesource_setup.sh
RUN apt install nodejs -y
RUN npm install -g @angular/cli
RUN npm install
RUN ng build --prod --output-path /var/www/konczevolgyi-vendeghaz.hu/html/
COPY konczevolgyi-vendeghaz.hu /etc/nginx/sites-enabled/konczevolgyi-vendeghaz.hu
COPY nginx.conf /etc/nginx/nginx.conf