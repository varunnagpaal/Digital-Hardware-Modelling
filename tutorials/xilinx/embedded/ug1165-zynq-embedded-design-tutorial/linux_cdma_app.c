/*
 * Copyright (c) 2012 Xilinx, Inc.  All rights reserved.
 *
 * Xilinx, Inc.
 * XILINX IS PROVIDING THIS DESIGN, CODE, OR INFORMATION "AS IS" AS A
 * COURTESY TO YOU.  BY PROVIDING THIS DESIGN, CODE, OR INFORMATION AS
 * ONE POSSIBLE   IMPLEMENTATION OF THIS FEATURE, APPLICATION OR
 * STANDARD, XILINX IS MAKING NO REPRESENTATION THAT THIS IMPLEMENTATION
 * IS FREE FROM ANY CLAIMS OF INFRINGEMENT, AND YOU ARE RESPONSIBLE
 * FOR OBTAINING ANY RIGHTS YOU MAY REQUIRE FOR YOUR IMPLEMENTATION.
 * XILINX EXPRESSLY DISCLAIMS ANY WARRANTY WHATSOEVER WITH RESPECT TO
 * THE ADEQUACY OF THE IMPLEMENTATION, INCLUDING BUT NOT LIMITED TO
 * ANY WARRANTIES OR REPRESENTATIONS THAT THIS IMPLEMENTATION IS FREE
 * FROM CLAIMS OF INFRINGEMENT, IMPLIED WARRANTIES OF MERCHANTABILITY
 * AND FITNESS FOR A PARTICULAR PURPOSE.
 *
 */

#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <sys/mman.h>
#include <unistd.h>
#include <string.h>

// The purpose this test is to show that users can get to devices in user
// mode .This is not to say this should replace a kernel driver, but does
// provide some short term solutions sometimes
// or a debug solution that can be helpful.


// This test was derived from devmem2.c.

#define CDMA_BASE_ADDRESS     0x7E200000
#define GPIO_DATA_OFFSET     0
#define GPIO_DIRECTION_OFFSET     4

#define DDR_BASE_ADDRESS     0x20000000

#define DDR_BASE_WRITE_ADDRESS    0x30000000

#define XGPIO_CHAN_OFFSET  8

#define XAXICDMA_CR_OFFSET    	0x00000000  /**< Control register */
#define XAXICDMA_SR_OFFSET    	0x00000004  /**< Status register */
#define XAXICDMA_CDESC_OFFSET 	0x00000008  /**< Current descriptor pointer */
#define XAXICDMA_TDESC_OFFSET	0x00000010  /**< Tail descriptor pointer */
#define XAXICDMA_SRCADDR_OFFSET 0x00000018  /**< Source address register */
#define XAXICDMA_DSTADDR_OFFSET 0x00000020  /**< Destination address register */
#define XAXICDMA_BTT_OFFSET     0x00000028  /**< Bytes to transfer */


/** @name Bitmasks of XAXICDMA_CR_OFFSET register
 * @{
 */
#define XAXICDMA_CR_RESET_MASK	0x00000004 /**< Reset DMA engine */
#define XAXICDMA_CR_SGMODE_MASK	0x00000008 /**< Scatter gather mode */

/** @name Bitmask for interrupts
 * These masks are shared by XAXICDMA_CR_OFFSET register and
 * XAXICDMA_SR_OFFSET register
 * @{
 */
#define XAXICDMA_XR_IRQ_IOC_MASK	0x00001000 /**< Completion interrupt */
#define XAXICDMA_XR_IRQ_DELAY_MASK	0x00002000 /**< Delay interrupt */
#define XAXICDMA_XR_IRQ_ERROR_MASK	0x00004000 /**< Error interrupt */
#define XAXICDMA_XR_IRQ_ALL_MASK	0x00007000 /**< All interrupts */
#define XAXICDMA_XR_IRQ_SIMPLE_ALL_MASK	0x00005000 /**< All interrupts for
                                                        simple only mode */
/*@}*/

/** @name Bitmasks of XAXICDMA_SR_OFFSET register
 * This register reports status of a DMA channel, including
 * idle state, errors, and interrupts
 * @{
 */
#define XAXICDMA_SR_IDLE_MASK         0x00000002  /**< DMA channel idle */
#define XAXICDMA_SR_SGINCLD_MASK      0x00000008  /**< Hybrid build */
#define XAXICDMA_SR_ERR_INTERNAL_MASK 0x00000010  /**< Datamover internal err */
#define XAXICDMA_SR_ERR_SLAVE_MASK    0x00000020  /**< Datamover slave err */
#define XAXICDMA_SR_ERR_DECODE_MASK   0x00000040  /**< Datamover decode err */
#define XAXICDMA_SR_ERR_SG_INT_MASK   0x00000100  /**< SG internal err */
#define XAXICDMA_SR_ERR_SG_SLV_MASK   0x00000200  /**< SG slave err */
#define XAXICDMA_SR_ERR_SG_DEC_MASK   0x00000400  /**< SG decode err */
#define XAXICDMA_SR_ERR_ALL_MASK      0x00000770  /**< All errors */
/*@}*/

#define MAP_SIZE 4096UL
#define MAP_MASK (MAP_SIZE - 1)

#define DDR_MAP_SIZE 0x10000000
#define DDR_MAP_MASK (DDR_MAP_SIZE - 1)

#define DDR_WRITE_OFFSET 0x10000000



#define BUFFER_BYTESIZE		262144	// Length of the buffers for DMA transfer

int main()
{
	int memfd;
    void *mapped_base, *mapped_dev_base;
    off_t dev_base = CDMA_BASE_ADDRESS;

    int memfd_1;
    void *mapped_base_1, *mapped_dev_base_1;
    off_t dev_base_1 = DDR_BASE_ADDRESS;

    int memfd_2;
    void *mapped_base_2, *mapped_dev_base_2;
    off_t dev_base_2 = DDR_BASE_WRITE_ADDRESS;

    unsigned int TimeOut =5;
    unsigned int ResetMask;
    unsigned int RegValue;
    unsigned int SrcArray[BUFFER_BYTESIZE ];
    unsigned int DestArray[BUFFER_BYTESIZE ];
    unsigned int Index;
    /*======================================================================================
     STEP 1 : Initialize the source buffer bytes with a pattern  and clear the Destination
     	 	  location
 	 ========================================================================================*/
  	for (Index = 0; Index < (BUFFER_BYTESIZE/2); Index++)
  	{
  			SrcArray[Index] = 0x5A5A5A5A/*Index & 0xFF*/;
  			DestArray[Index] = 0;
  	}
  	/*======================================================================================
  	STEP 2 : Map the kernel memory location starting from 0x20000000 to the User layer
  	========================================================================================*/
  	memfd_1 = open("/dev/mem", O_RDWR | O_SYNC);
    if (memfd_1 == -1)
    {
    	printf("Can't open /dev/mem.\n");
        exit(0);
    }
    printf("/dev/mem opened.\n");
    // Map one page of memory into user space such that the device is in that page, but it may not
    // be at the start of the page.

    mapped_base_1 = mmap(0, DDR_MAP_SIZE, PROT_READ | PROT_WRITE, MAP_SHARED, memfd_1, dev_base_1 & ~DDR_MAP_MASK);
    if (mapped_base_1 == (void *) -1)
    {
    	printf("Can't map the memory to user space.\n");
        exit(0);
    }
    printf("Memory mapped at address %p.\n", mapped_base_1);
    // get the address of the device in user space which will be an offset from the base
    // that was mapped as memory is mapped at the start of a page
     mapped_dev_base_1 = mapped_base_1 + (dev_base_1 & DDR_MAP_MASK);
     /*======================================================================================
     STEP 3 : Copy the Data to the DDR Memory at location 0x20000000
     ========================================================================================*/
    memcpy(mapped_dev_base_1, SrcArray, (BUFFER_BYTESIZE));
    /*======================================================================================
     STEP 4 : Un-map the kernel memory from the User layer.
    ========================================================================================*/
    if (munmap(mapped_base_1, DDR_MAP_SIZE) == -1)
    {
    	printf("Can't unmap memory from user space.\n");
    	exit(0);
    }
    close(memfd_1);
  	/*======================================================================================
  	STEP 5 : Map the AXI CDMA Register memory to the User layer
  			Do the Register Setting for DMA transfer
  	========================================================================================*/
    memfd = open("/dev/mem", O_RDWR | O_SYNC);
    if (memfd == -1)
    {
    	printf("Can't open /dev/mem.\n");
    	exit(0);
    }
      printf("/dev/mem opened.\n");

    // Map one page of memory into user space such that the device is in that page, but it may not
    // be at the start of the page.
    mapped_base = mmap(0, MAP_SIZE, PROT_READ | PROT_WRITE, MAP_SHARED, memfd, dev_base & ~MAP_MASK);
    if (mapped_base == (void *) -1)
    {
    	  printf("Can't map the memory to user space.\n");
    	  exit(0);
      }
    // get the address of the device in user space which will be an offset from the base
    // that was mapped as memory is mapped at the start of a page
    mapped_dev_base = mapped_base + (dev_base & MAP_MASK);
    //Reset CDMA
      do{
    	  	  ResetMask = (unsigned long )XAXICDMA_CR_RESET_MASK;
 			*((volatile unsigned long *) (mapped_dev_base + XAXICDMA_CR_OFFSET)) = (unsigned long)ResetMask;
			/* If the reset bit is still high, then reset is not done	*/
			ResetMask = *((volatile unsigned long *) (mapped_dev_base + XAXICDMA_CR_OFFSET));
			if(!(ResetMask & XAXICDMA_CR_RESET_MASK))
			{
				break;
			}
			TimeOut -= 1;
      }while (TimeOut);
      	//enable Interrupt
      RegValue = *((volatile unsigned long *) (mapped_dev_base + XAXICDMA_CR_OFFSET));
      RegValue = (unsigned long)(RegValue | XAXICDMA_XR_IRQ_ALL_MASK );
      *((volatile unsigned long *) (mapped_dev_base + XAXICDMA_CR_OFFSET)) = (unsigned long)RegValue;
      // Checking for the Bus Idle
      RegValue = *((volatile unsigned long *) (mapped_dev_base + XAXICDMA_SR_OFFSET));
      if(!(RegValue & XAXICDMA_SR_IDLE_MASK))
      {
    	  printf("BUS IS BUSY Error Condition \n\r");
    	  return 1;
      }
      // Check the DMA Mode and switch it to simple mode
      RegValue = *((volatile unsigned long *) (mapped_dev_base + XAXICDMA_CR_OFFSET));
      if((RegValue & XAXICDMA_CR_SGMODE_MASK))
      {
    	  RegValue = (unsigned long)(RegValue & (~XAXICDMA_CR_SGMODE_MASK));
    	  printf("Reading \n \r");
    	  *((volatile unsigned long *) (mapped_dev_base + XAXICDMA_CR_OFFSET)) = (unsigned long)RegValue ;

      }
      //Set the Source Address
      *((volatile unsigned long *) (mapped_dev_base + XAXICDMA_SRCADDR_OFFSET)) = (unsigned long)DDR_BASE_ADDRESS;
      //Set the Destination Address
      *((volatile unsigned long *) (mapped_dev_base + XAXICDMA_DSTADDR_OFFSET)) = (unsigned long)DDR_BASE_WRITE_ADDRESS;
      RegValue = (unsigned long)(BUFFER_BYTESIZE);
      // write Byte to Transfer
      *((volatile unsigned long *) (mapped_dev_base + XAXICDMA_BTT_OFFSET)) = (unsigned long)RegValue;
    	/*======================================================================================
    	STEP 6 : Wait for the DMA transfer Status
    	========================================================================================*/
      do
      {
    	 	  RegValue = *((volatile unsigned long *) (mapped_dev_base + XAXICDMA_SR_OFFSET));
      }while(!(RegValue & XAXICDMA_XR_IRQ_ALL_MASK));

      if((RegValue & XAXICDMA_XR_IRQ_IOC_MASK))
      {
    	  printf("Transfer Completed \n\r ");
      }
      if((RegValue & XAXICDMA_XR_IRQ_DELAY_MASK))
      {
      	printf("IRQ Delay Interrupt\n\r ");
      }
      if((RegValue & XAXICDMA_XR_IRQ_ERROR_MASK))
      {
      	printf(" Transfer Error Interrupt\n\r ");
      }

      /*======================================================================================
       STEP 7 : Un-map the AXI CDMA memory from the User layer.
      ========================================================================================*/
      if (munmap(mapped_base, MAP_SIZE) == -1)
      {
      		printf("Can't unmap memory from user space.\n");
      		exit(0);
      }

      close(memfd);

    /*======================================================================================
    STEP 8 : Map the kernel memory location starting from 0x30000000 to the User layer
    ========================================================================================*/
      memfd_2 = open("/dev/mem", O_RDWR | O_SYNC);
       if (memfd_2 == -1)
       {
    	   printf("Can't open /dev/mem.\n");
           exit(0);
       }
       printf("/dev/mem opened.\n");
       // Map one page of memory into user space such that the device is in that page, but it may not
       // be at the start of the page.
       mapped_base_2 = mmap(0, DDR_MAP_SIZE, PROT_READ | PROT_WRITE, MAP_SHARED, memfd_2, dev_base_2 & ~DDR_MAP_MASK);
       if (mapped_base_2 == (void *) -1)
       {
    	   printf("Can't map the memory to user space.\n");
           exit(0);
       }
       printf("Memory mapped at address %p.\n", mapped_base_2);
        // get the address of the device in user space which will be an offset from the base
        // that was mapped as memory is mapped at the start of a page
        mapped_dev_base_2 = mapped_base_2 + (dev_base_2 & DDR_MAP_MASK);

        /*======================================================================================
        STEP 9 : Copy the Data from DDR Memory location 0x20000000 to Destination Buffer
        ========================================================================================*/
        memcpy(DestArray, mapped_dev_base_2, (BUFFER_BYTESIZE ));
        /*======================================================================================
        STEP 10 : Un-map the Kernel memory from the User layer.
        ========================================================================================*/
        if (munmap(mapped_base_2, DDR_MAP_SIZE) == -1)
        {
        	printf("Can't unmap memory from user space.\n");
            exit(0);
        }

       close(memfd_2);


       /*======================================================================================
        STEP 11 : Compare Source Buffer with Destination Buffer.
       ========================================================================================*/
       for (Index = 0; Index < (BUFFER_BYTESIZE/4); Index++)
       {
    	   if (SrcArray[Index] != DestArray[Index])
    	   {
    		   printf("Error in the Data comparison \n \r");
    		   return 1;
    	   }
       }
       printf("DATA Transfer is Successful \n\r");

    return 0;
}
