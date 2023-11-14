`timescale 1ns / 1ps

module Branching_Unit(
input Branch,
input [2:0] funct3,
input sf, zf, vf, cf,
input jump,
output reg sel
    );
    
always@(*)begin
if(jump) begin
sel = 1;
end
else begin
if (Branch) begin
case(funct3)
3'b000: begin
if (zf == 1)
sel = 1;
else sel = 0;
end //BEQ
3'b001: begin
if (zf == 0)
sel = 1;
else sel = 0;
end //BNE
3'b100: begin
if ( sf != vf)
sel = 1;
else sel = 0;
end //BLT
3'b101:  begin
if (sf == vf)
sel = 1;
else sel = 0;
end //BGE
3'b110:  begin
if (~cf)
sel = 1;
else sel = 0;
end //BLTU
3'b111: begin
if (cf)
sel = 1;
else sel = 0;
end  //BGEU

endcase
end
else sel = 0;
end
end

endmodule
