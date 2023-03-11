module top_module(input inclk, rst,output tx_serial);

wire [31:0] pc;
wire [31:0]pc_next,instr;
wire [31:0]pcTarget,pcPlus4;
wire [31:0 ]ImmExt;
wire load;

assign load=(instr[6:0]?1:0);
assign pcTarget=pc+ImmExt;
assign pcPlus4= pc+ 'd4;

wire [31:0] reg_1,reg_2,Result ;
wire  ResultSrc,MemWrite,ALUSrc,RegWrite,PCSrc;
wire [2:0] ALUControl;
wire [1:0] ImmSrc;

wire [31:0]RD;
wire [31:0] srcb,AluResult;
wire zf,sf;
wire clk,clk1;


PLL PLL_TOP (.inclk0(inclk),.c0(clk1),.c1(clk));

UartplusBuffer UartplusBuffer_top(
   .clk_cpu(clk),.clk_uart(clk1),.areset_cpu(rst),.areset_uart(rst),.WD(MemWrite),
   .data(reg_2[7:0]),
   .tx_serial(tx_serial));

mux pc_mux(.In2(pcTarget),.In1(pcPlus4),.s(PCSrc),.out(pc_next));

sign_extent pc_sign_extent(.instr(instr[31:7]),.ImmSrc(ImmSrc),.ImmExt(ImmExt));


pc_register top_pc(.pc_next(pc_next),.clk(clk),.rst(rst),.load(load),.pc(pc));


instr_mem top_instr_mem (.pc(pc[31:0]), .instr(instr));


registe_file top_RF (.read_reg1(instr[19:15]),
.read_reg2(instr[24:20]),.write_reg (instr[11:7]),
.data_in(Result),.reg_1(reg_1),.reg_2(reg_2),
.clk(clk),.rst(rst),.write_enable(RegWrite));


control_unit top_control_unit(.op(instr[6:0])
,.funct3( instr[14:12])
,.funct7 (instr[30]),. ResultSrc( ResultSrc),
.MemWrite(MemWrite),.ALUSrc(ALUSrc),.ImmSrc(ImmSrc),
.RegWrite(RegWrite),
.ALUControl(ALUControl),
.PCSrc(PCSrc),.zero(zf),.sign_flag(sf));

mux top_alu_mux(.In2(ImmExt),.In1(reg_2),.s(ALUSrc),.out(srcb));

ALU top_ALU(.a(reg_1),.b(srcb),.sel(ALUControl)
,.c(AluResult),.zf(zf),.sf(sf));


mux top_mem_mux(.In2(RD),.In1(AluResult),.s(ResultSrc),.out(Result));
memory top_Dmem (.A(AluResult),.data_in(reg_2),.RD(RD),.clk(clk),.write_enable(MemWrite));



endmodule
