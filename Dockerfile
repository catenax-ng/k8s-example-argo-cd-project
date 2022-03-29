FROM nginxinc/nginx-unprivileged:latest
COPY ./html/index.html /usr/share/nginx/html/index.html