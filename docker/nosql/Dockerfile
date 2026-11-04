FROM ghcr.io/oracle/nosql:latest-ce

USER root
RUN mkdir -p /opt/oracle \
    && ln -s /app/kv-* /opt/oracle/kv

ENV KVHOME=/opt/oracle/kv \
    KVROOT=/kvroot \
    MYTPHOME=/vagrant/TpBigData
