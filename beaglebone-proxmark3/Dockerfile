FROM ev3dev/debian-stretch-cross
RUN sudo apt-get update && \
    DEBIAN_FRONTEND=noninteractive sudo apt-get install --yes --no-install-recommends \
        git \
        libusb-dev:armhf \
        libreadline-dev:armhf \
        ncurses-dev:armhf \
        libreadline7:armhf

# Link Compilers
RUN sudo ln -s arm-linux-gnueabihf-gcc /usr/bin/gcc && \
    sudo ln -s arm-linux-gnueabihf-g++ /usr/bin/g++

ENV PKG_CONFIG_PATH=/usr/lib/arm-linux-gnueabihf/pkgconfig

# Import build script and set correct permissions
ADD ./build.sh /home/compiler/build.sh
RUN sudo chmod 755 /home/compiler/build.sh

ENTRYPOINT ["/home/compiler/build.sh"]
