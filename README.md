# Example STM32 Project with CMake
This repository uses NUCLEO-STM32L452RE-P board.

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
- MCU definition, in [`CMakeLists.txt:47`](CMakeLists.txt#L47).
- HAL related directory, in [`CMakeLists.txt:26-29`](CMakeLists.txt#L26-L29).
- CMSIS related directory, in [`CMakeLists.txt:19-21`](CMakeLists.txt#L19-L21).
- Startup file, in [`CMakeLists.txt:23`](CMakeLists.txt#L23).
- Linker script, in [`CMakeLists.txt:16`](CMakeLists.txt#L16).
- ARM FPU math library linkage, in [`CMakeLists.txt:51`](CMakeLists.txt#L51).
- MCU specific compiler flags, in [`cmake/arm-gcc-flags.cmake:3-6`](cmake/arm-gcc-flags.cmake:L3-L6).