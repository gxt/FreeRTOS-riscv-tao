/*
 * License file: License/license.txt
 * Copyright (C) 2018 Guan Xuetao
 */
#include "FreeRTOS.h"
#include "task.h"
#include "portmacro.h"

/* Set interrupt mask and return current interrupt enable register */
int vPortSetInterruptMask(void)
{
	return 0;
}

/* Clear current interrupt mask and set given mask */
void vPortClearInterruptMask(int mask)
{
}

/* Setup the stack of a new task so it is ready to be placed under the
 * scheduler control.  The registers have to be placed on the stack in
 * the order that the port expects to find them.  */
StackType_t *pxPortInitialiseStack( StackType_t *pxTopOfStack, TaskFunction_t pxCode, void *pvParameters )
{
	return pxTopOfStack;
}
