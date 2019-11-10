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

#define DEBUG_DDR_WR
#undef DEBUG_DDR_WR				// maybe be commented out
#define DEBUG_DDR_RD
#undef DEBUG_DDR_RD				// maybe be commented out


#define DDR_RD_WR_MATCH_TEST
#undef DDR_RD_WR_MATCH_TEST		// maybe be commented out

#if defined(DDR_RD_WR_MATCH_TEST)
#undef DDR_RD_WR_TIME_TEST
#else
#define DDR_RD_WR_TIME_TEST
#endif

#define IO_DATA_BIT_SZ 8

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

    /* The full range of ddr on Zynq on Zybo is addresses 0x0000_0000 to 0x3fff_0000
     * i.e. 0x40000000 bytes = 1073741824 bytes = 1024 MBytes = 1 GBytes
     * Some part of this range is reserved and rest can be accessed depending upon the device.
     * See Table 4-1: System-Level Address Map in UG585 for further details.
     * One of these sub-ranges in the 1 GB ddr which can be accessed by cpu, acp and all interconnect
     * masters (PL/PS) is 0x0010_0000 to 0x3FFF_FFFF i.e. 3FF00000 = 1072693248 bytes = 1023 MBytes.
     * We use this last 1023 MB range of 1 GB for our purpose and ignore starting 1 MB range of 1 GB ddr
     * Furthermore, the starting section of this remaining 1023 MB ddr sub-range is usually used (not mandatory)
     * to store program executable code sections (text, data, bss) as well as its stack/heap data.
     * The allocation of memory regions for the elf file and its stack/heap is done through the linker script lscript.ld file.
     * The size of various instruction sections (text, data, bss) of binary executable elf file
     * are indicated in the compiler output in console window whenever the project is compiled
     * For example, upon compiling this project (Build all), we should see some console output as follows:
     *
		'Invoking: ARM v7 Print Size'
		arm-none-eabi-size ddr_hls_hp_app.elf  |tee "ddr_hls_hp_app.elf.size"
		   text	   data	    bss	    dec	    hex	filename
		  71116	   2580	  23328	  97024	  17b00	ddr_hls_hp_app.elf
		'Finished building: ddr_hls_hp_app.elf.size'

	 * The compiler output above shows the size of various sections (text, data, bss sections)
	 * of binary executable elf file.  Under dec and hex columns it shows total size of these section in
	 * decimal as 97024 bytes and in hex as 0x17b00 bytes. In addition, memory required to store
	 * stack & heap for this executable elf is listed as 0x2000 each in the linker script(ldscript.ld)
	 * and which is mapped after bss,text,data sections.
	 * In total therefore we must exclude first 0x17b00+0x2000+0x2000 = 0x1BB00 = 113408 bytes (locations)
	 * in ddr subrange (last 1023 MBytes) starting from its base address 0x0010_0000.
	 * This region must not be used for storing (donot write) any user data, either from PS or PL,
	 * otherwise the instructions as well stack/heap data can get corrupted and program may stop working at runtime.
	 * To be on safe side, we exclude the first 128 KB = 0x20000 locations (1 MB to be more safe) starting
	 * from ddr base address (0x0010_0000)
	 *
	 * NOTE: It is possible to relocate instruction/stack/heap in some other memory regions
	 * such mapped to devices such as qspi, ocm on chip 256 KB memory (ps_ram_x) etc.
	 * on Zynq device. Similarly sizes of stack/heap can also be increased or decreased.
	 * All this can be done by changing the linker script (ldscript.ld) file contents
	 * However it is not recommended to change this script unless it there is a special need.
     */
    u32 ddrStartAddress = XPAR_PS7_DDR_0_S_AXI_BASEADDR + 0x20000;
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

#ifdef DDR_RD_WR_TIME_TEST
    XTime timeDdrRdBeg = 0;
    XTime timeDdrRdEnd = 0;
    XTime timeDdrRd = 0;
    XTime timeDdrWrBeg = 0;
    XTime timeDdrWrEnd = 0;
    XTime timeDdrWr = 0;
#endif

    // Fill entire DDR locations with value equal to last 2 bytes of address value of address location being written
    printf("WRITING %lu bytes to DDR\n", ddrEndAddress-ddrStartAddress);
#ifdef DDR_RD_WR_TIME_TEST
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

#ifdef DEBUG_DDR_WR
        printf("Location: 0x%08x, WR Value: 0x%016x\n", ddrAddress, wrValue);
#endif
    }
#ifdef DDR_RD_WR_TIME_TEST
    XTime_GetTime(&timeDdrWrEnd);
    timeDdrWr = timeDdrWrEnd-timeDdrWrBeg;
#endif
    // Read every value from DDR and match. Exit on first fail
    printf("READING %lu bytes from DDR\n", ddrEndAddress-ddrStartAddress);

#ifdef DDR_RD_WR_TIME_TEST
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

#ifdef DDR_RD_WR_MATCH_TEST
    	io_t wrValue = (io_t)ddrAddress;

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

#ifdef DEBUG_DDR_RD
    	printf("Location: 0x%08x, WR Value: 0x%016x, RD Value: 0x%016x\n", ddrAddress, wrValue, rdValue);
#endif
    }

#ifdef DDR_RD_WR_TIME_TEST
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

#ifdef DDR_RD_WR_MATCH_TEST
    printf("All Matched!\n\r");
#endif

    cleanup_platform();
    return 0;
}
