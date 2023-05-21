# Start from the latest Ubuntu image
FROM ubuntu:latest

# Install dependencies
RUN apt-get update && apt-get install -y gcc-arm-none-eabi libnewlib-arm-none-eabi build-essential git cmake python3 zip

# Define working directory
WORKDIR /workspace

# Checkout raspberrypi/pico-sdk
RUN git clone --recursive https://github.com/raspberrypi/pico-sdk.git /workspace/pico-sdk

# Copy local files
COPY ./busk /workspace/busk
COPY ./usk /workspace/usk
COPY ./boards /workspace/boards

# Create symbolic links
RUN ln -s /workspace/pico-sdk/external/pico_sdk_import.cmake /workspace/busk/pico_sdk_import.cmake
RUN ln -s /workspace/pico-sdk/external/pico_sdk_import.cmake /workspace/usk/pico_sdk_import.cmake
RUN ln -s /workspace/usk/pins.h /workspace/busk/pins.h

# Create 'generated' directory in usk source directory
RUN mkdir -p /workspace/usk/generated

COPY build-tools/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]