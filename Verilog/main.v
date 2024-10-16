module main (
    input [3:0] n,
    input [3:0] c1, c2, c3, c4, c5, c6, c7,
    output [3:0] r1, r2, r3
);

    wire [3:0] s1, s2, s3, s4, s5, s6, s7;
    wire [3:0] t1, t2, t3, t4, t5, t6, t7;
    
    // Score Calculators
    score_calculator S1 (.d1(c1[3]), .d2(c1[2]), .d3(c1[1]), .d4(c1[0]), .score(s1));
    score_calculator S2 (.d1(c2[3]), .d2(c2[2]), .d3(c2[1]), .d4(c2[0]), .score(s2));
    score_calculator S3 (.d1(c3[3]), .d2(c3[2]), .d3(c3[1]), .d4(c3[0]), .score(s3));
    score_calculator S4 (.d1(c4[3]), .d2(c4[2]), .d3(c4[1]), .d4(c4[0]), .score(s4));
    score_calculator S5 (.d1(c5[3]), .d2(c5[2]), .d3(c5[1]), .d4(c5[0]), .score(s5));
    score_calculator S6 (.d1(c6[3]), .d2(c6[2]), .d3(c6[1]), .d4(c6[0]), .score(s6));
    score_calculator S7 (.d1(c7[3]), .d2(c7[2]), .d3(c7[1]), .d4(c7[0]), .score(s7));

    // Token Generation
    token TOKEN (
        .value(n),
        .token1(t1), .token2(t2), .token3(t3),
        .token4(t4), .token5(t5), .token6(t6), .token7(t7)
    );

    // Declare temp and sorted arrays
    wire [7:0] temp [0:7];  // 8 entries of 8 bits each
    wire [7:0] sorted [0:7]; // 8 entries of 8 bits each

    // Assign values to the temp array
    assign temp[0] = {4'b0000, 4'b0000};  
    assign temp[1] = {t1, s1};
    assign temp[2] = {t2, s2};
    assign temp[3] = {t3, s3};
    assign temp[4] = {t4, s4};
    assign temp[5] = {t5, s5};
    assign temp[6] = {t6, s6};
    assign temp[7] = {t7, s7};

    // Sort Module
    sort_last_4_bits uut (
        .num0(temp[0]), .num1(temp[1]), .num2(temp[2]), .num3(temp[3]),
        .num4(temp[4]), .num5(temp[5]), .num6(temp[6]), .num7(temp[7]),
        .sorted0(sorted[0]), .sorted1(sorted[1]), .sorted2(sorted[2]), .sorted3(sorted[3]),
        .sorted4(sorted[4]), .sorted5(sorted[5]), .sorted6(sorted[6]), .sorted7(sorted[7])
    );

    // Assigning outputs from sorted array
    assign r1 = sorted[7][7:4]; 
    assign r2 = sorted[6][7:4]; 
    assign r3 = sorted[5][7:4];

endmodule
