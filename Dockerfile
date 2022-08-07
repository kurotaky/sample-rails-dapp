FROM --platform=linux/amd64 ruby:3.1.2
ARG SOLC_VERSION=v0.8.15

RUN apt-get update -qq && apt-get install -y build-essential wget
RUN wget --quiet --output-document /usr/local/bin/solc https://github.com/ethereum/solidity/releases/download/${SOLC_VERSION}/solc-static-linux \
    && chmod a+x /usr/local/bin/solc

RUN mkdir /myapp
WORKDIR /myapp
ADD Gemfile /myapp/Gemfile
ADD Gemfile.lock /myapp/Gemfile.lock
RUN bundle install
ADD . /myapp
