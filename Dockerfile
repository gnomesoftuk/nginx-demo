FROM ubuntu@sha256:d21429c4635332e96a4baae3169e3f02ac8e24e6ae3d89a86002d49a1259a4f7

RUN groupadd -g 1001 nginx && \
    useradd -u 1001 -g 1001 --no-create-home --home /none --shell /bin/false nginx

RUN apt-get -y update && apt-get install -y nginx

COPY ./nginx.conf /etc/nginx/nginx.conf
COPY ./default.conf /etc/nginx/conf.d/default.conf

## add permissions for nginx user
RUN chown -R nginx:nginx /app && chmod -R 755 /app && \
        chown -R nginx:nginx /var/cache/nginx && \
        chown -R nginx:nginx /var/log/nginx && \
        chown -R nginx:nginx /etc/nginx/conf.d
RUN touch /var/run/nginx.pid && \
        chown -R nginx:nginx /var/run/nginx.pid

USER nginx

EXPOSE 8080/tcp

STOPSIGNAL SIGQUIT

CMD ["/usr/sbin/nginx", "-g", "daemon off;"]