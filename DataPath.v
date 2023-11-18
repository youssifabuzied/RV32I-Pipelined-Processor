module DataPath(input clk, input rst, input[1:0] ledSel, output reg [15:0] Led_out, input[3:0] ssdSel, output reg [12:0] ssd);
wire sclk;
clockDivider cd( clk, rst,  sclk);
reg [2:0]ctrl_1;
reg [1:0]ctrl_2;
reg ctrl_3;
reg ctrl_4;
reg [7:0]address;
reg [31:0]write_val;
wire [31:0] data_out;
always @(*)begin
if(sclk == 1) begin
ctrl_1 = 3'b0;
ctrl_2 = 2'b0;
ctrl_3 = 1'b1;
ctrl_4 = 1'b0;
address = Q[7:0];
write_val = 32'b0;
instruction = data_out;
mem_out = mem_out;

end
else
begin
ctrl_1 = EX_MEM_Ctrl[16:14];
ctrl_2 = EX_MEM_Ctrl[13:12];
ctrl_3 = EX_MEM_Ctrl[7];
ctrl_4 = EX_MEM_Ctrl[2];
address = EX_MEM_ALU_out[7:0];
write_val = EX_MEM_RegR2;
instruction = instruction;
mem_out = data_out;


end

end
DataMem DM(ctrl_1,ctrl_2, clk,ctrl_3, ctrl_4,address,write_val,data_out );

// IF
wire load;
wire [31:0] Q;
wire [31:0] D;
N_bitRF PC(sclk, rst, ~(end_execution), D, Q);
reg [31:0]instruction;
//InstMem IM(Q[7:2], instruction);
wire[31:0] Adder2_out;
RCA Adder2(4, Q, Adder2_out);

wire end_execution;
assign end_execution =  (IF_ID_instruction[6:2] == 5'b11100 && IF_ID_instruction[20] == 1'b1)? 1'b1 : 1'b0;

//IF/ID
wire [31:0]IF_ID_instruction;
assign IF_ID_instruction= (And_gate && D != Q)? 32'b0000000_00000_00000_000_00000_0110011: instruction;
wire [31:0] IF_ID_PC, IF_ID_Inst;
N_bitRF #(64) IF_ID (~sclk,rst,1'b1,
{Q, IF_ID_instruction},
{IF_ID_PC,IF_ID_Inst} );


// ID

wire [31:0] reg_writedata;
wire [31:0]reg_out1;
wire [31:0]reg_out2;
RegFile RF(clk, rst, IF_ID_Inst[19:15], IF_ID_Inst[24:20], MEM_WB_Rd, reg_writedata, MEM_WB_Ctrl[0], reg_out1, reg_out2);
wire [31:0]imm_out;
rv32_ImmGen IG(IF_ID_Inst, imm_out);
wire Branch;  
wire MemRead; 
wire MemtoReg;
wire [2:0] ALUOp;  
wire MemWrite; 
wire  ALUSrc; 
wire  RegWrite;
wire [2:0]read_part;
wire [1:0] write_part;
wire terminate;
wire A_source;
wire jump;
CU control(IF_ID_Inst[6:2], IF_ID_Inst[14:12], IF_ID_Inst[20], Branch, MemRead,MemtoReg, ALUOp,MemWrite, ALUSrc,RegWrite,
 read_part, write_part, terminate, A_source, jump);
 wire[16:0] flush_out;

nbit_MUX2x1 #(17) MUX_stall(And_gate, {read_part, write_part,terminate, A_source, jump,Branch, MemRead, MemtoReg, ALUOp, MemWrite, ALUSrc, RegWrite},17'b0, flush_out);

//ID/EX

wire [31:0] ID_EX_PC, ID_EX_RegR1, ID_EX_RegR2, ID_EX_Imm;
wire [16:0] ID_EX_Ctrl;
wire [3:0] ID_EX_Func;
wire [4:0] ID_EX_Rs1, ID_EX_Rs2, ID_EX_Rd;
N_bitRF #(164) ID_EX (sclk,rst,1'b1,
{IF_ID_PC, reg_out1, reg_out2, imm_out, flush_out,
 {IF_ID_Inst[14:12], IF_ID_Inst[30]}, IF_ID_Inst[19:15],
IF_ID_Inst[24:20], IF_ID_Inst[11:7]},
{ID_EX_PC,ID_EX_RegR1,ID_EX_RegR2,
ID_EX_Imm,ID_EX_Ctrl, ID_EX_Func,ID_EX_Rs1,ID_EX_Rs2,ID_EX_Rd} );


// EX
wire ForwardA, ForwardB;
Forwarding_Unit FU(ID_EX_Rs1, ID_EX_Rs2, MEM_WB_Rd,  MEM_WB_Ctrl[0], ForwardA, ForwardB);
wire [3:0] ALU_Selection;
ALU_CU ALU_Control(ID_EX_Ctrl[5:3], ID_EX_Func[3:1], ID_EX_Func[0], ALU_Selection);
wire [31:0] ALU_inB;
nbit_MUX2x1 MUX_B(ForwardB, ID_EX_RegR2,  reg_writedata, ALU_inB);
wire [31:0] ALU_in2;
nbit_MUX2x1 MUX1(ID_EX_Ctrl[1], ALU_inB, ID_EX_Imm, ALU_in2);
wire[31:0] ALU_out1;
wire ALU_flag;
wire sf;
wire cf, vf;
wire [31:0]ALU_in1;
wire [31:0]ALU_in1temp;
nbit_MUX2x1 MUX6(ID_EX_Ctrl[10], ID_EX_RegR1, ID_EX_PC, ALU_in1temp);
nbit_MUX2x1 MUX_A(ForwardA, ALU_in1temp, reg_writedata, ALU_in1);
ALU alu(ALU_in1, ALU_in2, ALU_Selection,ALU_out1,ALU_flag,sf, cf, vf);

wire[31:0] Adder1_out;
RCA Adder1(ID_EX_Imm, ID_EX_PC, Adder1_out);


//EX/MEM

wire [31:0] EX_MEM_BranchAddOut, EX_MEM_ALU_out, EX_MEM_RegR2;
wire [3:0] EX_MEM_Func; 
wire [16:0] EX_MEM_Ctrl;
wire [4:0] EX_MEM_Rd;
wire [3:0]EX_MEM_flags;
wire [31:0]EX_MEM_PC;
wire [16:0]ID_EX_Ctrlmiddle;
assign ID_EX_Ctrlmiddle = (And_gate)?16'b0:ID_EX_Ctrl;
wire [3:0] flags;
assign flags = (And_gate)?4'b0:{ALU_flag, sf,cf,vf};

N_bitRF #(158) EX_MEM (~sclk,rst,1'b1,
{Adder1_out, ALU_out1, ALU_inB, ID_EX_Ctrlmiddle, ID_EX_Rd, flags, ID_EX_Func,ID_EX_PC},
{ EX_MEM_BranchAddOut,EX_MEM_ALU_out, EX_MEM_RegR2, EX_MEM_Ctrl, EX_MEM_Rd, EX_MEM_flags, EX_MEM_Func,EX_MEM_PC} );




// MEM

reg [31:0]mem_out;



wire And_gate;
Branching_Unit BU(EX_MEM_Ctrl[8], EX_MEM_Func[3:1], EX_MEM_flags[2], EX_MEM_flags[3],EX_MEM_flags[0], EX_MEM_flags[1],EX_MEM_Ctrl[9],
 And_gate);
wire [31:0] new_pc;
nbit_MUX2x1 MUX3(And_gate, Adder2_out, EX_MEM_BranchAddOut, new_pc);

nbit_MUX2x1 MUX10(EX_MEM_Ctrl[9], new_pc, EX_MEM_ALU_out, D);
wire[31:0] Adder3_out;
RCA Adder3(4, EX_MEM_PC, Adder3_out);

//WB MEM 
wire [31:0] MEM_WB_Mem_out, MEM_WB_ALU_out;
wire [16:0] MEM_WB_Ctrl;
wire [4:0] MEM_WB_Rd;
wire [31:0] MEM_WBPC4;
N_bitRF #(118) MEM_WB (sclk,rst,1'b1,
{mem_out, EX_MEM_ALU_out, EX_MEM_Ctrl, EX_MEM_Rd,Adder3_out},
{MEM_WB_Mem_out, MEM_WB_ALU_out, MEM_WB_Ctrl, MEM_WB_Rd,MEM_WBPC4} );
//WB
wire[31:0] temprd;
nbit_MUX2x1 MUX2(MEM_WB_Ctrl[6], MEM_WB_ALU_out, MEM_WB_Mem_out, temprd);
nbit_MUX2x1 MUX9(MEM_WB_Ctrl[9], temprd, MEM_WBPC4, reg_writedata);
always @(*)begin
case(ledSel) 
2'b00: Led_out = instruction[15:0];
2'b01: Led_out = instruction[31:16];
2'b10: Led_out = {1'b0, Branch, MemRead,MemtoReg, ALUOp,MemWrite, ALUSrc,RegWrite, ALU_Selection, ALU_flag, And_gate};
default: Led_out = D[15:0]; // "0"
endcase
end

always @(*)begin
case(ssdSel) 
4'b0000: ssd = Q[12:0];
4'b0001: ssd = Adder2_out[12:0];
4'b0010: ssd = Adder1_out[12:0];
4'b0011: ssd = D[12:0];
4'b0100: ssd = reg_out1[12:0];
4'b0101: ssd = reg_out2[12:0];
4'b0110: ssd = reg_writedata[12:0];
4'b0111: ssd = imm_out[12:0];
//4'b1000: ssd = shift_out[12:0];
4'b1001: ssd = ALU_in2[12:0];
4'b1010: ssd = ALU_out1[12:0];
4'b1011: ssd = mem_out[12:0];
default: ssd = 0; // "0"
endcase
end



endmodule
