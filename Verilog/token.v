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

    integer i;

    always @(*) begin
        // Initialize all tokens to 0
        token1 = 4'b0000;
        token2 = 4'b0000;
        token3 = 4'b0000;
        token4 = 4'b0000;
        token5 = 4'b0000;
        token6 = 4'b0000;
        token7 = 4'b0000;

        // Generate tokens based on the input value (limit to 7)
        for (i = 0; i < value && i < 7; i = i + 1) begin
            case (i)
                0: token1 = i + 1;
                1: token2 = i + 1;
                2: token3 = i + 1;
                3: token4 = i + 1;
                4: token5 = i + 1;
                5: token6 = i + 1;
                6: token7 = i + 1;
                default: ; 
            endcase
        end
    end

endmodule
`endif
