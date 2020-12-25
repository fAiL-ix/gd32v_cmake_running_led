# GD32V RISCV toolchain cmake
# This file is a modified version of the arm-gcc-toolchain.cmake by vpetrigo
# https://github.com/vpetrigo/arm-cmake-toolchains/blob/master/arm-gcc-toolchain.cmake

cmake_minimum_required(VERSION 3.19)

set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_SYSTEM_PROCESSOR riscv32)

set(TOOLCHAIN_PREFIX riscv32-elf-)


set(CMAKE_C_COMPILER ${TOOLCHAIN_PREFIX}gcc)
set(CMAKE_ASM_COMPILER ${TOOLCHAIN_PREFIX}as)
set(CMAKE_CXX_COMPILER ${TOOLCHAIN_PREFIX}g++)
set(CMAKE_LINKER ${TOOLCHAIN_PREFIX}ld)
set(CMAKE_OBJCOPY ${TOOLCHAIN_PREFIX}objcopy CACHE FILEPATH "objcopy tool" FORCE)
set(CMAKE_SIZE_UTIL ${TOOLCHAIN_PREFIX}size CACHE INTERNAL "size tool")

# set(CMAKE_C_LINK_EXECUTABLE "<CMAKE_LINKER> <FLAGS> <CMAKE_C_LINK_FLAGS> <LINK_FLAGS> <OBJECTS> -o <TARGET> <LINK_LIBRARIES>" CACHE STRING "" FORCE)

# Without that flag CMake is not able to pass test compilation check
set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)

# Search for programms in the build host directories
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM Never)
# For libraries and headers in the target directories
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)

# Default C compiler flags
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -march=rv32imac")
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -mabi=ilp32")
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -mcmodel=medlow")

# -mabi=ilp32 -mcmodel=medlow -msmall-data-limit=8 -fmessage-length=0 -fsigned-char -ffunction-sections -fno-common -fdata-sections -MMD -MP")
    

set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS}" CACHE STRING "CFLAGS")
set(CMAKE_ASM_FLAGS "${CMAKE_C_FLAGS}" CACHE STRING "ASM Flags")

# set(CMAKE_C_FLAGS_DEBUG_INIT "-Os -Og -g -Wall -pedantic -DDEBUG")
# set(CMAKE_C_FLAGS_DEBUG "${CMAKE_C_FLAGS_DEBUG_INIT}" CACHE STRING "" FORCE)
# set(CMAKE_C_FLAGS_RELEASE_INIT "-Os -Wall")
# set(CMAKE_C_FLAGS_RELEASE "${CMAKE_C_FLAGS_RELEASE_INIT}" CACHE STRING "" FORCE)
