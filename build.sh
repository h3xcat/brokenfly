#!/bin/bash
mkdir -p "$(pwd)/build"
VERSION=$(cat VERSION)
GIT_VERSION=$(git describe --always --dirty)
echo "Building version $VERSION-$GIT_VERSION"
sleep 2
rm -rf build/*
docker build -f "$(pwd)/build-tools/Dockerfile" -t brokenfly-build .
docker run --rm  -v "$(pwd)/build:/build-artifacts" brokenfly-build seeed_xiao_rp2040 $VERSION $GIT_VERSION
docker run --rm  -v "$(pwd)/build:/build-artifacts" brokenfly-build waveshare_rp2040_zero $VERSION $GIT_VERSION
docker run --rm  -v "$(pwd)/build:/build-artifacts" brokenfly-build waveshare_rp2040_one $VERSION $GIT_VERSION
docker run --rm  -v "$(pwd)/build:/build-artifacts" brokenfly-build adafruit_itsybitsy_rp2040 $VERSION $GIT_VERSION
docker run --rm  -v "$(pwd)/build:/build-artifacts" brokenfly-build hal9000 $VERSION $GIT_VERSION
