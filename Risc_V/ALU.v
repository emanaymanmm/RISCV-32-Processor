module ALU(
   input [31:0]a,b,
   input [2:0]sel,
   output reg [31:0]c,
   output reg  zf ,sf);

always@ (*) 
begin
case (sel)
3'b000 : c=a+b;               
3'b001 : c=(a<<b);
3'b010 : c= (a-b);
3'b100 : c= (a ^ b);
3'b101 : c= (a >> b);
3'b110 : c= (a | b) ;
3'b111 : c= (a & b);

default: c= 32'b0;

endcase
 zf= ~(|c); 
 sf= c[31];
end

endmodule
