FROM oraclelinux:8

RUN dnf install -y java-1.8.0-openjdk-devel python39 "python39-pip" \
    && dnf clean all \
    && ln -s "$(dirname "$(dirname "$(readlink -f /usr/bin/javac)")")" "/opt/java8" \
    && ln -s "/usr/bin/python3.9" /usr/local/bin/python3 \
    && ln -s "/usr/bin/python3.9" /usr/local/bin/python

ENV JAVA_HOME=/opt/java8 PYTHON_BIN=/usr/bin/python3.9
WORKDIR /workspace
