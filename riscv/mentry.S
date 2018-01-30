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
	.irp	regno, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10		\
		11, 12, 13, 14, 15, 16, 17, 18, 19, 20		\
		21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31
	li	x\regno, 0
	.endr

	/* init bss section */

	/* init stack */

	/* call main func just for build process */
	j	main
