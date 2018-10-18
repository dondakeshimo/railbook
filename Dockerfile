FROM centos:centos7.2.1511

RUN rpm --rebuilddb; yum install -y yum-plugin-ovl
RUN yum install -y git gcc gcc-c++ glibc-headers openssl-devel libyaml-devel\
                   readline readline-devel zlib zlib-devel libffi-devel\
                   wget tar make sqlite sqlite-devel

WORKDIR /usr/local/src
RUN wget https://cache.ruby-lang.org/pub/ruby/2.4/ruby-2.4.0.tar.gz
RUN tar zxvf ruby-2.4.0.tar.gz
WORKDIR /usr/local/src/ruby-2.4.0
RUN ./configure
RUN make
RUN make install

WORKDIR /app

RUN gem update --system
RUN gem install bundler --force
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
RUN bundle install --path vendor/bundle

RUN curl -sL https://rpm.nodesource.com/setup_6.x | bash -
RUN yum install -y nodejs

COPY package.json /app/package.json
COPY package-lock.json /app/package-lock.json
RUN npm i

EXPOSE 3000
RUN yum install -y tree
RUN yum install -y which
# CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
