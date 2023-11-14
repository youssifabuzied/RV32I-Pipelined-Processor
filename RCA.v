`timescale 1ns / 1ps



module RCA#( parameter n = 32)(input[n-1:0]A, input[n-1:0]B, output[n-1:0]sum);
wire[n:0] carry;
assign carry[0] = 0;
genvar i;
generate
for(i = 0; i < n; i= i+1) begin 
FA inst(.A(A[i]), .B(B[i]), .cin(carry[i]), .S(sum[i]), .cout(carry[i+1])); 
end
endgenerate
//assign sum[n] = carry[n];
endmodule
