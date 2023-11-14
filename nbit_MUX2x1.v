module nbit_MUX2x1 #(parameter N=32)(input sel, input [N-1:0]A, input[N-1:0]B, output [N-1:0] out  );
genvar i;
generate 
for (i=0; i<N; i=i+1) begin
MUX2x1 m(A[i], B[i], sel, out[i]);
end
endgenerate
endmodule
