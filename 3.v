module EXP4(input [2:0] A, input [2:0] B, output wire [5:0]  s );

wire w1, w2, w3, w4, w5, w6, w7;
wire [7:0] p;

assign s[0] = A[0] & B[0];
assign p[0] = A[1] & B[0];
assign p[1] = A[0] & B[1];
assign p[2] = A[2] & B[0];
assign p[3] = A[1] & B[1];
assign p[4] = A[0] & B[2];
assign p[5] = A[2] & B[1];
assign p[6] = A[1] & B[2];
assign p[7] = A[2] & B[2];


FA u1(p[0], p[1], 0, s[1], w1);
FA u2(p[2], p[3], p[4], w2, w3);
FA u3(w2, w1, 0, s[2], w4);
FA u4(p[5], p[6], w3, w6, w5);
FA u5(w6, w4, 0, s[3], w7);
FA u6(p[7], w5, w7, s[4], s[5]);

endmodule


module FA(input A, input B, input C, output wire sum, output wire carry);
assign carry = (A&B) | (B&C) | (C&A);
assign sum = A^B^C;
endmodule