module vending_machine_with_display (
    input clk,
    input rst,
    input in_5,
    input in_10,
    output dispense,
    output wire [6:0] seg_tens,
    output wire [6:0] seg_ones
);

    localparam S_0        = 3'b000;
    localparam S_5        = 3'b001;
    localparam S_10       = 3'b010;
    localparam S_15       = 3'b011;
    localparam S_DISPENSE = 3'b100;

    reg [2:0] current_state;
    reg [2:0] next_state;

    reg [3:0] bcd_tens;
    reg [3:0] bcd_ones;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            current_state <= S_0;
        end else begin
            current_state <= next_state;
        end
    end

    always @(*) begin
        next_state = current_state;
        case (current_state)
            S_0: begin
                if (in_5)       next_state = S_5;
                else if (in_10) next_state = S_10;
            end
            S_5: begin
                if (in_5)       next_state = S_10;
                else if (in_10) next_state = S_15;
            end
            S_10: begin
                if (in_5)       next_state = S_15;
                else if (in_10) next_state = S_DISPENSE;
            end
            S_15: begin
                if (in_5 || in_10) next_state = S_DISPENSE;
            end
            S_DISPENSE: begin
                next_state = S_0;
            end
            default: begin
                next_state = S_0;
            end
        endcase
    end

    assign dispense = (current_state == S_DISPENSE);

    always @(*) begin
        case (current_state)
            S_0: begin
                bcd_tens = 4'd0;
                bcd_ones = 4'd0;
            end
            S_5: begin
                bcd_tens = 4'd0;
                bcd_ones = 4'd5;
            end
            S_10: begin
                bcd_tens = 4'd1;
                bcd_ones = 4'd0;
            end
            S_15: begin
                bcd_tens = 4'd1;
                bcd_ones = 4'd5;
            end
            S_DISPENSE: begin
                bcd_tens = 4'd0;
                bcd_ones = 4'd0;
            end
            default: begin
                bcd_tens = 4'd0;
                bcd_ones = 4'd0;
            end
        endcase
    end

    bcd_to_7seg decoder_tens (
        .num(bcd_tens),
        .seg(seg_tens)
    );

    bcd_to_7seg decoder_ones (
        .num(bcd_ones),
        .seg(seg_ones)
    );

endmodule

module bcd_to_7seg(
    input [3:0] num,
    output reg [6:0] seg
);
    always @ (*) begin
        case(num)
            4'd0: seg = 7'b1000000;
            4'd1: seg = 7'b1111001;
            4'd2: seg = 7'b0100100;
            4'd3: seg = 7'b0110000;
            4'd4: seg = 7'b0011001;
            4'd5: seg = 7'b0010010;
            4'd6: seg = 7'b0000010;
            4'd7: seg = 7'b1111000;
            4'd8: seg = 7'b0000000;
            4'd9: seg = 7'b0010000;
            default: seg = 7'b1111111;
        endcase
    end
endmodule
