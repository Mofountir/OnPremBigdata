FROM r-base:4.2.2

RUN apt-get update \
    && apt-get install -y --no-install-recommends ca-certificates curl default-jdk-headless \
    && R CMD javareconf \
    && R -e 'install.packages(c("DBI", "rJava", "RJDBC"), repos="https://cloud.r-project.org")' \
    && mkdir -p /opt/hive-jdbc \
    && curl -fL --retry 3 \
      "https://archive.apache.org/dist/hive/hive-3.1.3/apache-hive-3.1.3-bin.tar.gz" \
      -o /tmp/hive.tar.gz \
    && tar -xzf /tmp/hive.tar.gz -C /opt/hive-jdbc --strip-components=2 \
      apache-hive-3.1.3-bin/jdbc/hive-jdbc-3.1.3-standalone.jar \
    && rm -rf /tmp/hive.tar.gz /var/lib/apt/lists/*

WORKDIR /vagrant/TpBigData
