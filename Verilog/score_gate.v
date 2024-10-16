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

// NOT gates for input inversions
not (d1_not, d1);
not (d2_not, d2);
not (d3_not, d3);
not (d4_not, d4);

// AND gates for scoring
and (d1_d2, d1, d2);
and (d1_d3, d1, d3);
and (d1_d4, d1, d4);
and (d2_d3, d2, d3);
and (d2_d4, d2, d4);
and (d3_d4, d3, d4);

// OR gates for scoring
or (score[0], d1, d1_d2, d1_d3, d1_d4);
or (score[1], d2, d1_d2, d2_d3, d2_d4);
or (score[2], d3, d1_d3, d2_d3, d3_d4);
or (score[3], d4, d1_d4, d2_d4, d3_d4);

endmodule
`endif