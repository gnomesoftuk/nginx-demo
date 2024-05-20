FROM nginx:1.26

LABEL source=https://github.com/gnomesoftuk/nginx-demo
LABEL name=nginx-demo

COPY ./nginx.conf /etc/nginx/nginx.conf
COPY ./default.conf /etc/nginx/conf.d/default.conf

WORKDIR /app

## add permissions for nginx user
RUN set -x \
        && chown -R nginx:nginx /var/cache/nginx \
        && chown -R nginx:nginx /var/log/nginx \
        && chown -R nginx:nginx /etc/nginx/conf.d \
        && touch /var/run/nginx.pid \
        && chown -R nginx:nginx /var/run/nginx.pid \
        # forward request and error logs to docker log collector
        && ln -sf /dev/stdout /var/log/nginx/access.log \
        && ln -sf /dev/stderr /var/log/nginx/error.log

USER nginx

EXPOSE 8080/tcp

STOPSIGNAL SIGQUIT

CMD ["nginx", "-g", "daemon off;"]