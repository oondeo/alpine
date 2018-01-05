FROM alpine:3.7

#Use dash instead busybox
#edge repository breaks installs
#RUN echo "@edge http://dl-cdn.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories && \
ENV TINI_VERSION="20171019"
RUN echo "@testing http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories && \
    echo "@community http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories && \
    apk add --no-cache tini dash bash \
    && ln /usr/bin/dash /bin/dash \
    && ln /bin/bash /usr/bin/bash \
    && mkdir -p /etc/skel /opt/app-root/src /opt/app-root/etc /opt/app-root/bin /opt/app-root/lib /opt/app-root/var

COPY /root/root/ /

VOLUME /etc/skel

WORKDIR /opt/app-root/src

ENTRYPOINT [ "/sbin/tini", "-g" ,"--", "container-entrypoint" ]

CMD [ "/bin/bash" ] 

