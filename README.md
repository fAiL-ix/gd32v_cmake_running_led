# GD32V cmake running led project

This is a project on getting the running led example from [WRansohoff](https://github.com/WRansohoff/GD32VF103_templates) working with CMake.


The Code for blinking the LEDs is directly copied from the `hello_led` example in [WRansohoff](https://github.com/WRansohoff/GD32VF103_templates)s repository. I modified the main.c to work with the LEDs on the [SeeedStudio GD32 RISC-V Dev Board](https://wiki.seeedstudio.com/SeeedStudio-GD32-RISC-V-Dev-Board/) and my CMake version of the [RISCV firmware](http://www.gd32mcu.com/en/download/7?kw=GD32VF1).

## Dependencies

To build this project you need a build of the riscv-gcc toolchain in your path with the toolchain prefix `riscv32-elf-`.
If your toolchain has a different prefix you can change the `TOOLCHAIN_PREFIX` variable in the `tools/riscv32-gcc-toolchain.cmake` file.

For flashing a version of openocd with support for the GD32V chip is needed.

## Cloning

This project includes the [GD32VF103 Firmware Lib](https://github.com/fAiL-ix/gd32vf103) as a submodul. To clone this repository with the submodules use the following command:

`git clone --recurse-submodules https://github.com/fAiL-ix/gd32v_cmake_running_led.git`

If you already cloned the repository you can use these two commands to download the submodule:

`git submodule init`

`git submodule update`

## Building

To build this project create a `build` directory and change into it.
Create the makefiles with:
`cmake -DCMAKE_TOOLCHAIN_FILE=../tools/riscv32-gcc-toolchain.cmake ..`
And build the project:
`cmake --build .`

## Flashing

To flash the compiled program use openocd with the supplied config files:
`openocd -f ../tools/sipeed-rv-debugger.cfg -f ../tools/gd32vf103.cfg -c "program gd32v_startup.elf verify reset exit"`