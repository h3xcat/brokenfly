#!/usr/bin/env bash

# exit when any command fails
set -e

# Set PICO_SDK_PATH environment variable
export PICO_SDK_PATH=/workspace/pico-sdk
export PICO_BOARD=$1
export PICOFLY_VERSION=$2
export PICOFLY_GIT_VERSION=$3

# Build busk
cp $PICO_SDK_PATH/src/rp2_common/pico_standard_link/memmap_default.ld $PICO_SDK_PATH/src/rp2_common/pico_standard_link/memmap_default.ld.bak
sed -i 's/RAM(rwx) : ORIGIN =  0x20000000, LENGTH = 256k/RAM(rwx) : ORIGIN = 0x20038000, LENGTH = 32k/g' $PICO_SDK_PATH/src/rp2_common/pico_standard_link/memmap_default.ld
mkdir -p build/busk
cd build/busk
cmake /workspace/busk
make
make clean
cd /workspace
rm -f $PICO_SDK_PATH/src/rp2_common/pico_standard_link/memmap_default.ld
mv $PICO_SDK_PATH/src/rp2_common/pico_standard_link/memmap_default.ld.bak $PICO_SDK_PATH/src/rp2_common/pico_standard_link/memmap_default.ld

# Build usk
mkdir -p build/usk
cd build/usk
cmake /workspace/usk
make
make clean
python3 /workspace/usk/prepare.py
cd /workspace


mkdir -p /build-artifacts
zip /build-artifacts/BrokenFly-${PICOFLY_VERSION}-${PICO_BOARD}-${PICOFLY_GIT_VERSION}.zip /workspace/build/usk/firmware.uf2 /workspace/build/usk/update.bin
