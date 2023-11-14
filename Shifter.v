`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/29/2023 05:41:38 PM
// Design Name: 
// Module Name: Shifter
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


module Shifter( input wire signed  [31:0] A , input [4:0] shamt , input [1:0] type , output reg [31:0] out );

//`define     ALU_SRL         4'b10_00
//`define     ALU_SRA         4'b10_10
//`define     ALU_SLL         4'b10_01
always@(*)
   begin
       case (type)
        2'b00 : out =  A >> shamt;
        2'b01 : out = A << shamt;
        2'b10 : out = A>>> shamt;
        endcase
    end
endmodule
