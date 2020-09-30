# Cache Controller
 Processor-cache-main_memroy interaction
 
 *** Code is located in the ".v" files ***

PROBLEM STATEMENT

Implementation of Memory Subsystem:
The specifications/details for the implementation are mentioned below:

1. The word size of the processor is 32-bits. The processor requests for memory access by
sending 32-bit address.

2. Instruction Cache specifications:
* Hit Time for Cache is one clock cycle
* Cache is 2-way set associative with 4 sets
* Block size is 2 words
* LRU replacement policy is used

3. Cache controller should control the processor, cache and main memory interaction.

4. For simplicity assume that the main memory is byte addressable and has a capacity of
32 words (128 bytes). Also the main memory access requires 10 clock cycles.

Testing of Memory Subsystem:
To test your implementation, write a Verilog test bench code. This test bench should simulate
the behavior of a processor by:
* Sending the address for memory access at positive edge of clock
* Send next address on next positive edge of clock in case of Cache Hit
* Stall (Keep sending the same address) in case of Cache Miss, till main memory is
accessed (stall for 10 clock cycles)
* Test your system for atleast 10 Memory accesses (Some sequential and some random).
