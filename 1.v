module EXP1(input [3:0] A, input [3:0] B, output [4:0] sum);
wire w1, w2, w3;

FA u1(A[0], B[0],1'b0, sum[0], w1);
FA u2(A[1], B[1],w1, sum[1], w2);
FA u3(A[2], B[2],w2, sum[2], w3);
FA u4(A[3], B[3],w3, sum[3], sum[4]);

endmodule

module FA(input A, input B, input Cin ,output S, output C);

assign C = (A&B) | (B&Cin) | (Cin&A);
assign S = A^B^Cin;

endmodule