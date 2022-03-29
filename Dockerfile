FROM nginxinc/nginx-unprivileged:latest
COPY ./html/index.html /usr/share/nginx/html/index.html
COPY ./html/404.html /usr/share/nginx/html/404.html
COPY ./docker/default.conf /etc/nginx/conf.d/default.conf