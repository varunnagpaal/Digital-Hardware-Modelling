Digital Hardware Design and Modelling
=====================================
## Using Verilog, SystemVerilog, VHDL, SystemC, HLS (C++, OpenCL)

Idea of this repo came from my own answer(advice) I wrote for a question on quora: [VLSI: What are good ways to learn to get better at digital design?](https://www.quora.com/VLSI-What-are-good-ways-to-learn-to-get-better-at-digital-design/answer/Varun-Nagpal-3?srid=tSKg "VLSI: What are good ways to learn to get better at digital design?"). This repository serves as a means to accomplish some of the ways I had discussed in my answer.

The idea for this repository is to therefore build hardware models in Verilog, SystemVerilog, VHDL,  SystemC, HLS(C++,OpenCL) at various levels of abstraction: Logic, RTL,TLM and Behavioral/Algorithmic. Also, as much as possible, focus would be to make the hardware models which are:
- Generic, Reusable and Portable
- Compatible with standard hardware/software interfaces
- Built using best practices for design and coding
- Script driven simulation, synthesis and functional verification (test benches)

### Following is list of some of projects I have thought about as of now for this repository:
1. Glue Logic: Register, Shift-Register, Counters, Encoder/Decoder, Mux/Demux, Block RAMs
2. IEEE Pipelined Floating Point Fused Multiplier Accumulator Unit (32-bit and 64-bit)
3. DSP Algorithms: 2D or 3D FFT, FIR (CIC etc.) and IIR Filters(Biquad IIR etc.)
4. Serial Interface or Controllers IP such as I2C, SPI, 16450 UART, SERDES (Serializer Deserializer)
5. Bidirectional bus master/slave interfaces(mux or tristate based), Bus arbiter for multiple masters
6. Direct Digital Synthesizer(DDS) using external DAC
7. Processor Micro-architecture units: Instruction Fetch, Pre-decode, Decode, ALU(scalar and simd vector), Register File, Register R/W, Register Rename, Dispatch, Retire, Branch predictors, Buffers(Instruction, BTB), Queues(Instruction Issue, Load/Store), DMA IP, DRAM Controller(Memory R/W), Cache Controller, Instruction Cache, Data Cache, Scratch pad shared memory, Coherent cache controller
8. Pipelined scalar or vector(SIMD) processor based on a RISC ISA such as ARM 7 or RISC-V using above micro-architecture units
9. Super-scalar processor using above micro-architecture units
10. Algorithms such as sorting, searching, scan, reduction, shuffle, run length encoding, etc.
11. Domain specific algorithms such as cryptography(AES, DES), image processing, wireless(OFDM), machine learning, deep learning, scientific computing etc.

### Tools
- **Synthesis**: Synopsys Synplify Pro, Xilinx ISE/Vivado, Synopsys Design Compiler (DC)
- **Simulation**: Mentor Graphics Modelsim, Questasim, Cadence Incisive
- **SoC Design Platforms**: Xilinx ISE, Xilinx Vivado/HLS/SDK (SDSoC Development Environment), Microsemi Libero SoC

### Boards and Instruments
- **FPGA Boards**
  - Digilent Zybo Zynq Z-7010 ARM/FPGA SoC Development Board
  - Snickerdoodle Zynq Z-7020 ARM/FPGA SoC Development Board
  - Microsemi SmartFusion Mixed Signal SoC(FPGA with ARM Cortex M3)

- **Digital/Analog Oscilloscope cum Signal Generator**: Digilent Analog Discovery

### Parts
I will be using some of the [parts](https://github.com/varunnagpaal/Analog-Design-Modelling/blob/master/Parts/LAOE-PE-PartsList.xlsx) from my [Analog Design and Modeling](https://github.com/varunnagpaal/Analog-Design-Modelling) github project.

### References
- **Logic, RTL Design and Computer Architecture (Verilog, System Verilog, Vhdl)**
  - Digital Design: A Systems Approach by William J. Dally, R. Curtis Harting, Tor M. Aamodt
  - RTL Modeling with SystemVerilog for Simulation and Synthesis using SystemVerilog for ASIC and FPGA design by Stuart Sutherland
  - Digital Systems Design with SystemVerilog by Mark Zwolinski
  - RTL hardware using VHDL by Pong Chu
  - Circuit design and simulation with VHDL by Volnei A. Pedroni
  - Logic and Computer Design Fundamentals 5th Edition by M. Morris Mano, Charles R. Kime, Tom Martin
  - Digital design and Computer Architecture - ARM edition by Harris & Harris
  [//]: # (- HDL WITH DIGITAL DESIGN VHDL AND VERILOG by Nazeih Botros)

- **High Level Synthesis (Algorithms to Architecture)**
  - VLSI Digital Signal Processing Systems: Design and Implementation by Keshab K. Parhi
  - DSP Architecture Design Essentials by Dejan Markovic, Robert W. Brodersen
  - Digital Design of Signal Processing Systems by Shoab Ahmed Khan  
  - A practical introduction to HW/SW codesign 2nd edition by Patrick Schaumont
  - High level synthesis Blue book by Michael Fingeroff
  - Parallel Programming for FPGAs by Ryan Kastner, Janarbek Matai, and Stephen Neuendorffer
  - Xilinx Vivado Design Suite Tutorial - High-Level Synthesis (UG871)
  - Xilinx Introduction to FPGA Design with Vivado High-Level Synthesis (UG998)
  - Xilinx Vivado Design Suite User Guide - High-Level Synthesis (UG902)

- **FPGA System Design**
  - FPGA Prototyping by VERILOG Examples by Pong Chu
  - FPGA Prototyping by VHDL Examples by Pong Chu
  - Top-Down Digital VLSI Design: From Architectures to Gate-Level Circuits and FPGAs by Hubert Kaeslin
  - Embedded Systems Design with Platform FPGAs: Principles and Practices by Ron Sass, Andrew G. Schmidt
  - Reconfigurable Computing, Volume 1: The Theory and Practice of FPGA-Based Computation (Systems on Silicon) by Scott Hauck et al.
  - The Simple Art of SoC Design Closing the Gap between RTL and ESL by Michael

- **Topic Specific Books**
  - FSM in Hardware (VHDL/SystemVerilog) by Volnei A. Pedroni
  - Constraining designs for Synthesis and Timing Analysis by Sanjay Churiwala., Sridhar Gangadharan
  - Static Timing Analysis for Nanometer Designs A Practical Approach by J. Bhasker, Rakesh Chadha
  - High-Speed Serial I/O Made Simple A Designer's Guide with FPGA Applications by Abhijit Athavale, Carl Christensen

  [//]: # (- Digital Systems Engineering by William J. Dally and John W. Poulton)
  [//]: # (- Signal Integrity - Simplified by Eric Bogatin)
  [//]: # (- High Speed Digital Design Design of High Speed Interconnects and Signaling by Hanqiao Zhang, Steven Krooswyk and Jeff Ou)
