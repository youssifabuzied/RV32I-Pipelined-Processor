module DataMem
 (input[2:0]read_part,input [1:0] write_part, input clk, input MemRead, input MemWrite,
 input [7:0] address, input [31:0] data_in, output reg [31:0] data_out);
 reg [31:0] mem [0:300];
wire [5:0]addr;
assign addr = address[7:2];
wire [1:0]addr0;
assign addr0 = address[1:0]; 
 initial begin
mem[0]=32'h05802183 ; //lw x3, 48(x0) 
mem[1]=32'h05402103 ; //lw x2, 44(x0)  
mem[2]=32'h05002083 ; //lw x1, 40(x0) 

mem[3]=32'b0000000_00010_00001_110_00100_0110011 ; //or x4, x1, x2 
mem[4]=32'h00100073; //beq x4, x3, 12
mem[5]=32'b0000000_00010_00001_000_00011_0110011 ; //add x3, x1, x2 
mem[6] = 32'b0000000_00000_00000_000_00000_0110011;
mem[7]=32'b0000000_00010_00011_000_00101_0110011 ; //add x5, x3, x2 
mem[8]=32'h04502D23; //sw x5, 90(x0) 
mem[9]=32'h05A02303 ; //lw x6, 52(x0) 
mem[10]=32'b0000000_00001_00110_111_00111_0110011 ; //and x7, x6, x1 
mem[11]=32'b0100000_00010_00001_000_01000_0110011 ; //sub x8, x1, x2 
mem[12]=32'b0000000_00010_00001_000_00000_0110011 ; //add x0, x1, x2
mem[13]=32'b0000000_00001_00000_000_01001_0110011 ; //add x9, x0, x1
mem[14] = 32'b0000000_00000_00000_000_00000_0110011;
mem[20] = 32'd17;
mem[21]= 32'd9;
mem[22]= 32'd25;
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