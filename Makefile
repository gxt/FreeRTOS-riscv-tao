#
# License file: License/license.txt
# Copyright (C) 2018 Guan Xuetao
#

CROSS_RISCV	?= /opt/riscv64/bin/riscv64-unknown-elf-
CROSS_GCC	:= $(CROSS_RISCV)gcc
CROSS_LD	:= $(CROSS_RISCV)ld
CROSS_READELF	:= $(CROSS_RISCV)readelf
CROSS_OBJDUMP	:= $(CROSS_RISCV)objdump

TOPDIR		:= $(shell pwd)

FREERTOS_SRC	:=							\
		$(TOPDIR)/Source/croutine.c				\
		$(TOPDIR)/Source/list.c					\
		$(TOPDIR)/Source/queue.c				\
		$(TOPDIR)/Source/tasks.c				\
		$(TOPDIR)/Source/timers.c				\
		$(TOPDIR)/Source/event_groups.c				\
		$(TOPDIR)/Source/portable/MemMang/heap_2.c

RISCV_SRC	:=							\
		$(TOPDIR)/riscv/port.c					\
		$(TOPDIR)/riscv/main.c

RISCV_ASM	:=							\
		$(TOPDIR)/riscv/portasm.S				\
		$(TOPDIR)/riscv/boot.S

NOLIB_SRC	:=							\
		$(TOPDIR)/nolib/printf-stdarg.c				\
		$(TOPDIR)/nolib/string.c

FREERTOS_OBJ	:= $(FREERTOS_SRC:.c=.o)
RISCV_OBJ	:= $(RISCV_SRC:.c=.o) $(RISCV_ASM:.S=.o)
OBJS		:= $(FREERTOS_OBJ) $(RISCV_OBJ)
NOLIB_OBJ	:= $(NOLIB_SRC:.c=.o)

FRANKY		:= $(TOPDIR)/franky

CFLAGS		:=							\
		-Wall							\
		-fomit-frame-pointer -fno-strict-aliasing		\
		-I$(TOPDIR)/Source/include				\
		-I$(TOPDIR)/riscv/include				\
		-I$(TOPDIR)/nolib

LDFLAGS		:= -Bstatic

%.o:	%.c
	@echo "    CC $<"
	@$(CROSS_GCC) -c $(CFLAGS) -o $@ $<

%.o:	%.S
	@echo "    CC $<"
	@$(CROSS_GCC) -c $(CFLAGS) -o $@ $<

all:
	@echo Choose rules:
	@echo "    make tao"
	@echo "    make clean"

prepare:
	@ctags -R

tao:	$(OBJS) tao-nolib

tao-nolib: $(NOLIB_OBJ)
	@echo "    LD $(FRANKY).bin"
	@$(CROSS_LD) $(LDFLAGS) -o $(FRANKY).bin $(OBJS) $(NOLIB_OBJ)
	@$(CROSS_OBJDUMP) -S $(FRANKY).bin > $(FRANKY).asm
	@$(CROSS_READELF) -a $(FRANKY).bin > $(FRANKY).elf
	@echo "    --- BINGO! ---"

clean:
	@rm -f tags
	@rm -f $(OBJS)
	@rm -f $(NOLIB_OBJS)
	@rm -f $(FRANKY).*

