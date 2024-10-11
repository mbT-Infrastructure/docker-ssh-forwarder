FROM madebytimo/base

RUN apt update -qq && apt install -y -qq ssh \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /etc/ssh/*

COPY files/run.sh /usr/local/bin/

ENV SERVER_KEY=""
ENV SERVER_URL=""
ENV SERVER_IDENTITY=""
ENV FORWARD_DIRECTION=""
ENV SOURCE_ADDRESS=""
ENV TARGET_ADDRESS=""

USER user
CMD [ "run.sh" ]

LABEL org.opencontainers.image.licenses="MIT"
LABEL org.opencontainers.image.source="https://github.com/madebytimo/docker-ssh-forwarder"
