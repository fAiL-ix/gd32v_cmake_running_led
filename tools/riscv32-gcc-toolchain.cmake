# GD32V RISCV toolchain cmake file

cmake_minimum_required(VERSION 3.19)

set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_SYSTEM_PROCESSOR riscv32)

set(TOOLCHAIN_PREFIX riscv32-elf-)

set(CMAKE_C_COMPILER ${TOOLCHAIN_PREFIX}gcc)
set(CMAKE_ASM_COMPILER ${CMAKE_C_COMPILER})
set(CMAKE_LINKER ${CMAKE_C_COMPILER})
set(CMAKE_OBJCOPY ${TOOLCHAIN_PREFIX}objcopy)
set(CMAKE_SIZE_UTIL ${TOOLCHAIN_PREFIX}size)

# Custom link command, because the default is throwing errors
set(CMAKE_C_LINK_EXECUTABLE "<CMAKE_LINKER> <OBJECTS> <CMAKE_C_LINK_FLAGS>  -o <TARGET> <LINK_LIBRARIES>" CACHE STRING "" FORCE)

# Without that flag CMake is not able to pass test compilation check
set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)

# Search for programms in the build host directories
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM Never)
# For libraries and headers in the target directories
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)

# Default C compiler flags
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Wall")
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Os")
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -g")
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -fmessage-length=0")
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -march=rv32imac")
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -mabi=ilp32")
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -mcmodel=medlow")

set(CMAKE_ASM_FLAGS "${CMAKE_C_FLAGS} -x assembler-with-cpp")

set(CMAKE_C_LINK_FLAGS "-Wall")
set(CMAKE_C_LINK_FLAGS "${CMAKE_C_LINK_FLAGS} -Wl,--no-relax")
set(CMAKE_C_LINK_FLAGS "${CMAKE_C_LINK_FLAGS} -Wl,--gc-sections")
set(CMAKE_C_LINK_FLAGS "${CMAKE_C_LINK_FLAGS} -nostdlib")
set(CMAKE_C_LINK_FLAGS "${CMAKE_C_LINK_FLAGS} -nostartfiles")
set(CMAKE_C_LINK_FLAGS "${CMAKE_C_LINK_FLAGS} -lc")
set(CMAKE_C_LINK_FLAGS "${CMAKE_C_LINK_FLAGS} -lgcc")
set(CMAKE_C_LINK_FLAGS "${CMAKE_C_LINK_FLAGS} -march=rv32imac")
set(CMAKE_C_LINK_FLAGS "${CMAKE_C_LINK_FLAGS} -mabi=ilp32")
set(CMAKE_C_LINK_FLAGS "${CMAKE_C_LINK_FLAGS} -mcmodel=medlow")
set(CMAKE_C_LINK_FLAGS "${CMAKE_C_LINK_FLAGS} -T ../tools/gd32vf103xb.ld")

set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS}" CACHE STRING "CFLAGS")
set(CMAKE_ASM_FLAGS "${CMAKE_ASM_FLAGS}" CACHE STRING "ASM Flags")
set(CMAKE_C_LINK_FLAGS "${CMAKE_C_LINK_FLAGS}" CACHE STRING "Linker Flags")
