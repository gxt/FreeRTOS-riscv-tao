/*
 * License file: License/license.txt
 * Copyright (C) 2018 Guan Xuetao
 */
#include <encoding.h>

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

	/* init bss section */

	/* init stack */

	/* call main func just for build process */
	j	main

trap_vector:
	j	trap_vector
