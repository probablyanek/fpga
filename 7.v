module fsm_moore_non_overlap_1011 (
    input  x,
    input  clk,
    input  rst,
    output reg y
);

    reg [2:0] present_state, next_state;

    parameter A = 3'b000,
              B = 3'b001,
              C = 3'b010,
              D = 3'b011,
              E = 3'b100;

    always @(posedge clk or negedge rst) begin
        if (!rst)
            present_state <= A;
        else
            present_state <= next_state;
    end

    always @(present_state or x) begin
        case (present_state)
            A: begin
                if (x == 1'b1)
                    next_state = B;
                else
                    next_state = A;
            end
            B: begin
                if (x == 1'b0)
                    next_state = C;
                else
                    next_state = B;
            end
            C: begin
                if (x == 1'b1)
                    next_state = D;
                else
                    next_state = A;
            end
            D: begin
                if (x == 1'b1)
                    next_state = E;
                else
                    next_state = C;
            end
            E: begin
                if (x == 1'b1)
                    next_state = B;
                else
                    next_state = A;
            end
            default: next_state = A;
        endcase
    end

    always @(present_state) begin
        case (present_state)
            A: y = 1'b0;
            B: y = 1'b0;
            C: y = 1'b0;
            D: y = 1'b0;
            E: y = 1'b1;
            default: y = 1'b0;
        endcase
    end

endmodule

module tb_fsm_moore_non_overlap_1011;

    reg clk, rst, x;
    wire y;

    fsm_moore_non_overlap_1011 uut (
        .x(x),
        .clk(clk),
        .rst(rst),
        .y(y)
    );

    always #5 clk = ~clk;

    initial begin
        $dumpfile("fsm_moore_non_overlap_1011.vcd");
        $dumpvars(0, tb_fsm_moore_non_overlap_1011);

        $monitor("Time=%0t | rst=%b | x=%b | y=%b", $time, rst, x, y);

        clk = 0;
        rst = 0;
        x   = 0;

        #12 rst = 1;

        #10 x = 1;
        #10 x = 0;
        #10 x = 1;
        #10 x = 1;

        #10 x = 1;
        #10 x = 0;
        #10 x = 1;
        #10 x = 1;

        #10 x = 0;
        #10 x = 0;
        #10 x = 1;
        #10 x = 1;

        #20 $finish;
    end

endmodule
