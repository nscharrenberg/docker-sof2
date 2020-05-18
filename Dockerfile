# ----------------------------------
# Pterodactyl Core Dockerfile
# Environment: SOF2
# Minimum Panel Version: 0.6.0
# ----------------------------------
FROM		debian:10.4
LABEL		author="Noah Scharrenberg" maintainer="nscharrenberg@hotmail.com"

ENV		DEBIAN_FRONTEND noninteractive
RUN		echo "# INSTALL DEPENDENCIES ##########################################" \
		&& dpkg --add-architecture i386 \ 
		&& apt-get update \
		&& apt-get install -y tar curl \
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
		&& useradd -m -d /home/container container \
		&& echo "# INSTALL GAME ###############################################" \
		&& mkdir /tmp/build \
		&& cd /tmp/build \
		&& curl https://files.houseofpainserver.com/games/sof2/linux/gold.tar.gz --output /tmp/build/gold.tar.gz \
		&& tar -xvzf /tmp/build/gold.tar.gz /home/container/ \
		&& chmod 755 /home/container/sof2ded \
		&& chmod 755 /home/container/1fx \
		&& rm -rf /home/container/gold.tar.gz

USER		container
ENV		HOME /home/container
WORKDIR		/home/container

COPY        ./entrypoint.sh /entrypoint.sh
CMD         ["/bin/bash", "/entrypoint.sh"]
