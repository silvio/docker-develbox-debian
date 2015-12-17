
FROM debian:jessie

MAINTAINER Silvio Fricke <silvio.fricke@gmail.com>

ENV LANG C.UTF-8
RUN ln -sf /usr/share/zoneinfo/Europe/Berlin /etc/localtime

RUN export DEBIAN_FRONTEND=noninteractive \
    && dpkg --add-architecture i386 \
    && apt-get update -y \
    && apt-get install -y --no-install-recommends \
	automake \
	bc \
	bison \
	build-essential \
	bzip2 \
	ccache \
	curl \
	default-jdk \
	dpkg-dev \
	g++-multilib \
	git-core \
	gperf \
	less \
	libbz2-1.0 \
	libbz2-dev \
	libghc-bzlib-dev \
	liblz4-tool \
	libxml2-utils \
	lzop \
	openssh-server \
	optipng \
	pngcrush \
	python \
	python-networkx \
	schedtool \
	sudo \
	tmux \
	u-boot-tools \
	unzip \
	vim \
	wget \
	zip \
	zlib1g-dev \
	zlib1g-dev:i386 \
	\
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*

ADD adds/start.sh /start.sh
ADD https://storage.googleapis.com/git-repo-downloads/repo /usr/bin/repo
ADD https://github.com/turicas/sbc/tarball/develop /sbc.tar.gz
RUN tar -xvf /sbc.tar.gz ;\
    mv turicas-sbc-*/sbc /usr/bin ;\
    rm -rf turicas-sbc-* sbc.tar.gz ;\
    ln -sf /bin/bash /bin/sh ;\
    chmod a+rx /usr/bin/repo /start.sh /usr/bin/sbc


RUN useradd -d /home/oe -U -G sudo -m -s /bin/bash -u 1000 oe ;\
    echo 'root:oe' | chpasswd ;\
    echo 'oe:oe' | chpasswd ;\
    echo "%sudo   ALL=(ALL:ALL) NOPASSWD: ALL" > /etc/sudoers.d/sudogrp

RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config
EXPOSE 22
CMD ["/start.sh"]
