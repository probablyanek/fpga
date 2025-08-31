
module EXP3(input clk, input rst, output wire [3:0] q);
wire w;


slowcounter u1(.clk(clk), .rst(rst), .slowclk(w));
counter u2(.clk(w), .rst(rst), .q(q));
endmodule



module counter(input clk, input rst, output reg [3:0] q);
always @ (posedge clk or negedge rst)
begin
if (!rst)
  q = 4'b0;
else
  q = q+1;
end
endmodule



module slowcounter(input clk, input rst, output wire slowclk);
reg [3:0] q;
always @ (posedge clk or negedge rst)
begin
if (!rst)
  q = 4'b0;
else
  q = q+1;
end
assign slowclk = q[3];
endmodule



