FROM puppet/puppetserver:5.3.4
MAINTAINER "Gerard Hickey"

ENV FOREMAN_VERSION 1.16

RUN echo "deb http://deb.theforeman.org/ jessie $FOREMAN_VERSION" > /etc/apt/sources.list.d/foreman.list && \
    echo "deb http://deb.theforeman.org/ plugins $FOREMAN_VERSION" >> /etc/apt/sources.list.d/foreman.list && \
    apt-get -y update && apt-get -y upgrade  && \
    apt-get -y install libkrb5-dev krb5-user && \
    apt-get -y --allow-unauthenticated install foreman-proxy && \
    gem install bundler_ext rack sinatra concurrent-ruby && \
    mkdir -p /var/lib/puppet && chown puppet:puppet /var/lib/puppet

COPY foreman-enc.rb /usr/local/bin/
COPY foreman.rb /opt/puppetlabs/puppet/lib/ruby/vendor_ruby/puppet/reports/
COPY docker-entrypoint.sh /

EXPOSE 8000
EXPOSE 8443