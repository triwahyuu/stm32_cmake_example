[![Build Status](https://travis-ci.com/triwahyuu/stm32_cmake_example.svg?branch=master)](https://travis-ci.com/triwahyuu/stm32_cmake_example)

# Example STM32 Project with CMake
This repository uses NUCLEO-STM32L452RE-P board.  
The [CMake toolchain file](cmake/arm-gcc-toolchain.cmake) is obtained from [`vpetrigo/arm-cmake-toolchains`](https://github.com/vpetrigo/arm-cmake-toolchains).  
This repository is generated with STM32CubeMX, so you can regenerate the project if you want with `cmake_test.ioc` file.

## BUILD
To build the project don't forget to specify the toolchain in the cmake:
```
mkdir -p build/ && cd build
cmake .. -DCMAKE_TOOLCHAIN_FILE=../cmake/arm-gcc-toolchain.cmake
```

The ARM math library ([`libarm_cortexM4lf_math.a`](aux/libarm_cortexM4lf_math.a)) file is obtained from [ARM CMSIS repository](https://github.com/ARM-software/CMSIS/tree/master/CMSIS/Lib/GCC).  
The [`STM32L4x2.svd`](aux/STM32L4x2.svd) file is used for debugging, and is obtained from [KEIL device pack](https://www.keil.com/dd2/pack/) inside `CMSIS/SVD` directory. Or get it from [posborne/cmsis-svd](https://github.com/posborne/cmsis-svd/tree/master/data/STMicro).

## NOTES
This repository doesn't mean to be modular, if you want to use it for another board or project you need to customize the [`CMakeLists.txt`](CMakeLists.txt) file.  

If you want to customize this repository for another project, there are several things that needs to be changed:
- MCU device definition, in [`CMakeLists.txt:11`](CMakeLists.txt#L11).
- MCU specific compiler flags, in [`cmake/arm-gcc-flags.cmake:3-6`](cmake/arm-gcc-flags.cmake#L3-L6). If your MCU supports hardware fpu, you can set the `FLOAT_ABI` variable to `-mfloat-abi=hard`, otherwise set it to `-mfloat-abi=softfp`.
- Linker script, in [`CMakeLists.txt:16`](CMakeLists.txt#L16).
- ARM FPU math library linkage, in [`CMakeLists.txt:17`](CMakeLists.txt#L17). Required if you set the `FLOAT_ABI` variable to `-mfloat-abi=hard`. 


Also there are several config that is infered from MCU device definition, but not yet tested thoroughly:
- Startup file, in [`CMakeLists.txt:18`](CMakeLists.txt#L18).
- HAL related directory, in [`CMakeLists.txt:27-28`](CMakeLists.txt#L27-L28).
- CMSIS related directory, in [`CMakeLists.txt:21-23`](CMakeLists.txt#L21-L23).