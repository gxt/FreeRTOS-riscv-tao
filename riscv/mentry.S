/*
 * License file: License/license.txt
 * Copyright (C) 2018 Guan Xuetao
 */
#include <encoding.h>
#include <platform.h>

#define HART_STACK_SHIFT	(RISCV_PGSHIFT + 1)
#define HART_STACK_SIZE		(RISCV_PGSIZE * 2)

	.align 6
	.section .text,"ax",@progbits
	.globl _mstart

/* Startup code */
_mstart:
	/* init machine-level CSRs */
	csrw	mscratch, x0

	/* ONLY M mode provided */
	li	t0, MSTATUS_MPP
	csrw	mstatus, t0

	/* init mtvec and make sure it sticks */
	la	t0, trap_vector
	csrw	mtvec, t0
	csrr	t1, mtvec
201:	bne	t0, t1, 201b

	/* set all gp regs as zero */
	.irp	regno, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10		\
		11, 12, 13, 14, 15, 16, 17, 18, 19, 20		\
		21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31
	li	x\regno, 0
	.endr

	/* ONLY hartid 0 handle boot code */
	csrr	t0, mhartid
	beqz	t0, 203f
202:
	wfi
	csrr	t0, mhartid
	bnez	t0, 202b
203:

	/* init bss section */
	la	a0, __bss_start
	la	a1, __bss_end
204:	sd	x0, 0(a0)
	bgeu	a0, a1, 205f
	addi	a0, a0, 8
	j	204b
205:

	/* init stack */
	la	sp, __stacks + HART_STACK_SIZE
	csrr	t0, mhartid
	slli	t1, t0, HART_STACK_SHIFT
	add	sp, sp, t1

	/* call main func just for build process */
	j	main

trap_vector:
	j	trap_vector

	.section .bss
	.align	HART_STACK_SHIFT
__stacks:
	.space	HART_STACK_SIZE * PLATFORM_MAX_HARTS
