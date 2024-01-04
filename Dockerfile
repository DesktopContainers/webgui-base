FROM debian:bookworm

ENV PATH="/container/scripts:${PATH}"
ENV SHELL="/bin/bash"

RUN export DEBIAN_FRONTEND=noninteractive \
 && apt-get -q -y update \
 && apt-get -q -y install --no-install-recommends runit \
                       \
                       xvfb \
                       x11vnc \
                       novnc \
                       \
                       sudo \
                       \
 && apt-get -q -y install icewm \
 \
 && apt-get -q -y clean \
 && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


RUN adduser --disabled-password -q --gecos '' app \
 && passwd -d app \
 && ln -s /usr/share/novnc/vnc_lite.html /usr/share/novnc/index.html


EXPOSE 8080

COPY . /container/

HEALTHCHECK CMD ["docker-healthcheck.sh"]
ENTRYPOINT ["entrypoint.sh"]

CMD [ "runsvdir","-P", "/container/config/runit" ]

