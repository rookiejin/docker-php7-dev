 #=== step 1 === php7dev:latest #  

 FROM ubuntu:xenial
 MAINTAINER brian.wojtczak@1and1.co.uk

# 替换国内aliyun源 

 COPY ./sources.list /etc/apt/sources.list

 ARG DEBIAN_FRONTEND=noninteractive
 RUN \
	apt-get -y update && apt-get -y upgrade && \
  	apt-get -o Dpkg::Options::=--force-confdef -y install supervisor curl netcat wget telnet vim gcc python3 python-software-properties software-properties-common nginx git \
  	&& add-apt-repository -y ppa:ondrej/php \
  	&& apt-get update \
  	&& apt-get install php7.1-cli 
  	 
