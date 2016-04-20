FROM alpine:latest

ADD scripts/* /usr/local/bin/

#Use dash instead busybox
RUN echo "@testing http://nl.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories && \
    apk-install dash@testing && rm /bin/sh ; ln -s /bin/dash /bin/sh; mkdir -p /app /etc/skel

ADD localtime /etc/localtime

VOLUME /etc/skel

WORKDIR /app

CMD [ "start.sh" ] 

