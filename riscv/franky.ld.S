/*
 * License file: License/license.txt
 * Copyright (C) 2018 Guan Xuetao
 */

#include "platform.h"

/* Specify the machine architecture */
OUTPUT_ARCH( "riscv" )

/* Specify the default entry point to the program */
ENTRY(_mstart)

/*****************************************************************************
 * Define the sections, and where they are mapped in memory
 ****************************************************************************/
SECTIONS {
	. = PLATFORM_RAM_BASE;

	. = ALIGN(64);
	.init : {
		*boot.o(.text)
	}

	. = ALIGN(64);
	.text : {
		PROVIDE( _text = ABSOLUTE(.) );

		/* Normal code sections */
		. = ALIGN(8);
		*(.text .text.*)
		*(.gnu.linkonce.t.*)

		PROVIDE( _etext = ABSOLUTE(.) );
	}

	. = ALIGN(64);
	.rodata : {
		PROVIDE( __rodata_start = ABSOLUTE(.) );

		/* Read-only data sections */
		. = ALIGN(8);
		*(.rodata .rodata.*)
		*(.gnu.linkonce.r.*)

		/* Read-only small data sections */
		. = ALIGN(8);
		*(.srodata .srodata.*)

		PROVIDE( __rodata_end = ABSOLUTE(.) );
	}

	. = ALIGN(64);
	.data : {
		PROVIDE( _data = ABSOLUTE(.) );

		/* Writable data sections */
		. = ALIGN(8);
		*(.data .data.*)
		*(.gnu.linkonce.d.*)

		/* Writable small data sections */
		. = ALIGN(8);
		*(.sdata .sdata.*)
		*(.gnu.linkonce.s.*)

		/* Align _edata to cache line size */
		PROVIDE( _edata = ABSOLUTE(.) );
	}

	. = ALIGN(64);
	.bss : {
		PROVIDE( __bss_start = ABSOLUTE(.) );

		/* Uninitialized writeable data sections */
		. = ALIGN(8);
		*(.bss .bss.*)
		*(.gnu.linkonce.b.*)

		/* Writable uninitialized small data sections */
		. = ALIGN(8);
		*(.sbss .sbss.*)
		*(.gnu.linkonce.sb.*)

		PROVIDE( __bss_end = ABSOLUTE(.) );
	}

	. = ALIGN(64);
	PROVIDE( _end = ABSOLUTE(.) );
}
