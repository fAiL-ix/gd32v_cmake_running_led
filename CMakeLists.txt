cmake_minimum_required(VERSION 3.19)

#### Project gd32v_startup definitions start ####
project(gd32v_startup VERSION 0.1.0 LANGUAGES ASM C)

add_executable(
    gd32v_startup.elf
    "${CMAKE_CURRENT_SOURCE_DIR}/src/gd32vf103xb_boot.S"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/main.c"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/device_headers/n200_func.c"
    )

target_include_directories(
    gd32v_startup.elf
    PRIVATE 
        "${CMAKE_CURRENT_SOURCE_DIR}/src/device_headers"
    )
##### Project gd32v_startup definitions end ####