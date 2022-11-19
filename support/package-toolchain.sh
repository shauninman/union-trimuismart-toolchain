#!/bin/sh

cd /opt/
tar --xz -cvf trimuismart-toolchain.tar.xz trimuismart-toolchain/
mv trimuismart-toolchain.tar.xz ~/workspace/

echo "copy trimuismart-toolchain.tar.xz in the support folder on the host machine to reduce subsequent calls to 'make shell' or to share as a blob"