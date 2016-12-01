Digital Hardware Design and Modelling
=====================================
##Using VHDL, SystemVerilog, SystemC, HLS(C++, OpenCL)

Idea of this repo is to build hardware models in VHDL, SystemVerilog, SystemC, HLS(C++,OpenCL) at various levels of abstraction: Logic, RTL,TLM and Behavioral/Algorithmic.As much as possible, the models would be generic, reusable and compatible with standard interfaces.

###Following is list of some of projects
1. Glue Logic: Register, Shift-Register, Counters, Encoder/Decoder, Mux/Demux, Block RAMs
2. IEEE Pipelined Floating Point Fused Multiplier Accumulator Unit (32-bit and 64-bit)
3. DSP Algorithms: 2D or 3D FFT, FIR (CIC etc.) and IIR Filters(Biquad IIR etc.)
4. Serial Interface or Controllers IP such as I2C, SPI, 16450 UART, SERDES (Serializer Deserializer)
5. Bidirectional bus master/slave interfaces(mux or tristate based), Bus arbiter for multiple masters
6. Direct Digital Synthsizer(DDS) using external DAC
7. Processor Microarchitecture units: Instruction Fetch, Pre-decode, Decode, ALU(scalar and simd vector), Register File, Register R/W, Register Rename, Dispatch, Retire, Branch predictors, Buffers(Instruction, BTB), Queues(Instruction Issue, Load/Store), DMA IP, DRAM Controller(Memory R/W), Cache Controller, Instruction Cache, Data Cache, Scratch pad shared memory, Coherent cache controller
8. Pipelined scalar or vector(SIMD) processor based on a RISC ISA such as ARM 7 or RISC-V using above microarchitecture units
9. Superscalar processor using above microarchitecture units
10. Algorithms such as sorting, searching, scan, reduction, shuffle, run length encoding, cryptography(AES, DES), image processing etc.

###Tools
- **Synthesis**: Synopsys Synplify Pro
- **Simulation** : Mentor Graphics Modelsim
- **SoC Design**: Microsemi Libero SoC

###Boards and Instruments
- **FPGA Board**: Microsemi SmartFusion Mixed Signal SoC(FPGA with ARM Cortex M3)
- **Digital Oscilloscope**: Digilent Analog Discovery

###References
- Logic, RTL Design and Computer Architecture (VHDL/Verilog)
  - Digital Design: A Systems Approach by William J. Dally et al.
  - Digital Logic Design A Rigorous Approach BY Guy Even,Moti Medina
  - RTL hardware using VHDL by Pong Chu
  - Circuit design and simulation with VHDL by Volnei A. Pedroni
  - Logic & Computer Design Fundamentals 5th Edition by M. Morris Mano, Charles R. Kime, Tom Martin
  - Digital design and Computer Architecture by Harris & Harris
- FPGA System Design
  - FPGA Prototyping by VERILOG Examples by Pong Chu
  - FPGA Prototyping by VHDL Examples by Pong Chu
  - Top-down VLSI design by Hubert Kaeslin
  - A practical introduction to HW/SW codesign 2nd edition by Patrick Schaumont
  - Embedded Systems Design with Platform FPGAs: Principles and Practices by Ron Sass, Andrew G. Schmidt
  - Reconfigurable Computing, Volume 1: The Theory and Practice of FPGA-Based Computation (Systems on Silicon) by Scott Hauck et al.
  
- Topic Specific Books
  - Digital Systems Engineering by William J. Dally and John W. Poulton
  - FSM in Hardware (VHDL/SystemVerilog) by Volnei A. Pedroni
  - Constraining designs for Synthesis and Timing Analysis by Sanjay Churiwala., Sridhar Gangadharan
  - Digital Design of Signal Processing Systems by Shoab Ahmed Khan
  - High level synthesis Blue book by Michael Fingeroff
