module memory ( input [31:0] A,input [31:0] data_in ,
output [31:0]RD ,input clk,write_enable);

integer i;
reg [31:0] mem [0:63];
initial begin
for (i=0; i<=63; i=i+1)
    mem[i] = 0;
end

always @(posedge clk)
begin
if(write_enable)
mem[A]<=data_in;
end

assign RD=mem[A];

endmodule 




