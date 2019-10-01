set(CMAKE_C_FLAGS "-mthumb -fno-builtin -mcpu=cortex-m4 -mfpu=fpv4-sp-d16 -mfloat-abi=hard -Wall -ffunction-sections -fdata-sections -fomit-frame-pointer -mabi=aapcs -fno-unroll-loops -ffast-math -ftree-vectorize -fstack-usage --specs=nano.specs")
set(CMAKE_CXX_FLAGS "-mthumb -fno-builtin -mcpu=cortex-m4 -mfpu=fpv4-sp-d16 -mfloat-abi=hard -Wall -ffunction-sections -fdata-sections -fomit-frame-pointer -mabi=aapcs -fno-unroll-loops -ffast-math -ftree-vectorize -fno-threadsafe-statics -fno-use-cxa-atexit -fstack-usage --specs=nano.specs")
set(CMAKE_ASM_FLAGS "-mthumb -mcpu=cortex-m4 -mfpu=fpv4-sp-d16 -mfloat-abi=hard -x assembler-with-cpp --specs=nano.specs")

SET(CMAKE_EXE_LINKER_FLAGS "-Wl,--gc-sections -mthumb -mcpu=cortex-m4 -mfpu=fpv4-sp-d16 -mfloat-abi=hard -mabi=aapcs")

SET(CMAKE_C_FLAGS_DEBUG "-O0 -g")
SET(CMAKE_CXX_FLAGS_DEBUG "-O0 -g")
SET(CMAKE_ASM_FLAGS_DEBUG "-g")
SET(CMAKE_EXE_LINKER_FLAGS_DEBUG "")

SET(CMAKE_C_FLAGS_RELEASE "-Os -flto")
SET(CMAKE_CXX_FLAGS_RELEASE "-Os -flto")
SET(CMAKE_ASM_FLAGS_RELEASE "")
SET(CMAKE_EXE_LINKER_FLAGS_RELEASE "-flto")