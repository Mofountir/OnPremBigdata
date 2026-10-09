FROM oraclelinux:8

RUN dnf install -y java-1.8.0-openjdk-devel curl tar gzip procps-ng hostname \
    && dnf clean all \
    && ln -s "$(dirname "$(dirname "$(readlink -f /usr/bin/javac)")")" "/opt/java8" \
    && curl -fL --retry 3 \
      "https://archive.apache.org/dist/hadoop/common/hadoop-3.3.6/hadoop-3.3.6.tar.gz" \
      -o /tmp/hadoop.tar.gz \
    && mkdir -p "/opt/hadoop" \
    && tar -xzf /tmp/hadoop.tar.gz -C "/opt/hadoop" --strip-components=1 \
    && rm /tmp/hadoop.tar.gz

ENV JAVA_HOME=/opt/java8 \
    HADOOP_HOME=/opt/hadoop \
    HADOOP_COMMON_HOME=/opt/hadoop \
    HADOOP_HDFS_HOME=/opt/hadoop \
    HADOOP_YARN_HOME=/opt/hadoop \
    HADOOP_MAPRED_HOME=/opt/hadoop \
    HADOOP_CONF_DIR=/opt/hadoop/etc/hadoop
ENV PATH="/opt/hadoop/bin:/opt/hadoop/sbin:${PATH}"

COPY config/hadoop/hadoop.xml ${HADOOP_CONF_DIR}/tp-site.xml
RUN for config in core hdfs yarn mapred; do \
      ln -sf tp-site.xml "${HADOOP_CONF_DIR}/$config-site.xml"; \
    done

WORKDIR /vagrant/TpBigData
