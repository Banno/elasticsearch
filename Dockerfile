#
# ElasticSearch Dockerfile
#
# https://github.com/dockerfile/elasticsearch
#

# Pull base image.
FROM registry.banno-internal.com/java

ENV ELASTICSEARCH_VERSION 1.4.2

# Install ElasticSearch.
RUN \
  cd /tmp && \
  wget --no-check-certificate https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-$ELASTICSEARCH_VERSION.tar.gz && \
  tar xvzf elasticsearch-$ELASTICSEARCH_VERSION.tar.gz && \
  rm -f elasticsearch-$ELASTICSEARCH_VERSION.tar.gz && \
  mv /tmp/elasticsearch-$ELASTICSEARCH_VERSION /elasticsearch

# Define mountable directories.
VOLUME ["/data"]

# Mount elasticsearch.yml config
ADD config/elasticsearch.yml /elasticsearch/config/elasticsearch.yml

# Define working directory.
WORKDIR /data

# Define default command.
CMD ["/elasticsearch/bin/elasticsearch"]

# Expose ports.
#   - 9200: HTTP
#   - 9300: transport
EXPOSE 9200
EXPOSE 9300
