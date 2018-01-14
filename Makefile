#
# License file: License/license.txt
# Copyright (C) 2018 Guan Xuetao
#

CROSS_RISCV	?= /opt/riscv64/bin/riscv64-unknown-elf-
CROSS_GCC	:= $(CROSS_RISCV)gcc

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
		$(TOPDIR)/riscv/portasm.S


FREERTOS_OBJ	:= $(FREERTOS_SRC:.c=.o)
RISCV_OBJ	:= $(RISCV_SRC:.c=.o) $(RISCV_ASM:.S=.o)
OBJS		:= $(FREERTOS_OBJ) $(RISCV_OBJ)
TARGET		:= $(TOPDIR)/riscv.bin

CFLAGS		:=							\
		-Wall							\
		-fomit-frame-pointer -fno-strict-aliasing		\
		-I$(TOPDIR)/Source/include				\
		-I$(TOPDIR)/riscv/include

LDFLAGS		:= -static

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

tao:	$(OBJS)
	@echo "    LD $(TARGET)"
	@$(CROSS_GCC) -o $(TARGET) $(LDFLAGS) $(OBJS)
	@echo "    --- BINGO! ---"

clean:
	@rm -f $(OBJS)
	@rm -f $(TARGET)

