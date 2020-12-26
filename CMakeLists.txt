cmake_minimum_required(VERSION 3.19)

#### Project running_led definitions start ####
project(running_led VERSION 1.0.0 LANGUAGES ASM C)

add_executable(
    running_led.elf
    "${CMAKE_CURRENT_SOURCE_DIR}/src/running_led/main.c"
    )

target_include_directories(
    running_led.elf
    PRIVATE 
        "${CMAKE_CURRENT_SOURCE_DIR}/src/running_led"
    )

add_subdirectory("${CMAKE_CURRENT_SOURCE_DIR}/extern/gd32vf103")

target_compile_definitions(gd32vf103 PUBLIC GD32VF103V_EVAL)

target_link_libraries(running_led.elf gd32vf103)
##### Project running_led definitions end ####