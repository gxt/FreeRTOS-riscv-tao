/*
 * License file: License/license.txt
 * Copyright (C) 2018 Guan Xuetao
 */

/* Kernel includes. */
#include "FreeRTOS.h"
#include "task.h"
#include "queue.h"
#include "timers.h"
#include "nolib.h"

#define TASK1_TASK_PRIO			1
#define TASK1_STK_SIZE			256
TaskHandle_t Task1Task_Handler;
void task1_task(void *pvParameters);

#define TASK2_TASK_PRIO			2
#define TASK2_STK_SIZE			256
TaskHandle_t Task2Task_Handler;
void task2_task(void *pvParameters);

int main( void )
{
	BaseType_t result;

	printf("create task 1\n");
	result = xTaskCreate((TaskFunction_t)task1_task,
		(const char *)"task1_task",
		(uint16_t)TASK1_STK_SIZE,
		(void *)NULL,
		(UBaseType_t) TASK1_TASK_PRIO,
		(TaskHandle_t *)&Task1Task_Handler);
	printf("task1 result:%d\n", (uint32_t)result);

	printf("create task 2\n");
	result = xTaskCreate((TaskFunction_t)task2_task,
		(const char *)"task2_task",
		(uint16_t)TASK2_STK_SIZE,
		(void *)NULL,
		(UBaseType_t) TASK2_TASK_PRIO,
		(TaskHandle_t *)&Task2Task_Handler);
		printf("task2 result:%d\n", (uint32_t)result);

	printf("start kernel\n");
	/* Start the kernel.  From here on, only tasks and interrupts will run. */
	vTaskStartScheduler();

	/* Exit FreeRTOS */
	return 0;
}

void task1_task(void *pvParameters)
{
	static uint32_t cnt1 = 0;
	while (1) {
		printf("task1 running (cnt1 %d)\n", cnt1);
		vTaskDelay(3);
	}
}

void task2_task(void *pvParameters)
{
	static uint32_t cnt2 = 0;
	while (1) {
		printf("task2 running (cnt2 %d)\n", cnt2);
		vTaskDelay(5);
	}
}
