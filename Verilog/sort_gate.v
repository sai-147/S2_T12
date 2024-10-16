module comparator_4bit (
    input [3:0] a,
    input [3:0] b,
    output gt,   // a > b
    output eq    // a == b
);
    wire xnor3, xnor2, xnor1, xnor0;
    wire a_gt_b3, a_gt_b2, a_gt_b1, a_gt_b0;

    // Equality check for each bit using XNOR
    xnor (xnor3, a[3], b[3]);
    xnor (xnor2, a[2], b[2]);
    xnor (xnor1, a[1], b[1]);
    xnor (xnor0, a[0], b[0]);

    // a == b (all bits must be equal)
    and (eq, xnor3, xnor2, xnor1, xnor0);

    // Greater than logic using AND and OR gates
    and (a_gt_b3, a[3], ~b[3]);
    and (a_gt_b2, xnor3, a[2], ~b[2]);
    and (a_gt_b1, xnor3, xnor2, a[1], ~b[1]);
    and (a_gt_b0, xnor3, xnor2, xnor1, a[0], ~b[0]);

    or (gt, a_gt_b3, a_gt_b2, a_gt_b1, a_gt_b0);

endmodule
module mux_8bit (
    input [7:0] a,
    input [7:0] b,
    input sel,       // 1 = swap, 0 = no swap
    output [7:0] out_a,
    output [7:0] out_b
);
    wire not_sel;
    wire [7:0] and_a, and_b;

    // Invert the select signal
    not (not_sel, sel);

    // Conditional swapping using AND and OR gates
    // If sel = 1, swap; if sel = 0, keep original
    and (and_a[0], a[0], not_sel);
    and (and_b[0], b[0], sel);
    or (out_a[0], and_a[0], and_b[0]);

    and (and_a[1], a[1], not_sel);
    and (and_b[1], b[1], sel);
    or (out_a[1], and_a[1], and_b[1]);

    and (and_a[2], a[2], not_sel);
    and (and_b[2], b[2], sel);
    or (out_a[2], and_a[2], and_b[2]);

    and (and_a[3], a[3], not_sel);
    and (and_b[3], b[3], sel);
    or (out_a[3], and_a[3], and_b[3]);

    and (and_a[4], a[4], not_sel);
    and (and_b[4], b[4], sel);
    or (out_a[4], and_a[4], and_b[4]);

    and (and_a[5], a[5], not_sel);
    and (and_b[5], b[5], sel);
    or (out_a[5], and_a[5], and_b[5]);

    and (and_a[6], a[6], not_sel);
    and (and_b[6], b[6], sel);
    or (out_a[6], and_a[6], and_b[6]);

    and (and_a[7], a[7], not_sel);
    and (and_b[7], b[7], sel);
    or (out_a[7], and_a[7], and_b[7]);

    // For b output (opposite of a)
    and (and_a[0], a[0], sel);
    and (and_b[0], b[0], not_sel);
    or (out_b[0], and_a[0], and_b[0]);

    and (and_a[1], a[1], sel);
    and (and_b[1], b[1], not_sel);
    or (out_b[1], and_a[1], and_b[1]);

    and (and_a[2], a[2], sel);
    and (and_b[2], b[2], not_sel);
    or (out_b[2], and_a[2], and_b[2]);

    and (and_a[3], a[3], sel);
    and (and_b[3], b[3], not_sel);
    or (out_b[3], and_a[3], and_b[3]);

    and (and_a[4], a[4], sel);
    and (and_b[4], b[4], not_sel);
    or (out_b[4], and_a[4], and_b[4]);

    and (and_a[5], a[5], sel);
    and (and_b[5], not_sel, b[5]);
    or (out_b[5], and_a[5], and_b[5]);

    and (and_a[6], a[6], sel);
    and (and_b[6], b[6], not_sel);
    or (out_b[6], and_a[6], and_b[6]);

    and (and_a[7], a[7], sel);
    and (and_b[7], b[7], not_sel);
    or (out_b[7], and_a[7], and_b[7]);

endmodule

module comparator_8bit (
    input [7:0] a,
    input [7:0] b,
    output swap
);

    wire gt_last4, eq_last4, gt_first4;

    // Compare last 4 bits (bitwise comparator logic)
    comparator_4bit cmp_last4 (
        .a(a[3:0]),
        .b(b[3:0]),
        .gt(gt_last4),
        .eq(eq_last4)
    );

    // Compare first 4 bits
    comparator_4bit cmp_first4 (
        .a(a[7:4]),
        .b(b[7:4]),
        .gt(gt_first4),
        .eq()   // No need for equality of first 4 bits
    );

    // Swap condition: a > b on last 4 bits or equal and first 4 bits swap
    or (swap, gt_last4, eq_last4, gt_first4);

endmodule
module sort_last_4_bits (
    input [7:0] num0, num1, num2, num3, num4, num5, num6, num7,
    output [7:0] sorted0, sorted1, sorted2, sorted3, sorted4, sorted5, sorted6, sorted7
);
    wire [7:0] sort0, sort1, sort2, sort3, sort4, sort5, sort6, sort7;
    wire swap0, swap1, swap2, swap3, swap4, swap5, swap6;

    // First round of comparisons and swaps
    comparator_8bit cmp0 (num0, num1, swap0);
    mux_8bit mux0 (num0, num1, swap0, sort0, sort1);
    
    comparator_8bit cmp1 (num2, num3, swap1);
    mux_8bit mux1 (num2, num3, swap1, sort2, sort3);

    comparator_8bit cmp2 (num4, num5, swap2);
    mux_8bit mux2 (num4, num5, swap2, sort4, sort5);

    comparator_8bit cmp3 (num6, num7, swap3);
    mux_8bit mux3 (num6, num7, swap3, sort6, sort7);

    // Second pass (Bubble sort second iteration) – repeat for full sorting
    comparator_8bit cmp4 (sort0, sort1, swap4);
    mux_8bit mux4 (sort0, sort1, swap4, sorted0, sorted1);

    comparator_8bit cmp5 (sort2, sort3, swap5);
    mux_8bit mux5 (sort2, sort3, swap5, sorted2, sorted3);

    comparator_8bit cmp6 (sort4, sort5, swap6);
    mux_8bit mux6 (sort4, sort5, swap6, sorted4, sorted5);

    // Final sorted values
    assign sorted6 = sort6;
    assign sorted7 = sort7;

endmodule
