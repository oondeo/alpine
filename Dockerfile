FROM alpine:latest

#Use dash instead busybox
#edge repository breaks installs
#RUN echo "@edge http://dl-cdn.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories && \
ENV TINI_VERSION="20171019"
RUN echo "@testing http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories && \
    echo "@community http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories && \
    apk add --no-cache tini && \
    apk add --no-cache dash@testing \
    && apk add --no-cache bash \
    && rm /bin/sh && ln /usr/bin/dash /bin/sh && ln  /usr/bin/dash /bin/dash \
    && ln /bin/bash /usr/bin/bash && mkdir -p /app /etc/skel

ADD scripts/* /usr/local/bin/

RUN chmod +x /usr/local/bin/*

VOLUME /etc/skel

WORKDIR /app

ENTRYPOINT [ "/sbin/tini", "-g" ,"--", "/usr/local/bin/start.sh" ]

CMD [ "/sh" ] 

