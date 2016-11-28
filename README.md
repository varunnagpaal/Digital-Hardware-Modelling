VHDL, SystemVerilog, SystemC
============================
Idea of this repo is to build hardware models in SystemC, VHDL, SystemVerilog, SystemC, HLS(OpenCL) at various levels of abstraction: RTL,TLM and Behavioral/Algorithmic.
As much as possible, the models would be generic, reusable and compatible with standard interfaces.

Following is list of some of projects

1. Glue Logic: Register, Shift-Register, Counters, Encoder/Decoder, Mux/Demux, Block RAMs
2. IEEE Pipelined Floating Point Fused Multiplier Accumulator Unit (32-bit and 64-bit)
3. IIR Filters(Biquad IIR etc.)
4. FIR filters(CIC etc.)
5. Serial Interface or Controllers IP such as I2C, SPI, 16450 UART
6. SERDES (Serializer Deserializer)
7. Bidirectional bus master/slave interfaces(mux or tristate based)
8. Bus arbiter for multiple masters
9. SDRAM Controller
10. DMA IP
11. Coherent cache controller for Multicore NUMA CPU or GPU
12. Branch predictors
13. Direct Digital Synthsizer(DDS) using external DAC
14. Pipelined scalar or vector(SIMD) processor based on a RISC ISA such as ARM 7 or RISC-V
15. 2D or 3D FFT