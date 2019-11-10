/******************************************************************************
*
* Copyright (C) 2009 - 2014 Xilinx, Inc.  All rights reserved.
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* Use of the Software is limited solely to applications:
* (a) running on a Xilinx device, or
* (b) that interact with a Xilinx device through a bus or interconnect.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
* XILINX  BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
* WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF
* OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
* SOFTWARE.
*
* Except as contained in this notice, the name of the Xilinx shall not be used
* in advertising or otherwise to promote the sale, use or other dealings in
* this Software without prior written authorization from Xilinx.
*
******************************************************************************/

/*
 * main.c: simple test application
 *
 * This application configures UART 16550 to baud rate 9600.
 * PS7 UART (Zynq) is not initialized by this application, since
 * bootrom/bsp configures it to baud rate 115200
 *
 * ------------------------------------------------
 * | UART TYPE   BAUD RATE                        |
 * ------------------------------------------------
 *   uartns550   9600
 *   uartlite    Configurable only in HW design
 *   ps7_uart    115200 (configured by bootrom/bsp)
 */

#include <stdio.h>
#include "platform.h"
#include "xil_printf.h"
#include "xhls_func.h"
#include "xil_io.h"			// for reading/writing to individual memory locations
#include "xil_mem.h"		// for memcpy
#include "xparameters.h"
#include <inttypes.h>		// To print uintx_t and intx_t types properly using printf
#include "xtime_l.h"		// Used to measure time (ARM cc's) a function

#define DEBUG_WR
#undef DEBUG_WR
#define DEBUG_RD
#undef DEBUG_RD

#define MATCH_RD_WR_TEST

#if defined(MATCH_RD_WR_TEST)
#undef TIME_DDR_TEST
#else
#define TIME_DDR_TEST
#endif

#define IO_DATA_BIT_SZ 16

#if (IO_DATA_BIT_SZ == 8)
typedef u8 io_t;
#elif (IO_DATA_BIT_SZ == 16)
typedef u16 io_t;
#elif (IO_DATA_BIT_SZ == 32)
typedef u32 io_t;
#elif (IO_DATA_BIT_SZ == 64)
typedef u64 io_t;
#else
typedef u16 io_t;
#endif

int main()
{
    init_platform();

    u32 ddrStartAddress = XPAR_PS7_DDR_0_S_AXI_BASEADDR*2;
    u32 ddrEndAddress = XPAR_PS7_DDR_0_S_AXI_HIGHADDR;

    io_t wrValue;
#if (IO_DATA_BIT_SZ == 8)
        wrValue = 0x67;
        Xil_Out8(0x00234567, wrValue );
    	io_t rdValue = Xil_In8(0x00234567);
#elif (IO_DATA_BIT_SZ == 16)
    	wrValue = 0x4567;
    	Xil_Out16(0x00234567, wrValue);
    	io_t rdValue = Xil_In16(0x00234567);
#elif (IO_DATA_BIT_SZ == 32)
    	wrValue=0x01234567;
    	Xil_Out32(0x00234567, wrValue);
    	io_t rdValue = Xil_In32(0x00234567);
#elif (IO_DATA_BIT_SZ == 64)
    	wrValue=0x0123456701234567;
    	Xil_Out64(0x00234567, wrValue);
    	io_t rdValue = Xil_In64(0x00234567);
#else
    	wrValue=0x4567;
    	Xil_Out16(0x00234567, wrValue);
    	io_t rdValue = Xil_In16(0x00234567);
#endif

    	printf("Location: 0x%08x, WR Value: 0x%016x, RD Value: 0x%016x\n", 0x00234567, wrValue, rdValue);

#ifdef TIME_DDR_TEST
    XTime timeDdrRdBeg = 0;
    XTime timeDdrRdEnd = 0;
    XTime timeDdrRd = 0;
    XTime timeDdrWrBeg = 0;
    XTime timeDdrWrEnd = 0;
    XTime timeDdrWr = 0;
#endif

    // Fill entire DDR locations with value equal to last 2 bytes of address value of address location being written
    printf("WRITING %lu bytes to DDR\n", ddrEndAddress-ddrStartAddress);
#ifdef TIME_DDR_TEST
    XTime_GetTime(&timeDdrWrBeg);
#endif

    for( u32 ddrAddress = ddrStartAddress; ddrAddress <= (ddrEndAddress-sizeof(io_t)); ddrAddress+=sizeof(io_t))
    {
    	io_t wrValue = (io_t)ddrAddress;

#if (IO_DATA_BIT_SZ == 8)
    	Xil_Out8(ddrAddress, wrValue);
#elif (IO_DATA_BIT_SZ == 16)
        Xil_Out16(ddrAddress, wrValue);
#elif (IO_DATA_BIT_SZ == 32)
        Xil_Out32(ddrAddress, wrValue);
#elif (IO_DATA_BIT_SZ == 64)
        Xil_Out64(ddrAddress, wrValue);
#else
        Xil_Out16(ddrAddress, wrValue);
#endif

#ifdef DEBUG_WR
        printf("Location: 0x%08x, WR Value: 0x%016x\n", ddrAddress, wrValue);
#endif
    }
#ifdef TIME_DDR_TEST
    XTime_GetTime(&timeDdrWrEnd);
    timeDdrWr = timeDdrWrEnd-timeDdrWrBeg;
#endif
    // Read every value from DDR and match. Exit on first fail
    printf("READING %lu bytes from DDR\n", ddrEndAddress-ddrStartAddress);

#ifdef TIME_DDR_TEST
    XTime_GetTime(&timeDdrRdBeg);
#endif

    for( u32 ddrAddress = ddrStartAddress; ddrAddress <= (ddrEndAddress-sizeof(io_t)); ddrAddress+=sizeof(io_t))
    {
#if (IO_DATA_BIT_SZ == 8)
    	io_t rdValue = Xil_In8(ddrAddress);
#elif (IO_DATA_BIT_SZ == 16)
    	io_t rdValue = Xil_In16(ddrAddress);
#elif (IO_DATA_BIT_SZ == 32)
    	io_t rdValue = Xil_In32(ddrAddress);
#elif (IO_DATA_BIT_SZ == 64)
    	io_t rdValue = Xil_In64(ddrAddress);
#else
    	io_t rdValue = Xil_In16(ddrAddress);
#endif

#ifdef MATCH_RD_WR_TEST
    	io_t wrValue = (io_t)ddrAddress;

#if (IO_DATA_BIT_SZ == 8)
    	io_t rdValueEndianSwapped = Xil_EndianSwap16(rdValue);
#elif (IO_DATA_BIT_SZ == 16)
    	io_t rdValueEndianSwapped = Xil_EndianSwap16(rdValue);
#elif (IO_DATA_BIT_SZ == 32)
    	io_t rdValueEndianSwapped = Xil_EndianSwap32(rdValue);
#elif (IO_DATA_BIT_SZ == 64)
    	io_t rdValueEndianSwapped = Xil_EndianSwap64(rdValue);
#else
    	io_t rdValueEndianSwapped = Xil_EndianSwap16(rdValue);
#endif


#if (IO_DATA_BIT_SZ == 8)
    	if(rdValue != (u16)wrValue )
#elif (IO_DATA_BIT_SZ == 16)
    	if( rdValue != (u16)wrValue )
#elif (IO_DATA_BIT_SZ == 32)
    	if( rdValue != (u32)wrValue )
#elif (IO_DATA_BIT_SZ == 64)
    	if( rdValue != (u64)wrValue )
#else
    	if( rdValue != (u16)wrValue )
#endif
        {
        	printf("Match Failed!\n");
        	printf("Location: 0x%08x, WR Value: 0x%016x, RD Value: 0x%016x\n", ddrAddress, wrValue, rdValue );
        	exit(0);
        }
#endif

#ifdef DEBUG_RD
    	printf("Location: 0x%08x, WR Value: 0x%016x, RD Value: 0x%016x\n", ddrAddress, wrValue, rdValue);
#endif
    }

#ifdef TIME_DDR_TEST
    XTime_GetTime(&timeDdrRdEnd);
    timeDdrRd = timeDdrRdEnd-timeDdrRdBeg;

	printf("Wr cc: %llu, Wr Time(sec): %e, Write speed: %lf (Bytes/sec)\n",
			timeDdrWr,
			(double)timeDdrWr/(double)COUNTS_PER_SECOND,
			(double)((double)(ddrEndAddress  - ddrStartAddress)*(double)COUNTS_PER_SECOND/(double)timeDdrWr) );

	printf("Rd cc: %llu, Rd Time(sec): %e, Read speed: %lf (Bytes/sec)\n",
			timeDdrRd,
			(double)timeDdrRd/(double)COUNTS_PER_SECOND,
			(double)((double)(ddrEndAddress  - ddrStartAddress)*(double)COUNTS_PER_SECOND/(double)timeDdrRd) );
#endif

    printf("All Matched!\n\r");

    cleanup_platform();
    return 0;
}
