 #=== step 1 === php7dev:latest #  

 FROM ubuntu:xenial
 MAINTAINER vardump@foxmail.com

# 替换国内aliyun源 

 COPY ./sources.list /etc/apt/sources.list

 ARG DEBIAN_FRONTEND=noninteractive
 RUN \
	apt-get -y update && apt-get -y upgrade && \
  	apt-get -o Dpkg::Options::=--force-confdef -y install supervisor locales curl netcat wget telnet vim gcc python3 python-software-properties software-properties-common nginx git openssl expect \
  	&& locale-gen en_US.UTF-8 \
  	&& export LANG=en_US.UTF-8 \
  	&& add-apt-repository ppa:ondrej/php -y  \
  	&& apt-get update \
  	&& apt-get install -y php7.1 php7.1-dev php7.1-fpm php7.1-cli php7.1-mysql php7.1-phpdbg php7.1-bcmath php7.1-bz2 php7.1-common php7.1-curl php7.1-gd \
  	php7.1-json php7.1-mbstring php7.1-mcrypt php7.1-xml php-pear 
# composer   	 
RUN mkdir /build 
WORKDIR /build 

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
	&& php -r "if (hash_file('SHA384', 'composer-setup.php') === '669656bab3166a7aff8a7506b8cb2d1c292f042046c5a994c43155c0be6190fa0355160742ab2e1c88d40d5be660b410') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" \
	&& php composer-setup.php  --filename=composer --install-dir=/usr/bin \
	&& php -r "unlink('composer-setup.php');" \
	&& chmod a+x /usr/bin/composer 
	&& composer config -g repo.packagist composer https://packagist.phpcomposer.com \
# laravel 安装脚手架
	&& composer global require "laravel/installer"

# nodejs 
RUN wget https://npm.taobao.org/mirrors/node/v8.4.0/node-v8.4.0-linux-x64.tar.xz \
	&& xz -d node-v8.4.0-linux-x64.tar.xz \
	&& tar -xvf node-v8.4.0-linux-x64.tar \ 
	&& mv ./node-v8.4.0-linux-x64 /usr/local/node \
	&& ln -s /usr/local/node/bin/node /usr/local/bin/node \
	&& ln -s /usr/local/node/bin/npm /usr/local/bin/npm \
# 国内镜像 
	&& npm install -g cnpm --registry=https://registry.npm.taobao.org
	&& rm -rf ./node-v8.4.0-linux-x64.tar
# mysql

RUN DEBIAN_FRONTEND=noninteractive apt-get -yq install mysql-server \
	
# start serivce 
    && /etc/init.d/mysql start \
    && /etc/init.d/nginx start 


EXPOSE 80
EXPOSE 3306