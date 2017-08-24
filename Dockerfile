FROM ubuntu:16.04 


# 替换国内aliyun源 

COPY ./sources.list /etc/apt/sources.list
RUN sudo apt-get update \ 
	# 安装ppa 
	&& sudo apt-get install -y python-software-properties software-properties-common \
	&& add-apt-repository ppa:ondrej/php \
	&& sudo apt-get update 
