FROM ruby:3.1.2

#RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 1C52189C923F6CA9
#RUN apt-get update -qq && apt-get install -y software-properties-common
#RUN add-apt-repository ppa:ethereum/ethereum
RUN apt-get update -qq && apt-get install -y build-essential git libboost-all-dev cmake
RUN git clone --depth 1 --recursive -b v0.8.15 https://github.com/ethereum/solidity && \
  cd /solidity && cmake -DCMAKE_BUILD_TYPE=Release -DTESTS=0 -DSTATIC_LINKING=1 && \
  cd /solidity && make solc && install -s solc/solc /usr/bin && cd / && rm -rf solidity

RUN mkdir /myapp
WORKDIR /myapp
ADD Gemfile /myapp/Gemfile
ADD Gemfile.lock /myapp/Gemfile.lock
RUN bundle install
ADD . /myapp
