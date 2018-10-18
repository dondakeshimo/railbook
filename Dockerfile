FROM centos:centos7.2.1511

RUN rpm --rebuilddb; yum install -y yum-plugin-ovl
RUN yum install -y git gcc gcc-c++ glibc-headers openssl-devel libyaml-devel\
                   readline readline-devel zlib zlib-devel libffi-devel\
                   wget tar make

WORKDIR /usr/local/src
RUN wget https://cache.ruby-lang.org/pub/ruby/2.4/ruby-2.4.0.tar.gz
RUN tar zxvf ruby-2.4.0.tar.gz
WORKDIR /usr/local/src/ruby-2.4.0
RUN ./configure
RUN make
RUN make install

RUN gem update --system
RUN gem install bundler --force
RUN gem install rails

RUN curl -sL https://rpm.nodesource.com/setup_6.x | bash -
RUN yum install -y nodejs

RUN yum install -y sqlite sqlite-devel
RUN gem install sqlite3

RUN adduser devuser
ENV HOME /home/devuser
WORKDIR /home/devuser
USER devuser
