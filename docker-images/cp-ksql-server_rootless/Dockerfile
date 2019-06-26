FROM confluentinc/cp-ksql-server:5.2.1

USER root
RUN groupadd -g 1000 -o kafka && \
    useradd -m -u 1000 -g 1000 -o -s /bin/bash kafka && \
    chown -R 1000:1000 /etc/${COMPONENT}

