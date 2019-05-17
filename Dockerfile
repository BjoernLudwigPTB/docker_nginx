FROM nginx

COPY app.conf /etc/nginx/conf.d/app.conf

COPY docker-entrypoint.sh /docker-entrypoint.sh

ENTRYPOINT ["sh", "/docker-entrypoint.sh"]
