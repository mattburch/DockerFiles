FROM ev3dev/debian-stretch-cross
RUN sudo apt-get update && \
    DEBIAN_FRONTEND=noninteractive sudo apt-get install --yes --no-install-recommends \
        git \
        curl \
        libusb-dev:armhf \
        libreadline-dev:armhf \
        ncurses-dev:armhf \
        libstdc++:armhf \
        libreadline7:armhf

# Link Compilers
RUN sudo ln -s arm-linux-gnueabihf-gcc /usr/bin/gcc && \
    sudo ln -s arm-linux-gnueabihf-g++ /usr/bin/g++

ENV PKG_CONFIG_PATH=/usr/lib/arm-linux-gnueabihf/pkgconfig
ENV DEVKITPRO=/home/compiler/proxmark3
ENV DEVKITARM=$DEVKITPRO/gcc-arm-none-eabi-8-2018-q4-major
ENV PATH=${PATH}:${DEVKITARM}/bin

RUN mkdir proxmark3

# Pull latest Proxmark3 release
RUN wget -t 10 https://github.com/Proxmark/proxmark3/archive/`\
  curl --silent "https://api.github.com/repos/Proxmark/proxmark3/releases/latest" |\
  grep '"tag_name":' |\
  sed -E 's/.*"([^"]+)".*/\1/'`.tar.gz -O - | \
tar zxfv - -C proxmark3 --strip 1

# Import iclass Keys
ADD iclass_decryptionkey.bin /home/compiler/proxmark3
ADD iclasskeys.bin /home/compiler/proxmark3

# Pull ARM Keychain
RUN wget -t 10 https://armkeil.blob.core.windows.net/developer/Files/downloads/gnu-rm/8-2018q4/gcc-arm-none-eabi-8-2018-q4-major-linux.tar.bz2 -O - |\
    tar xfvj - -C proxmark3

# Import build script and set correct permissions
ADD ./build.sh /home/compiler/build.sh
RUN sudo chmod 755 /home/compiler/build.sh

ENTRYPOINT ["/home/compiler/build.sh"]
