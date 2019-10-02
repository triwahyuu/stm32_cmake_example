#!/usr/bin/env sh

## Modified from https://github.com/vpetrigo/arm-cmake-toolchains/blob/master/ci/script.sh

set -ex

PROJECT_ROOT="`pwd`"

arm-none-eabi-gcc --version

cmake --version

cd ${PROJECT_ROOT}

if [ ${USE_NINJA} = 1 ]; then
    mkdir -p build-gcc
    cd build-gcc
    cmake .. -G Ninja -DCMAKE_TOOLCHAIN_FILE=${PROJECT_ROOT}/cmake/arm-gcc-toolchain.cmake
else 
    mkdir -p build-gcc-make
    cd build-gcc-make
    cmake .. -DCMAKE_TOOLCHAIN_FILE=${PROJECT_ROOT}/cmake/arm-gcc-toolchain.cmake
fi

cmake --build . -- -j2