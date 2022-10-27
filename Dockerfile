FROM solr:8

USER root

RUN echo 'root:Docker!' | chpasswd

RUN /opt/solr/bin/solr stop -all

ADD start.sh /usr/local/bin/start

# Copy local_data volumes into data directory
# Set new files with correct user:group
ADD cores /var/solr/local_data
RUN mkdir -p /var/solr/data \
    && cp -R /var/solr/local_data/* /var/solr/data \
    && chown -R solr:solr /var/solr/data \
    && chown -R solr:solr /opt/docker-solr \
    && chmod 777 /usr/local/bin/start

RUN echo 'solr:Docker!' | chpasswd \
    && usermod -a -G sudo solr \
    && echo 'solr    ALL=(ALL:ALL) ALL' >> /etc/sudoers

USER solr

CMD ["/usr/local/bin/start"]