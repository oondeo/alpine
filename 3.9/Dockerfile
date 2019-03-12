
FROM alpine:3.9

ARG ALPINE_VERSION=3.9

ENV SUMMARY="alpine base image"	\
    DESCRIPTION="Alpine base image. The image use scripts and configurations compatible \
        with redhat openshift."

LABEL summary="$SUMMARY" \
      description="$DESCRIPTION" \
      io.k8s.description="$DESCRIPTION" \
      io.k8s.display-name="alpine" \
      io.openshift.s2i.scripts-url=image:///usr/libexec/s2i/bin \
      io.s2i.scripts-url=image:///usr/libexec/s2i/bin \
      com.redhat.component="core" \
      name="oondeo/alpine" \
      version="3.9" \
      release="1" \
      maintainer="OONDEO <info@oondeo.es>"

ENV \
    # DEPRECATED: Use above LABEL instead, because this will be removed in future versions.
    STI_SCRIPTS_URL=image:///usr/libexec/s2i/bin \
    # Path to be used in other layers to place s2i scripts into
    STI_SCRIPTS_PATH=/usr/libexec/s2i/bin

ENV \
    # The $HOME is not set by default, but some applications needs this variable
    HOME=/opt/app-root/src \
    PATH=/opt/app-root/src/bin:/opt/app-root/bin:$STI_SCRIPTS_PATH:$PATH


# When bash is started non-interactively, to run a shell script, for example it
# looks for this variable and source the content of this file. This will enable
# the SCL for all scripts without need to do 'scl enable'.
ENV BASH_ENV=/opt/app-root/etc/scl_enable \
    ENV=/opt/app-root/etc/scl_enable \
    XDG_DATA_HOME=$HOME/.local/share \
    DEBIAN_FRONTEND=noninteractive \
    MUSL_LOCPATH="/usr/share/i18n/locales/musl" \
    LANG=es_ES.UTF-8 LANGUAGE=es_ES.UTF-8 LC_ALL=es_ES.UTF-8 LC_CTYPE=es_ES.UTF-8 \
    PROMPT_COMMAND=". /opt/app-root/etc/scl_enable"


#Use dash instead busybox
RUN apk add --no-cache tini dash bash rsync git openssh-client icu-libs tzdata curl inotify-tools \
    && ln /usr/bin/dash /bin/dash \
    && ln /bin/bash /usr/bin/bash 

#Install locale support
RUN cd /tmp && wget https://raw.githubusercontent.com/oondeo/docker-alpine/master/musl-locales-0.2-r0.apk \
    && apk add --allow-untrusted musl-locales-0.2-r0.apk && rm -f musl-locales-0.2-r0.apk

RUN mkdir -p /etc/skel /opt/app-root/src /opt/app-root/etc /opt/app-root/bin /opt/app-root/lib \
        /opt/app-root/var/log /opt/app-root/var/run /run /var/run

COPY /root/root/ /
RUN docker-footer
USER 1001

VOLUME /etc/skel /opt/app-root/src

# Directory with the sources is set as the working directory so all STI scripts
# can execute relative to this path.
WORKDIR ${HOME}

ENTRYPOINT [ "/sbin/tini", "-g" ,"--", "container-entrypoint" ]

CMD [ "/bin/bash" ] 

