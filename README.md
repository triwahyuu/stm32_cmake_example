[![Build Status](https://travis-ci.com/triwahyuu/stm32_cmake_example.svg?branch=master)](https://travis-ci.com/triwahyuu/stm32_cmake_example)

# Example STM32 Project with CMake
This repository uses NUCLEO-STM32L452RE-P board. The CMake toolchain file is obtained from [`vpetrigo/arm-cmake-toolchains`](https://github.com/vpetrigo/arm-cmake-toolchains)

## BUILD
To build the project don't forget to specify the toolchain in the cmake:
```
mkdir -p build/ && cd build
cmake .. -DCMAKE_TOOLCHAIN_FILE=../cmake/arm-gcc-toolchain.cmake
```

The `libarm_cortexM4lf_math.a` file is obtained from the STM32Cube repository inside `Drivers/CMSIS/Lib/GCC` directory.  
The `STM32L4x2.svd` file is used for debugging, and is obtained from KEIL repository inside `CMSIS/SVD` directory.

## NOTES
This repository doesn't mean to be modular, if you want to use it for another board or project you need to customize the [`CMakeLists.txt`](CMakeLists.txt) file.  

If you want to customize this repository for another project, there are several things that needs to be changed:
- MCU definition, in [`CMakeLists.txt:45`](CMakeLists.txt#L45).
- HAL related directory, in [`CMakeLists.txt:25-28`](CMakeLists.txt#L25-L28).
- CMSIS related directory, in [`CMakeLists.txt:18-20`](CMakeLists.txt#L18-L20).
- Startup file, in [`CMakeLists.txt:22`](CMakeLists.txt#L22).
- Linker script, in [`CMakeLists.txt:15`](CMakeLists.txt#L15).
- ARM FPU math library linkage, in [`CMakeLists.txt:49`](CMakeLists.txt#L49).
- MCU specific compiler flags, in [`cmake/arm-gcc-flags.cmake:3-6`](cmake/arm-gcc-flags.cmake#L3-L6).