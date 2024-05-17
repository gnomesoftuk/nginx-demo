FROM ubuntu@sha256:d21429c4635332e96a4baae3169e3f02ac8e24e6ae3d89a86002d49a1259a4f7

RUN apt-get update && apt-get install -y nginx
COPY nginx.conf /etc/nginx/sites-available/default

RUN groupadd -g 1001 nginx && \
    useradd -u 1001 -g 1001 -ms /bin/sh nginx \
    && chown -R nginx:nginx /etc/nginx \
    && chown -R nginx:nginx /var/lib/nginx \
    && chown -R nginx:nginx /var/log/nginx

USER nginx

EXPOSE 80/tcp

CMD ["/usr/sbin/nginx", "-g", "daemon off;"]