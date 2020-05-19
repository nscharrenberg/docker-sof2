# ----------------------------------
# Pterodactyl Core Dockerfile
# Environment: SOF2
# Minimum Panel Version: 0.6.0
# ----------------------------------
FROM		ubuntu:18.04
LABEL		author="Noah Scharrenberg" maintainer="nscharrenberg@hotmail.com"

ENV		DEBIAN_FRONTEND noninteractive
RUN		echo "# INSTALL DEPENDENCIES ##########################################" \
		&& dpkg --add-architecture i386 \ 
		&& apt-get update \
		&& apt-get upgrade -y \
		&& apt-get install -y curl \
		&& curl https://files.houseofpainserver.com/games/sof2/dependencies/libcxa.so.1 --output libcxa.so.1 \
		&& cp libcxa.so.1 /usr/lib/libcxa.so.1 \
		&& chmod 644 /usr/lib/libcxa.so.1 \
		&& cp libcxa.so.1 /lib/libcxa.so.1 \
		&& chmod 644 /lib/libcxa.so.1 \
		&& curl https://files.houseofpainserver.com/games/sof2/dependencies/fc4libs/ld-2.3.6.so --output ld-2.3.6.so \
		&& mv ld-2.3.6.so /lib/ld-2.3.6.so \
		&& curl https://files.houseofpainserver.com/games/sof2/dependencies/fc4libs/ld-linux.so.2 --output ld-linux.so.2 \
		&& mv ld-linux.so.2 /lib/ld-linux.so.2 \
		&& echo "# CREATE USER ################################################" \
		&& useradd -m -d /home/container container

USER		container
ENV		HOME /home/container
WORKDIR		/home/container

COPY        ./entrypoint.sh /entrypoint.sh
CMD         ["/bin/bash", "/entrypoint.sh"]
