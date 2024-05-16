## 开发文档

# 注意

ip core在本地完成，注意保持命名一致

# 当前进度

仅完成了各基础模块的开发和测试，包括DMem, IMem, ALU, Controller, Registers, ImmGen

# 待开发

DataPath等

# 内存大小

关于内存大小的一些计算：
$32×16384 = 524288bit = 65536byte$
$(65536)_{10} = (1,0000,0000,0000,0000)_2$
所以PC寄存器只需要14位即可
Datamemory 同理

# 模块

```riscv
module DMem(
    input clk, 
    input MemRead,MemWrite,
    input [31:0] addr, 
    input [31:0] din,
    output[31:0] dout
    );
```

```riscv
module IMem(
    input clk,
    input [13:0]addr,
    output [31:0] dout
    );
```

```riscv
module ALU(
    input ALUSrc,
    input [1:0] ALUOp,
    input [2:0] funct3,
    input [6:0] funct7,
    input [31:0] ReadData1,
    input [31:0] ReadData2,
    input [31:0] imm32,
    output reg zero,
    output reg [31:0]ALUResult
    );
```

```riscv
module Controller(
    input [31:0] inst,
    output reg Branch,
    output reg MemRead,
    output reg MemtoReg,
    output reg [1:0] ALUOp,
    output reg MemWrite,
    output reg ALUSrc,
    output reg RegWrite
    );
```

```riscv
module ImmGen(
    input [31:0] instruction, //riscv instruction
    output reg [31:0] decoded //decoded immediate
    );
```

```riscv
module Registers(
    input [4:0]Readregister1,
    input [4:0]Readregister2,
    input [4:0]Writeregister,
    input [31:0]Writedata,
    input RegWrite,
    output reg [31:0]Readdata1,
    output reg [31:0]Readdata2
    );
```
