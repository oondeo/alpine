FROM alpine:latest

ADD scripts/* /usr/local/bin/

#Use dash instead busybox
RUN echo "@edge http://dl-cdn.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories && \
    echo "@testing http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories && \
    echo "@community http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories && \
    apk-install tini && \
    apk-install dash@testing && cp /usr/bin/dash /bin/sh && mkdir -p /app /etc/skel

ADD localtime /etc/localtime

VOLUME /etc/skel

WORKDIR /app

ENTRYPOINT ["/sbin/tini","-g","--"]

CMD [ "start.sh" ] 

