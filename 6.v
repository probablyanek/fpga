module home_automation_rom (
    input  [2:0] addr,
    output reg [3:0] q
);

    always @(*) begin
        case (addr)
            3'b000: q = 4'b0000;
            3'b001: q = 4'b0011;
            3'b010: q = 4'b0101;
            3'b011: q = 4'b0111;
            3'b100: q = 4'b1001;
            3'b101: q = 4'b1011;
            3'b110: q = 4'b1001;
            3'b111: q = 4'b1011;
            default: q = 4'bxxxx;
        endcase
    end

endmodule

module single_port_ram #(
    parameter DATA_WIDTH = 8,
    parameter ADDR_WIDTH = 6
) (
    input  wire                      clk,
    input  wire                      we,
    input  wire [ADDR_WIDTH-1:0]     addr,
    input  wire [DATA_WIDTH-1:0]     din,
    output reg  [DATA_WIDTH-1:0]     dout
);

    localparam DEPTH = 1 << ADDR_WIDTH;

    reg [DATA_WIDTH-1:0] mem [0:DEPTH-1];

    always @(posedge clk) begin
        if (we) begin
            mem[addr] <= din;
        end
        dout <= mem[addr];
    end

endmodule



module tb_single_port_ram;

    localparam DATA_WIDTH = 8;
    localparam ADDR_WIDTH = 4;   
    localparam DEPTH = 1 << ADDR_WIDTH;

    reg clk;
    reg we;
    reg [ADDR_WIDTH-1:0] addr;
    reg [DATA_WIDTH-1:0] din;
    wire [DATA_WIDTH-1:0] dout;

    single_port_ram #(
        .DATA_WIDTH(DATA_WIDTH),
        .ADDR_WIDTH(ADDR_WIDTH)
    ) uut (
        .clk(clk),
        .we(we),
        .addr(addr),
        .din(din),
        .dout(dout)
    );

    always #5 clk = ~clk;

    initial begin
        $dumpfile("single_port_ram_tb.vcd");
        $dumpvars(0, tb_single_port_ram);

        clk = 0;
        we  = 0;
        addr = 0;
        din  = 0;

        #10 we = 1; addr = 0; din = 8'hAA;
        #10 we = 1; addr = 1; din = 8'h55;
        #10 we = 1; addr = 2; din = 8'h0F;
        #10 we = 1; addr = 3; din = 8'hF0;

        #10 we = 0; addr = 0;
        #10 addr = 1;
        #10 addr = 2;
        #10 addr = 3;

        #10 we = 1; addr = 1; din = 8'h99;
        #10 we = 0; addr = 1;

        #20 $finish;
    end

endmodule

