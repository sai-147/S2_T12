`ifndef SCORE_V
`define SCORE_V
module score_calculator(
    input wire d1,     // Input for score 1
    input wire d2,     // Input for score 2
    input wire d3,     // Input for score 3
    input wire d4,     // Input for score 4
    //input wire score_btn, // Button to score the inputs
    output reg [3:0] score // 4-bit output for the final score
);
wire d1_d2, d1_d3, d1_d4, d2_d3, d2_d4, d3_d4;
wire d1_not, d2_not, d3_not, d4_not;


always @(*) begin
    // Initialize score to zero
    score = 4'b0000;
    
    // Check if the score button is pressed
    begin
        // Calculate the sum based on active inputs
        if (d1) score = score + 4'b0001; // Add 1 for d1
        if (d2) score = score + 4'b0010; // Add 2 for d2
        if (d3) score = score + 4'b0011; // Add 3 for d3
        if (d4) score = score + 4'b0100; // Add 4 for d4
    end
end

endmodule
`endif