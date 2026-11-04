# Conserver R 4.2.2 sur Ubuntu LTS plutôt que les dépôts Debian testing/sid.
FROM rocker/r-ver:4.2.2

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
      ca-certificates curl default-jdk-headless \
      libpcre2-dev liblzma-dev libbz2-dev zlib1g-dev libicu-dev \
    && R CMD javareconf \
    && rm -rf /var/lib/apt/lists/*

RUN R -e 'install.packages(c("DBI", "rJava", "RJDBC"), repos="https://cloud.r-project.org")' \
    && R -e 'library(DBI); library(rJava); library(RJDBC)'

RUN mkdir -p /opt/hive-jdbc \
    && curl -fL --retry 3 \
      "https://repo.huaweicloud.com/apache/hive/hive-3.1.3/apache-hive-3.1.3-bin.tar.gz" \
      -o /tmp/hive.tar.gz \
    && tar -xzf /tmp/hive.tar.gz -C /opt/hive-jdbc --strip-components=2 \
      apache-hive-3.1.3-bin/jdbc/hive-jdbc-3.1.3-standalone.jar \
    && rm /tmp/hive.tar.gz

WORKDIR /vagrant/TpBigData
