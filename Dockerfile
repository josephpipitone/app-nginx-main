FROM nginxinc/nginx-unprivileged:stable-alpine

USER root

ARG DOCROOT=/usr/share/nginx/html

COPY --chown=nobody:nobody www ${DOCROOT}

RUN find ${DOCROOT} -type d -print0 | xargs -0 chmod 755 && \
    find ${DOCROOT} -type f -print0 | xargs -0 chmod 644 && \
    chmod 755 ${DOCROOT}

USER nginx

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]