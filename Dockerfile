FROM nginx
RUN apt install curl
RUN curl -sL https://deb.nodesource.com/setup_14.x -o nodesource_setup.sh
RUN bash nodesource_setup.sh
RUN apt install nodejs
RUN npm install -g @angular/cli
RUN ng build --prod --output-path /var/www/konczevolgyi-vendeghaz.hu/html
COPY konczevolgyi-vendeghaz.hu /etc/nginx/sites-enabled/konczevolgyi-vendeghaz.hu
COPY nginx.conf /etc/nginx/nginx.conf