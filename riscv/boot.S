/*
 * License file: License/license.txt
 * Copyright (C) 2018 Guan Xuetao
 */

	.align 6
	.section .text,"ax",@progbits
	.globl _mstart

/* Startup code */
_mstart:
	/* set all gp regs as zero */
	.irp	regno, 1, 2, 3, 4, 5, 6, 7, 8, 9
	li	x\regno, 0
	.endr
	.irp	regno, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9
	li	x1\regno, 0
	li	x2\regno, 0
	.endr
	li	x30, 0
	li	x31, 0

	/* init bss section */

	/* init stack */

	/* call main func just for build process */
	j	main
