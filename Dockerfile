
FROM debian:jessie

MAINTAINER Silvio Fricke <silvio.fricke@gmail.com>

ENV LANG C.UTF-8

RUN export DEBIAN_FRONTEND=noninteractive \
    && dpkg --add-architecture i386 \
    && apt-get update -y \
    && apt-get install -y --no-install-recommends \
	automake \
	bc \
	bison \
	bsdmainutils \
	build-essential \
	bzip2 \
	chrpath \
	ccache \
	curl \
	default-jdk \
	dpkg-dev \
	elinks \
	gawk \
	diffstat \
	gcc-multilib \
	g++-multilib \
	gettext \
	git-core \
	gperf \
	less \
	libbz2-1.0 \
	libbz2-dev \
	libghc-bzlib-dev \
	liblz4-tool \
	libxml2-utils \
	libsdl1.2-dev \
	lzop \
	openssh-server \
	optipng \
	pngcrush \
	pv \
	python \
	python-networkx \
	schedtool \
	socat \
	sudo \
	texinfo \
	tmux \
	u-boot-tools \
	unzip \
	vim \
	wget \
	xterm \
	zip \
	zlib1g-dev \
	zlib1g-dev:i386 \
	\
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*

ADD https://storage.googleapis.com/git-repo-downloads/repo /usr/bin/repo
ADD https://github.com/turicas/sbc/tarball/develop /sbc.tar.gz
ADD adds/start.sh /start.sh
RUN tar -xvf /sbc.tar.gz ;\
    mv turicas-sbc-*/sbc /usr/bin ;\
    rm -rf turicas-sbc-* sbc.tar.gz ;\
    ln -sf /bin/bash /bin/sh ;\
    chmod a+rx /usr/bin/repo /start.sh /usr/bin/sbc

RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config
EXPOSE 22
CMD ["/start.sh"]
