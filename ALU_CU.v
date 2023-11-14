`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/27/2023 12:31:11 PM
// Design Name: 
// Module Name: ALU_CU
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module ALU_CU(input [2:0] ALUOp, input [2:0]inst1, input inst2, output reg [3:0] ALU_Selection);
always @(*)begin
case(ALUOp)
3'b000: ALU_Selection = 4'b0010;
3'b001: begin
case(inst1)
3'b000: ALU_Selection = 4'b0110; //BEQ
3'b001: ALU_Selection = 4'b0110; //BNE
3'b100: ALU_Selection = 4'b0110; //BLT
3'b101: ALU_Selection = 4'b0110; //BGE
3'b110: ALU_Selection = 4'b0110; //BLTU
3'b111: ALU_Selection = 4'b0110; //BGEU

endcase
end
// R Format
3'b010: begin
case(inst1)
3'b000:begin
case(inst2)
0: ALU_Selection = 4'b0010;
1: ALU_Selection = 4'b0110;
endcase
end
3'b111:begin
case(inst2)
0: ALU_Selection = 4'b0000;
1: ALU_Selection = 4'b1111;
endcase
end
3'b110:begin
case(inst2)
0: ALU_Selection = 4'b0001;
1: ALU_Selection = 4'b1111;
endcase
end
3'b100: ALU_Selection = 4'b0011; // XOR
3'b001: ALU_Selection = 4'b1001; // SLL
3'b101:begin
case(inst2)
0:ALU_Selection = 4'b1010; //SRL
1:ALU_Selection = 4'b1011; // SRA
endcase
end

3'b010: ALU_Selection = 4'b1100;
3'b011: ALU_Selection = 4'b1101;
endcase
end


// I Format
3'b011: begin
case(inst1)
3'b000:begin
ALU_Selection = 4'b0010;
end
3'b111:begin
ALU_Selection = 4'b0000;
end
3'b110:begin
ALU_Selection = 4'b0001;
end
3'b100: ALU_Selection = 4'b0011; // XOR\
3'b001: ALU_Selection = 4'b1001; // SLLI

3'b101:begin
case(inst2)
0:ALU_Selection = 4'b1010; //SRLI
1:ALU_Selection = 4'b1011; // SRAI
endcase
end
3'b010: ALU_Selection = 4'b1100;
3'b011: ALU_Selection = 4'b1101;

endcase
end


// LUI 
3'b100: ALU_Selection = 4'b1000;


default: ALU_Selection = 4'b1111;
endcase
end


endmodule 
