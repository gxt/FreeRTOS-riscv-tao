# FreeRTOS Porting for RISC-V

## FreeRTOS parts
Not **everything** in FreeRTOS are reserved here:
* FreeRTOS official version: V9.0.0
* FreeRTOS/Source/portable subdir removed, only MemMang reserved
* FreeRTOS/License dir reserved
* FreeRTOS/Demo dir removed

## RISC-V parts
* Rocket, 2 harts
* Privileged ISA: v1.9.1
* User-level ISA: v2.0

## Newlib or Nolib
For Nolib:
* string.c: only memset and memcpy
* printf-stdarg.c: L3959 in task.c (but all 32-bit impl)
> An alternative, tiny, third party, and limited functionality implementation
> of sprintf() is provided in many of the FreeRTOS/Demo sub-directories in a
> file called printf-stdarg.c (note printf-stdarg.c does not provide a full
> snprintf() implementation!).

For Newlib:
* SHOULD gen toolchain with newlib support

## CodeStyle
* All files from FreeRTOS are transcoded by `dos2unix`
* 1 tab == 4 spaces for Source/ dir (FreeRTOS parts)
* 1 tab == 8 spaces for riscv/ dir (RISCV parts)

## Resources
* [FreeRTOS homepage](https://www.freertos.org/)
* [RISCV porting for FreeRTOSV8.2.3](https://interactive.freertos.org/hc/en-us/community/posts/210030246-32-bit-and-64-bit-RISC-V-using-GCC)
* [RISCV homepage](https://riscv.org/)
