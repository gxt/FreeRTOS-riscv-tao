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

FREERTOS_OBJ	:= $(FREERTOS_SRC:.c=.o)

OBJS		:= $(FREERTOS_OBJ)

CFLAGS		:=							\
		-Wall							\
		-fomit-frame-pointer -fno-strict-aliasing		\
		-I$(TOPDIR)/Source/include				\
		-I$(TOPDIR)/riscv/include

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

clean:
	@rm -f $(OBJS)

