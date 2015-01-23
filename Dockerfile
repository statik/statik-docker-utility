# DOCKER-VERSION 1.3
FROM debian:jessie
MAINTAINER Elliot Murphy "elliot.murphy@gmail.com"

ENV RUBY_VERSION 2.1.5
ENV DEBIAN_FRONTEND noninteractive
ENV PATH /home/app/.rbenv/shims:/home/app/.rbenv/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
RUN apt-get -yqq update;\
  apt-get install -yqq \
    sudo build-essential libssl-dev libcurl4-openssl-dev libreadline6-dev\
    curl git-core nodejs npm postgresql-client-9.4 libpq-dev\
    libmysqlclient-dev libxslt-dev libxml2-dev libaspell-dev libcrack2-dev\
    openjdk-7-jre vim-nox;\
    sudo ln -s /usr/bin/nodejs /usr/bin/node;\
    apt-get clean;\
    git clone https://github.com/patdeegan/rbenv.git /usr/local/rbenv;\
    echo 'export RBENV_ROOT=/usr/local/rbenv' >> /etc/profile.d/rbenv.sh;\
    echo 'export PATH="/usr/local/rbenv/bin:$PATH"' >> /etc/profile.d/rbenv.sh;\
    echo 'eval "$(rbenv init -)"' >> /etc/profile.d/rbenv.sh;\
    chmod +x /etc/profile.d/rbenv.sh
    source /etc/profile.d/rbenv.sh
    git clone https://github.com/patdeegan/ruby-build.git /usr/local/rbenv/plugins/ruby-build;\
    rbenv install $RUBY_VERSION && rbenv global $RUBY_VERSION;\
    gem install bundler --no-ri --no-rdoc;\
    gem install foreman --no-ri --no-rdoc;\
    rbenv rehash
USER app
WORKDIR /home/app
