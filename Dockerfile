FROM ubuntu:16.04 


# 替换国内aliyun源 

RUN sudo mv /etc/apt/sources.list /etc/apt/sources.list.bak \ 
	&& cat > /etc/apt/sources.list << END \
			deb http://mirrors.aliyun.com/ubuntu/ trusty main restricted universe multiverse \
			deb http://mirrors.aliyun.com/ubuntu/ trusty-security main restricted universe multiverse \
			deb http://mirrors.aliyun.com/ubuntu/ trusty-updates main restricted universe multiverse \
			deb http://mirrors.aliyun.com/ubuntu/ trusty-proposed main restricted universe multiverse \
			deb http://mirrors.aliyun.com/ubuntu/ trusty-backports main restricted universe multiverse \
			deb-src http://mirrors.aliyun.com/ubuntu/ trusty main restricted universe multiverse \
			deb-src http://mirrors.aliyun.com/ubuntu/ trusty-security main restricted universe multiverse \
			deb-src http://mirrors.aliyun.com/ubuntu/ trusty-updates main restricted universe multiverse \
			deb-src http://mirrors.aliyun.com/ubuntu/ trusty-proposed main restricted universe multiverse \
			deb-src http://mirrors.aliyun.com/ubuntu/ trusty-backports main restricted universe multiverse \
		END \
	&& sudo apt-get update \ 
	# 安装ppa 
	&& sudo apt-get install -y python-software-properties software-properties-common \
	&& add-apt-repository ppa:ondrej/php \
	&& sudo apt-get update 
