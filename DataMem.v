module DataMem
 (input[2:0]read_part,input [1:0] write_part, input clk, input MemRead, input MemWrite,
 input [7:0] address, input [31:0] data_in, output reg [31:0] data_out);
 reg [31:0] mem [0:300];
wire [5:0]addr;
assign addr = address[7:2];
wire [1:0]addr0;
assign addr0 = address[1:0]; 
 initial begin
mem[0] = 32'b00000000000000001001010100010111; // auipc x10, 9
mem[1]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0 
mem[2]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0 
mem[3]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0 
mem[4] = 32'b00000000010001010000010110010011; // addi x11, x10, 4
mem[5]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0 
mem[6]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0 
mem[7]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0 
mem[8] = 32'b00000000010001010000010110010011; // addi x11, x10, 4
mem[9]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0 
mem[10]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0 
mem[11]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0 
mem[12] = 32'b00000000000001010000011000110011; //add x12, x10, x0
mem[13]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0 
mem[14]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0 
mem[15]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0 
mem[16] = 32'b00000000100000000000000011101111; //jal ra,8
mem[17]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0 
mem[18]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0 
mem[19]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0 
mem[20] = 32'b00000000000000000000000000001111; // fence 
mem[21]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0 
mem[22]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0 
mem[23]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0 
mem[24] = 32'b00001000101101010000110001100011; //beq x10, x11, 152
mem[25]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0 
mem[26]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0 
mem[27]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0 
mem[28] = 32'b00000000101101010001010001100011 ;//bne x10, x11, 8
mem[29]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0 
mem[30]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0 
mem[31]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0 
mem[32] = 32'b00000000000000000000000001110011; // ecall 
mem[33]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0 
mem[34]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0 
mem[35]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0 
mem[36] = 32'b00000011001000000000001100010011; //addi x6, x0, 50
mem[37]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0 
mem[38]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0 
mem[39]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0 
mem[40] = 32'b00000000001000110001001100010011; //slli x6, x6, 2
mem[41]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0 
mem[42]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0 
mem[43]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0 
mem[44] = 32'b00000000001000000000001110010011 ; //addi x7, x0, 2
mem[45]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0 
mem[46]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0 
mem[47]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0 
mem[48] = 32'b00000000011100000000000000100011;//sb x7, 0(x0)
mem[49]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0 
mem[50]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0 
mem[51]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0 
mem[52] = 32'b00000000101000000001000000100011; //sh x10, 0(x0)
mem[53]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0 
mem[54]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0 
mem[55]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0 
mem[56] = 32'b00000000101000000010000000100011; // sw x10, 0(x0)
mem[57]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0 
mem[58]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0 
mem[59]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0 
mem[60] = 32'b00000000000000000000111000000011; // lb x28, 0(x0)
mem[61]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0 
mem[62]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0 
mem[63]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0 
mem[64] = 32'b00000000000000000001111010000011;//lh x29, 0(x0)
mem[65]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0 
mem[66]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0 
mem[67]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0 
mem[68] = 32'b00000000000000000010111100000011; //lw x30, 0(x0)
mem[69]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0 
mem[70]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0 
mem[71]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0 
mem[72] = 32'b00000000000000000100111110000011; //lbu x31, 0(x0)
mem[73]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0 
mem[74]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0 
mem[75]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0 
mem[76] = 32'b00000000000000000101001100000011; //lhu x6, 0(x0)
mem[77]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0 
mem[78]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0 
mem[79]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0 
mem[80] = 32'b00000110101101100101000001100011; // bge x12, x11, 96
mem[81]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0 
mem[82]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0 
mem[83]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0 
mem[84] = 32'b00000100110001011100111001100011; //blt x11, x12, 92
mem[85]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0 
mem[86]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0 
mem[87]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0 
mem[88] = 32'b00000100101101100111110001100011; //bgeu x12, x11, 88
mem[89]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0 
mem[90]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0 
mem[91]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0 
mem[92] = 32'b00000100110001011110101001100011; //bltu x11, x12, 84
mem[93]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0 
mem[94]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0 
mem[95]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0 
mem[96] = 32'b11111001110001100011001100010011; //sltiu x6, x12, -100
mem[97]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0 
mem[98]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0 
mem[99]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0 
mem[100] = 32'b00000000001100110100111000010011; //xori x28, x6, 3
mem[101]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0 
mem[102]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0 
mem[103]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0 
mem[104] = 32'b00000000010111100110111000010011; //ori x28, x28, 5
mem[105]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0 
mem[106]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0 
mem[107]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0 
mem[108] = 32'b00000000010111100111111000010011; //andi x28, x28, 5
mem[109]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0 
mem[110]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0 
mem[111]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0 
mem[112] = 32'b00000000000111100101111000010011; //srli x28, x28, 1
mem[113]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0 
mem[114]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0 
mem[115]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0 
mem[116] = 32'b00000010100011100000111000010011; //addi x28, x28, 40
mem[117]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0 
mem[118]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0 
mem[119]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0 
mem[120] = 32'b01000000001011100101111000010011; //srai x28, x28, 2
mem[121]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0 
mem[122]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0 
mem[123]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0 
mem[124] = 32'b00000000001100000000001110010011; //addi x7, x0, 3
mem[125]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0 
mem[126]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0 
mem[127]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0 
mem[128] = 32'b01000000011111100000111000110011; // sub x28, x28, x7
mem[129]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0 
mem[130]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0 
mem[131]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0 
mem[132] = 32'b00000001110011100001111000110011; //sll x28, x28, x28
mem[133]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0 
mem[134]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0 
mem[135]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0 
mem[136] = 32'b00000001110011100010111100110011; //slt x30, x28, x28
mem[137]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0 
mem[138]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0 
mem[139]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0 
mem[140] = 32'b00000000011000000000111010010011; //addi x29, x0, 6
mem[141]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0 
mem[142]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0 
mem[143]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0 
mem[144] = 32'b00000001110011101011111100110011; //sltu x30, x29, x28
mem[145]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0 
mem[146]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0 
mem[147]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0 
mem[148] = 32'b00000001110111110100111100110011; //xor x30, x30, x29
mem[149]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0 
mem[150]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0 
mem[151]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0 
mem[152] = 32'b00000000010011110001111100010011; //slli x30, x30, 4
mem[153]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0 
mem[154]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0 
mem[155]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0 
mem[156] = 32'b00000000011111110101111100110011; //srl x30, x30, x7
mem[157]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0 
mem[158]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0 
mem[159]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0 
mem[160] = 32'b01000000011111110101111100110011; //sra x30, x30, x7
mem[161]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0 
mem[162]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0 
mem[163]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0 
mem[164] = 32'b00000000011111110110111100110011; //or x30, x30, x7
mem[165]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0 
mem[166]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0 
mem[167]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0 
mem[168] = 32'b00000001110111110111111100110011; //and x30, x30, x29
mem[169]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0 
mem[170]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0 
mem[171]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0 
mem[172] = 32'b00000000000100000000000001110011;// ebreak
mem[173]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0 
mem[174]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0 
mem[175]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0 
mem[176] = 32'b00000000000000001000000001100111; // jalr x0, 0(x1)
mem[177]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0 
mem[178]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0 
mem[179]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0 


 end 


always@(*)begin
if (MemRead==1)begin
case (read_part) 
0: data_out = mem[addr];
1: begin
case(addr0)
0: data_out = {{16{mem[addr][15]}}, mem[addr][15:0]};
2: data_out = {{16{mem[addr][31]}}, mem[addr][31:16]};
 endcase
 end
2:begin
case(addr0)
0: data_out = {16'b0, mem[addr][15:0]};
2: data_out = {16'b0, mem[addr][31:16]};
 endcase
 end
3:begin
case(addr0)
0: data_out = {{24{mem[addr][7]}}, mem[addr][7:0]};
1: data_out = {{24{mem[addr][15]}}, mem[addr][15:8]};
2: data_out = {{24{mem[addr][23]}}, mem[addr][23:16]};
3: data_out = {{24{mem[addr][31]}}, mem[addr][31:24]};
 endcase
 end 
4:begin
case(addr0)
0: data_out = {24'b0, mem[addr][7:0]};
1: data_out = {24'b0, mem[addr][15:8]};
2: data_out = {24'b0, mem[addr][23:16]};
3: data_out = {24'b0, mem[addr][31:24]};
 endcase
 end  
endcase
end
else
data_out = 0;
end
always@(negedge clk)begin

if (MemWrite==1)begin
case (write_part) 
0: mem[addr] = data_in;
1: begin
case(addr0)
0: mem[addr] = {mem[addr][31:16],data_in[15:0]};
2: mem[addr] = {data_in[15:0],mem[addr][15:0]};
 endcase
 end  
2: begin
case(addr0)
0: mem[addr] = {mem[addr][31:8],data_in[7:0]};
1: mem[addr] = {mem[addr][31:16],data_in[7:0], mem[addr][7:0]};
2: mem[addr] = {mem[addr][31:24],data_in[7:0], mem[addr][15:0]};
3: mem[addr] = {data_in[7:0], mem[addr][23:0]};
 endcase
 end  

endcase
end
end
endmodule