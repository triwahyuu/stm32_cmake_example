#!/usr/bin/env sh

## Modified from https://github.com/vpetrigo/arm-cmake-toolchains/blob/master/ci/script.sh

set -ex

PROJECT_ROOT="`pwd`"

## Download ARM GCC toolchain from the official site
# case "${TRAVIS_OS_NAME}" in
#     linux)
#         ARM_GCC_URI="https://developer.arm.com/-/media/Files/downloads/gnu-rm/8-2018q4/gcc-arm-none-eabi-8-2018-q4-major-linux.tar.bz2"
#         ;;
#     osx)
#         ARM_GCC_URI="https://developer.arm.com/-/media/Files/downloads/gnu-rm/8-2018q4/gcc-arm-none-eabi-8-2018-q4-major-mac.tar.bz2"
#         ;;
#     *)
#         >&2 echo "Unknown OS"
#         exit 1
#         ;;
# esac

# curl -k -L ${ARM_GCC_URI} -o gcc-arm-none-eabi.tar.bz2
# tar jxf gcc-arm-none-eabi.tar.bz2
# find . -maxdepth 1 -type d -path "*gcc*" -not -path . -exec mv {} gcc-arm-none-eabi \;
# export PATH=${PROJECT_ROOT}/gcc-arm-none-eabi/bin:$PATH

arm-none-eabi-gcc --version

## trying to update cmake
# cmake --version
# curl -k -L https://github.com/Kitware/CMake/releases/download/v3.15.3/cmake-3.15.3-Linux-x86_64.sh -o cmake-3.15.3-Linux-x86_64.sh
# chmod +x cmake-3.15.3-Linux-x86_64.sh
# sh cmake-3.15.3-Linux-x86_64.sh
# export PATH=${PROJECT_ROOT}/cmake-3.15.3-Linux-x86_64/bin:$PATH
# cmake --version

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