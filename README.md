# FreeRTOS Porting for RISC-V

## FreeRTOS parts
Not **everything** in FreeRTOS are reserved here:
* FreeRTOS official version: V9.0.0
* FreeRTOS/Source/portable subdir removed, only MemMang reserved
* FreeRTOS/License dir reserved
* FreeRTOS/Demo dir removed

## CodeStyle
* All files from FreeRTOS are transcoded by `dos2unix`
* 1 tab == 4 spaces for Source/ dir (FreeRTOS parts)
* 1 tab == 8 spaces for riscv/ dir (RISCV parts)

## Resouces
* [FreeRTOS homepage](https://www.freertos.org/)
* [RISCV porting for FreeRTOSV8.2.3](https://interactive.freertos.org/hc/en-us/community/posts/210030246-32-bit-and-64-bit-RISC-V-using-GCC)
* [RISCV homepage](https://riscv.org/)
