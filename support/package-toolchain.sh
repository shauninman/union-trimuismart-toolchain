#!/bin/sh

cd /opt/
tar --xz -cvf trimuismart-toolchain.tar.xz trimuismart-toolchain/
mv trimuismart-toolchain.tar.xz ~/workspace/

echo "trimuismart-toolchain.tar.xz can be shared as a blob by placing in support before calling 'make shell'"