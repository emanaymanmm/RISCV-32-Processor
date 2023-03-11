module control_unit (input [6:0]op,input [2:0]funct3,input funct7,input zero,sign_flag,
output reg ResultSrc,MemWrite,ALUSrc,RegWrite,output reg [1:0] ImmSrc,output reg [2:0] ALUControl ,output reg PCSrc);
reg[1:0] ALUOP;
reg branch;
always@(*)
begin 
case(op)
7'b0000011:begin
RegWrite=1;
ImmSrc=2'b00;
ALUSrc=1;
MemWrite=0;
ResultSrc=1;
ALUOP=2'b00;
branch=0;
             end

7'b0100011:begin
RegWrite=0;
ImmSrc=2'b01;
ALUSrc=1;
MemWrite=1;
ALUOP=2'b00;
branch=0;
            end

7'b0110011:begin
RegWrite=1;
ALUSrc=0;
MemWrite=0;
ResultSrc=0;
ALUOP=2'b10;
branch=0;
             end

7'b0010011:begin
RegWrite=1;
ImmSrc=2'b00;
ALUSrc=1;
MemWrite=0;
ResultSrc=0;
ALUOP=2'b10;
branch=0;
             end

7'b1100011:begin
RegWrite=0;
ImmSrc=2'b10;
ALUSrc=0;
MemWrite=0;
ALUOP=2'b01;
branch=1;
           end

default : begin
RegWrite=0;
ImmSrc=2'b00;
ALUSrc=0;
MemWrite=0;
ResultSrc=0;
ALUOP=2'b00;
branch=0;
          end 
endcase 

case(funct3)
3'b000: PCSrc=branch &(zero);
3'b001: PCSrc=branch &(~zero);
3'b100: PCSrc=branch & sign_flag;
default: PCSrc = 0 ;
endcase

case (ALUOP)
2'b00: ALUControl=3'b000;
2'b01: ALUControl=3'b010;
2'b10: case(funct3)
       3'b000: case({op[5],funct7})
               2'b11:ALUControl=3'b010;
               default:ALUControl=3'b000;
                endcase
       3'b001:ALUControl=3'b001;
       3'b100:ALUControl=3'b100;
       3'b101:ALUControl=3'b101;
       3'b110:ALUControl=3'b110;
       3'b111:ALUControl=3'b111;
       default:ALUControl=3'b000;
       endcase
default:ALUControl=3'b000;
endcase

end 
endmodule

