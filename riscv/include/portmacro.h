/*
 * License file: License/license.txt
 * Copyright (C) 2018 Guan Xuetao
 */

#ifndef __PORT_MACRO_H__
#define __PORT_MACRO_H__

#ifndef __riscv64
	#error	ONLY 64-bit supported
#endif

#if	( configUSE_16_BIT_TICKS == 1 )
	#error	MUST set configUSE_16_BIT_TICKS as 0
#endif

#ifdef __cplusplus
extern "C" {
#endif

/*-----------------------------------------------------------
 * Port specific definitions.
 *
 * The settings in this file configure FreeRTOS correctly for the
 * given hardware and compiler.
 *
 * These settings should not be altered.
 *-----------------------------------------------------------
 */

/* Type definitions. */
#define portCHAR				char
#define portFLOAT				float
#define portDOUBLE				double
#define portLONG				long
#define portSHORT				short
#define portBASE_TYPE				long

#define portSTACK_TYPE				uint64_t
#define portPOINTER_SIZE_TYPE			uint64_t

typedef portSTACK_TYPE StackType_t;
typedef long BaseType_t;
typedef unsigned long UBaseType_t;
typedef uint32_t TickType_t;

/* Architecture specifics. */
#define portSTACK_GROWTH			( -1 )
#define portMAX_DELAY				( ( TickType_t ) 0xffffffffUL )
#define portTICK_PERIOD_MS			( ( TickType_t ) (1000 / configTICK_RATE_HZ) )
#define portBYTE_ALIGNMENT			8
#define portCRITICAL_NESTING_IN_TCB		1

#define portDISABLE_INTERRUPTS()		__asm volatile  ( "csrc mstatus,1" )
#define portENABLE_INTERRUPTS()			__asm volatile  ( "csrs mstatus,1" )
#define portNOP()				__asm volatile 	( "nop" )

/* Scheduler utilities. */
extern void vPortYield( void );
#define portYIELD()					vPortYield()

/* Critical section management. */
extern int vPortSetInterruptMask( void );
extern void vPortClearInterruptMask( int );
extern void vPortEnterCritical( void );
extern void vPortExitCritical( void );
#define portENTER_CRITICAL()				vPortEnterCritical()
#define portEXIT_CRITICAL()				vPortExitCritical()
#define portSET_INTERRUPT_MASK_FROM_ISR()		vPortSetInterruptMask()
#define portCLEAR_INTERRUPT_MASK_FROM_ISR( uxSavedStatusValue )		\
		vPortClearInterruptMask( uxSavedStatusValue )

/* Task function macros as described on the FreeRTOS.org WEB site. */
#define portTASK_FUNCTION_PROTO( vFunction, pvParameters )		\
		void vFunction( void *pvParameters )
#define portTASK_FUNCTION( vFunction, pvParameters )			\
		void vFunction( void *pvParameters )

#ifdef __cplusplus
}
#endif

#endif /* __PORT_MACRO_H__ */
