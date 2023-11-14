module DataMem
 (input[2:0]read_part,input [1:0] write_part, input clk, input MemRead, input MemWrite,
 input [7:0] address, input [31:0] data_in, output reg [31:0] data_out);
 reg [31:0] mem [0:63];
wire [5:0]addr;
assign addr = address[7:2];
wire [1:0]addr0;
assign addr0 = address[1:0]; 
 initial begin
 mem[0]=32'd17;
 mem[1]=32'd9;
 mem[2]=32'd25;


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
always@(posedge clk)begin

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