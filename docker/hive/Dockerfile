FROM oraclelinux:8

RUN dnf install -y java-1.8.0-openjdk-devel curl tar gzip procps-ng hostname \
    && dnf clean all \
    && ln -s "$(dirname "$(dirname "$(readlink -f /usr/bin/javac)")")" "/opt/java8"

RUN curl -fL --retry 3 \
      "https://archive.apache.org/dist/hadoop/common/hadoop-3.3.6/hadoop-3.3.6.tar.gz" \
      -o /tmp/hadoop.tar.gz \
    && mkdir -p "/opt/hadoop" \
    && tar -xzf /tmp/hadoop.tar.gz -C "/opt/hadoop" --strip-components=1 \
    && rm /tmp/hadoop.tar.gz \
    && curl -fL --retry 3 \
      "https://archive.apache.org/dist/hive/hive-3.1.3/apache-hive-3.1.3-bin.tar.gz" \
      -o /tmp/hive.tar.gz \
    && mkdir -p "/opt/hive" \
    && tar -xzf /tmp/hive.tar.gz -C "/opt/hive" --strip-components=1 \
    && rm /tmp/hive.tar.gz

# Aligner Guava sur Hadoop pour cette combinaison Hadoop/Hive.
RUN rm "/opt/hive"/lib/guava-*.jar \
    && cp "/opt/hadoop"/share/hadoop/common/lib/guava-*.jar "/opt/hive/lib/" \
    && curl -fL --retry 3 \
      "https://repo.maven.apache.org/maven2/com/mysql/mysql-connector-j/8.0.33/mysql-connector-j-8.0.33.jar" \
      -o "/opt/hive/lib/mysql-connector-j.jar"

ENV JAVA_HOME=/opt/java8 \
    HADOOP_HOME=/opt/hadoop \
    HADOOP_COMMON_HOME=/opt/hadoop \
    HADOOP_HDFS_HOME=/opt/hadoop \
    HADOOP_YARN_HOME=/opt/hadoop \
    HADOOP_MAPRED_HOME=/opt/hadoop \
    HADOOP_CONF_DIR=/opt/hadoop/etc/hadoop \
    HIVE_HOME=/opt/hive \
    HIVE_CONF_DIR=/opt/hive/conf
ENV PATH="/opt/hive/bin:/opt/hadoop/bin:/opt/hadoop/sbin:${PATH}"

COPY config/hadoop/hadoop.xml ${HADOOP_CONF_DIR}/tp-site.xml
COPY config/hive/hive-site.xml ${HIVE_CONF_DIR}/hive-site.xml
RUN for config in core hdfs yarn mapred; do \
      ln -sf tp-site.xml "${HADOOP_CONF_DIR}/$config-site.xml"; \
    done

WORKDIR /vagrant/TpBigData
