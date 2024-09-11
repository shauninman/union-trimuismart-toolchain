#!/bin/sh

set -xe

sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen
locale-gen

cd ~

BUILDROOT_VERSION=buildroot-2016.05
wget https://buildroot.org/downloads/$BUILDROOT_VERSION.tar.gz
tar -xf ./$BUILDROOT_VERSION.tar.gz
rm -f ./$BUILDROOT_VERSION.tar.gz
mv ./$BUILDROOT_VERSION ./buildroot

cd ./buildroot
patch -p1 < ../libpng12.patch
patch -p1 < ../sdl_mixer.patch
cp ~/trimuismart.config ./.config

if [ -f ~/trimuismart-toolchain.tar.xz ]; then
 	tar -xf ~/trimuismart-toolchain.tar.xz -C /opt
else
	export FORCE_UNSAFE_CONFIGURE=1
	make oldconfig
	make world

	mkdir -p /opt/trimuismart-toolchain
	cp -rf output/host/usr/ /opt/trimuismart-toolchain/
	# this version of buildroot doesn't have relocate-sdk.sh yet so we bring our own
	cp ~/relocate-sdk.sh /opt/trimuismart-toolchain/
	cp ~/sdk-location /opt/trimuismart-toolchain/
	/opt/trimuismart-toolchain/relocate-sdk.sh
	cp ~/hwcap.h /opt/trimuismart-toolchain/usr/arm-buildroot-linux-gnueabihf/sysroot/usr/include/asm/
fi
