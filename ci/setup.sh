#!/usr/bin/env sh

set -ex

PROJECT_ROOT="`pwd`"

## install arm gcc toolchain
case "${TRAVIS_OS_NAME}" in
    linux)
        sudo apt-get install apt-transport-https ca-certificates gnupg software-properties-common wget
        wget -O - https://apt.kitware.com/keys/kitware-archive-latest.asc 2>/dev/null | sudo apt-key add -
        sudo apt-add-repository 'deb https://apt.kitware.com/ubuntu/ xenial main'
        sudo add-apt-repository ppa:team-gcc-arm-embedded/ppa
        sudo apt-get update
        sudo apt-get install -y gcc-arm-embedded
        sudo apt-get install -y ninja-build cmake
        ;;
    osx)
        rvm use 2.3 --install --binary
        brew tap ArmMbed/homebrew-formulae
        brew update
        brew install arm-none-eabi-gcc
        brew install ninja cmake
        ;;
    *)
        >&2 echo "Unknown OS"
        exit 1
        ;;
esac