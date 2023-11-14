`timescale 1ns / 1ps



module FA(A, B, cin, S, cout);
input A;
input B;
input cin;
output S;
output cout;
assign {cout, S} = A+B+cin;

endmodule
