FROM oraclelinux:8

RUN dnf install -y java-1.8.0-openjdk-devel python39 "python39-pip" \
      curl tar gzip procps-ng hostname \
    && dnf clean all \
    && ln -s "$(dirname "$(dirname "$(readlink -f /usr/bin/javac)")")" "/opt/java8" \
    && curl -fL --retry 3 \
      "https://archive.apache.org/dist/spark/spark-3.5.0/spark-3.5.0-bin-hadoop3.tgz" \
      -o /tmp/spark.tgz \
    && mkdir -p "/opt/spark" \
    && tar -xzf /tmp/spark.tgz -C "/opt/spark" --strip-components=1 \
    && mkdir -p "/opt/hadoop/etc/hadoop" \
    && rm /tmp/spark.tgz

ENV JAVA_HOME=/opt/java8 \
    SPARK_HOME=/opt/spark \
    HADOOP_CONF_DIR=/opt/hadoop/etc/hadoop \
    PYSPARK_PYTHON=/usr/bin/python3.9 \
    PYSPARK_DRIVER_PYTHON=/usr/bin/python3.9
ENV PATH="/opt/spark/bin:${PATH}"

COPY config/hadoop/hadoop.xml ${HADOOP_CONF_DIR}/core-site.xml
WORKDIR /vagrant/TpBigData
