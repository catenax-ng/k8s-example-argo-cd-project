FROM nginxinc/nginx-unprivileged:1.23.3
COPY ./html/ /usr/share/nginx/html/
COPY ./docker/default.conf /etc/nginx/conf.d/default.conf
