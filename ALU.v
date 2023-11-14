module ALU#(parameter N = 32)(  input [N-1:0]A, input [N-1:0] B, input[3:0]sel,output reg [N-1:0]out, output zero, output sf, output cf, output vf );
wire [N-1:0]Andout;
wire [N-1:0]Orout;
wire [N-1:0] XORout;
wire [N-1:0] SLLout;
wire [N-1:0]SRLout;
wire [N-1:0] SRAout;
Shifter sh1(A, B[4:0], 2'b01, SLLout);
Shifter sh2(A, B[4:0], 2'b00, SRLout);
Shifter sh3(A, B[4:0], 2'b10, SRAout);



//this for SLTU 
wire [N-1:0] TempSub2;
wire [N-1:0] Btemp2;
wire [N-1:0] Bmid;
wire [N-1:0] Amid;
assign Bmid = (B[31] == 1)? ~B+1: B;
assign Amid = (A[31] == 1)? ~A+1: A;
assign Btemp2 = ~Bmid+1;
RCA rctemp2(Amid, Btemp2, TempSub2); 
// Unsigned Branches

wire [32:0]Acopy;
wire [32:0]Bcopy;
assign Acopy = {1'b0,A};
assign Bcopy = {1'b0, B};

assign Andout = A&B;
assign Orout = A|B;
assign XORout = A^B;
wire[N-1:0] sumout;
wire zeros = 32'b0;
wire [N-1:0]Bin;
assign Bin = (sel[2] == 1)? ~B+1: B; 

 wire [31:0] add, sub, op_b;
 
    
    assign op_b = (~B);
    
    assign {cf, add} = (sel[2] == 1) ? (A + op_b + 1'b1) : (A + B);
    
    assign zero = (add == 0);
    assign sf = add[31];
    assign vf = (A[31] ^ (op_b[31]) ^ add[31] ^ cf);
    

RCA rc(A, Bin, sumout);
always @(*) begin
case(sel) 
4'b0010: out = sumout;
4'b0110: out = sumout;
4'b0000: out = Andout;
4'b0001: out = Orout;
4'b0011: out = XORout;
4'b1000: out = B;
4'b1001: out = SLLout;
4'b1010: out = SRLout;
4'b1011: out = SRAout;
4'b1100:out ={31'b0,(sf != vf)}; 
4'b1101: out = {31'b0,(~cf)};


default: 
out = zeros;
endcase
end

assign zero = (add == 0)?1:0;
assign sf = (add[N-1]);
endmodule
