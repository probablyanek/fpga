module EXP2(input [3:0] num, output reg [6:0] seg);

always @ (*)
begin
case(num)
	0: seg = 7'd64;
	1: seg = 7'd121; 
	2: seg = 7'd36;
	3: seg = 7'd48;
	4: seg = 7'd25;
	5: seg = 7'd18;
	4'd6: seg = 7'd2;
	4'd7: seg = 7'd120;
	4'd8: seg = 7'd0;
	4'd9: seg = 7'd16; 
endcase
end
endmodule