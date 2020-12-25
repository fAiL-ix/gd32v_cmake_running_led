cmake_minimum_required(VERSION 3.19)

### Require out-of-source builds
file(TO_CMAKE_PATH "${PROJECT_BINARY_DIR}/CMakeLists.txt" LOC_PATH)
if(EXISTS "${LOC_PATH}")
    message(FATAL_ERROR "You cannot build in a source directory (or any directory with a CMakeLists.txt file). Please make a build subdirectory. Feel free to remove CMakeCache.txt and CMakeFiles.")
endif()


#### Project gd32v_startup definitions start ####

# This is your project statement. You should always list languages;
# Listing the version is nice here since it sets lots of useful variables
project(gd32v_startup VERSION 0.1.0 LANGUAGES C ASM)


# If you set any CMAKE_ variables, that can go here.
# (But usually don't do this, except maybe for C++ standard)

# Use the toolchain for our MCU
set(CMAKE_TOOLCHAIN_FILE "${CMAKE_CURRENT_SOURCE_DIR}/tools/riscv32-gcc-toolchain.cmake" CACHE FILEPATH "" FORCE)

# Find packages go here.


add_executable(
    ${PROJECT_NAME}
    "${CMAKE_CURRENT_SOURCE_DIR}/src/main.c"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/systick.c"
    )

target_include_directories(
    gd32v_startup 
    PRIVATE 
        "${CMAKE_CURRENT_SOURCE_DIR}/src"
    )


target_compile_features(
    gd32v_startup 
    PRIVATE 
        c_std_11
    )

# target_compile_options(
#     gd32v_startup
#     PRIVATE
#         -march=rv32imac
#         -mabi=ilp32
#         -mcmodel=medlow
#         -DUSE_STDPERIPH_DRIVER
#         -DHXTAL_VALUE=8000000U
#         -Wl
#         -Bstatic
#         -fsigned-char
#         -ffunction-sections
#         -fno-common
#         -fdata-sections
#         -MMD
#         -MP
#     )



# Linking with the right linker script
set_target_properties(gd32v_startup PROPERTIES LINK_DEPENDS "${CMAKE_CURRENT_SOURCE_DIR}/tools/GD32VF103xB.lds")
##### Project gd32v_startup definitions end ####