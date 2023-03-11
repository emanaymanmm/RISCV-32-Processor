
module registe_file (input [4:0] read_reg1,input [4:0] read_reg2,
input [4:0] write_reg,input [31:0] data_in ,
output [31:0]reg_1,reg_2,input clk,rst,write_enable);

integer i;
reg [31:0] register_file[31:0];

always@(posedge clk or negedge rst)
begin 
if(!rst)
begin
for(i=0;i<32 ; i=i+1)
begin
register_file[i] <=0;
end
end

else if ( write_enable)
register_file [write_reg] <=data_in;


end
assign  reg_1= register_file[read_reg1];
assign  reg_2= register_file[read_reg2];
endmodule 