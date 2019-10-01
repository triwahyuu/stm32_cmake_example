cmake_minimum_required(VERSION 3.5)
project(cmake_example C CXX ASM)

set(TARGET ${PROJECT_NAME}.elf)
set(TARGET_BASE_NAME ${PROJECT_NAME})

## compile flags
include(${CMAKE_SOURCE_DIR}/cmake/arm-gcc-flags.cmake)

## enabling c++
set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} --specs=nosys.specs")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fno-exceptions -fno-rtti")

## linker scipt
set(LINKER_SCRIPT ${CMAKE_SOURCE_DIR}/aux/STM32L452RETxP_FLASH.ld)

## CMSIS
set(CMSIS_COMMON_INCLUDE_DIR "${CMAKE_SOURCE_DIR}/Drivers/CMSIS/Include")
set(CMSIS_DEVICE_INCLUDE_DIR "${CMAKE_SOURCE_DIR}/Drivers/CMSIS/Device/ST/STM32L4xx/Include")
set(CMSIS_INCLUDE_DIR ${CMSIS_COMMON_INCLUDE_DIR} ${CMSIS_DEVICE_INCLUDE_DIR})

set(CMSIS_STARTUP_SOURCE ${CMAKE_SOURCE_DIR}/aux/startup_stm32l452xx.s)

## HAL
set(HAL_INCLUDE_DIR 
    "${CMAKE_SOURCE_DIR}/Drivers/STM32L4xx_HAL_Driver/Inc" 
    "${CMAKE_SOURCE_DIR}/Drivers/STM32L4xx_HAL_Driver/Inc/Legacy"
)

## target executable
add_executable(${TARGET})

## adding sources
target_sources(${TARGET} PUBLIC ${CMSIS_STARTUP_SOURCE})
add_subdirectory(Src)
add_subdirectory(Drivers)

target_include_directories(${TARGET} PUBLIC 
    ${HAL_INCLUDE_DIR} 
    ${CMSIS_INCLUDE_DIR}
    "${CMAKE_SOURCE_DIR}/Inc"
)
target_compile_definitions(${TARGET} PUBLIC 
    "USE_HAL_DRIVER" 
    "STM32L452xx" 
)

target_link_libraries(${TARGET} PRIVATE ${CMAKE_SOURCE_DIR}/aux/libarm_cortexM4lf_math.a)
set_target_properties(${TARGET} PROPERTIES LINK_OPTIONS -T${LINKER_SCRIPT})
set_target_properties(${TARGET} PROPERTIES CXX_STANDARD 14)
set_target_properties(${TARGET} PROPERTIES C_STANDARD 11)

## custom target
add_custom_target(${TARGET_BASE_NAME}.hex 
    DEPENDS ${TARGET} 
    COMMAND ${CMAKE_OBJCOPY} -Oihex ${TARGET} ${TARGET_BASE_NAME}.hex
)
add_custom_target(${TARGET_BASE_NAME}.bin 
    DEPENDS ${TARGET} 
    COMMAND ${CMAKE_OBJCOPY} -Obinary ${TARGET} ${TARGET_BASE_NAME}.bin
)
add_custom_command(TARGET ${TARGET} POST_BUILD 
    COMMAND ${CMAKE_SIZE_UTIL} ${TARGET}
)

add_custom_target(flash
    DEPENDS ${TARGET} 
    COMMAND openocd 
        -f $ENV{OPENOCD_ROOT}/scripts/interface/stlink.cfg 
        -f $ENV{OPENOCD_ROOT}/scripts/target/stm32l4x.cfg 
        -c 'program ${CMAKE_SOURCE_DIR}/build/${TARGET} verify reset exit'
)