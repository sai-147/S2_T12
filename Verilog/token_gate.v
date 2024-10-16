`ifndef TOKEN_V
`define TOKEN_V

module token (
    input  [3:0] value, 
    output reg [3:0] token1,
    output reg [3:0] token2,
    output reg [3:0] token3,
    output reg [3:0] token4,
    output reg [3:0] token5,
    output reg [3:0] token6,
    output reg [3:0] token7
);

    // Gate-level implementation

    // 4-bit counter using JK flip-flops
    wire clk, reset;
    assign clk = 1'b1; // Clock signal (always high)
    assign reset = 1'b0; // Reset signal (always low)
    wire [3:0] count;
    
    jk_ff_gate jk_ff0 (clk, reset, 1'b1, 1'b1, count[0]);
    jk_ff_gate jk_ff1 (clk, reset, count[0], 1'b1, count[1]);
    jk_ff_gate jk_ff2 (clk, reset, count[1], count[0], count[2]);
    jk_ff_gate jk_ff3 (clk, reset, count[2], count[1], count[3]);

    // 7-to-1 multiplexer using basic gates
    wire token_out0, token_out1, token_out2, token_out3;
    wire token_out4, token_out5, token_out6;

    and (token_out0, count[2], count[1], count[0]); // count = 000
    and (token_out1, count[2], count[1], not(count[0])); // count = 001
    and (token_out2, count[2], not(count[1]), count[0]); // count = 010
    and (token_out3, count[2], not(count[1]), not(count[0])); // count = 011
    and (token_out4, not(count[2]), count[1], count[0]); // count = 100
    and (token_out5, not(count[2]), count[1], not(count[0])); // count = 101
    and (token_out6, not(count[2]), not(count[1]), count[0]); // count = 110

    wire token_out_combined;
    or (token_out_combined, token_out0, token_out1, token_out2, token_out3, token_out4, token_out5, token_out6);

    // Assign token outputs based on the selected token
    always @(*) begin
        token1 = 4'b0000;
        token2 = 4'b0000;
        token3 = 4'b0000;
        token4 = 4'b0000;
        token5 = 4'b0000;
        token6 = 4'b0000;
        token7 = 4'b0000;

        case (count)
            4'b0000: token1 = token_out_combined ? value : 4'b0000; // Assign value if token condition met
            4'b0001: token2 = token_out_combined ? value : 4'b0000;
            4'b0010: token3 = token_out_combined ? value : 4'b0000;
            4'b0011: token4 = token_out_combined ? value : 4'b0000;
            4'b0100: token5 = token_out_combined ? value : 4'b0000;
            4'b0101: token6 = token_out_combined ? value : 4'b0000;
            4'b0110: token7 = token_out_combined ? value : 4'b0000;
        endcase
    end

endmodule

// JK flip-flop using logic gates
module jk_ff_gate (
    input  clk,
    input  reset,
    input  j,
    input  k,
    output reg q
);

    wire s, r;

    // Logic for setting and resetting
    and (s, j, not(q));
    and (r, k, q);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 1'b0;
        end else begin
            or (q, s, r);
        end
    end

endmodule

`endif
