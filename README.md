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