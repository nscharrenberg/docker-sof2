# ----------------------------------
# Pterodactyl Core Dockerfile
# Environment: SOF2
# Minimum Panel Version: 0.6.0
# ----------------------------------
FROM		debian:10.4
LABEL		author="Noah Scharrenberg" maintainer="nscharrenberg@hotmail.com"

ENV		DEBIAN_FRONTEND noninteractive
RUN		dpkg --add-architecture i386 \ 
		&& apt-get update \
		&& apt-get install -y tar curl \
		&& curl https://files.houseofpainserver.com/games/sof2/dependencies/libcxa.so.1 --output libcxa.so.1 \
		&& mv libcxa.so.1 /lib/libcxa.so.1 \
		&& useradd -m -d /home/container container

USER		container
ENV		HOME /home/container
WORKDIR		/home/container
