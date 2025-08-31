module EXP5(input [3:0] A, input [3:0] B, output wire  GT, output wire EQ, output wire LS);

function [2:0] compout(input [3:0] A, input [3:0] B);

begin
if (A>B)
	compout = 3'b100;
else
begin
	if (A==B)
		compout = 3'b010;
	else
		compout = 3'b001;
end
end
endfunction

wire [2:0] S;

assign S = compout(A, B);
assign GT = S[0];
assign EQ = S[1];
assign LS = S[2];

endmodule

