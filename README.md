# RISCV-32-Processor

### Modules

- Program Counter.
- Control Unit 
- Register File
- ALU
- Sign Extend
- Data Memory
- Instruction Memory

### Tested Programs

The processor was tested by two methods :
First, a machine code of Fibonacci series numbers program (Fibonacci_Machine_code.txt)that is generated and stored in the instructions memory. 
Second,It was tested on Cyclone® IV FPGA device by using UART TX to transmit data ( sequence of numbers from 1 to 255 ) 
generated by RISCV processor Then receiving it using Bluetooth module HC-05.
