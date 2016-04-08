FROM alpine:latest

ADD scripts/apk-install /usr/local/sbin/apk-install

#Use dash instead busybox
RUN echo "@testing http://nl.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories && \
    apk-install dash@testing && rm /bin/sh ; ln -s /bin/dash /bin/sh

