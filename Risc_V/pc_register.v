module pc_register (input [31:0]pc_next,input clk,input rst,input load,output reg[31:0]pc );


always @(posedge clk or negedge rst)
begin 

if (!rst)
pc<='b0;
else if (load)
pc<=pc_next;

end 



endmodule 
