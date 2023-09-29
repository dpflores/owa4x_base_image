FROM nodered/node-red

COPY settings.js /data/settings.js



## For run owasys programs
RUN dpkg-divert --local --rename --add /sbin/initctl
RUN ln -sf /bin/true /sbin/initctl
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update
RUN apt-get -y upgrade
# install 32 bit libraries required for gnuarm tools from
# https://launchpad.net/gcc-arm-embedded & a few minimalistic tools with ssh
server
RUN dpkg --add-architecture i386 && \
apt-get update && \
apt-get -y install \
libc6:i386 libncurses5:i386 libstdc++6:i386 libpython2.7:i386 vim \
make git unzip \
sudo curl less tree openssh-server
# clean cache
RUN apt-get clean
