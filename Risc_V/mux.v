module mux(input s,input [31:0]In1,input [31:0]In2,output  [31:0]out);

assign out=s?In2:In1;


endmodule
