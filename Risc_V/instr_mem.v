module instr_mem(input [31:0]pc ,output  [31:0] instr);

reg [31:0] mem [0:63];
integer i;
initial 
begin 
for (i=0; i<=63; i=i+1)
    mem[i] = 0;
$readmemh ("instructions_hexx.txt",mem);

end 


assign instr=mem[pc[31:2]]; 

 

endmodule
