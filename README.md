# Priority-Based Waiting List Confirmation in Transportation

<!-- First Section -->
## Team Details
<details>
  <summary>Detail</summary>
	
  >Semester: 3rd Sem B. Tech. CSE
	
  >Section: S2

  >Team ID: S2-T12

  >Member-1: Parihasa K Reddy, 231CS239, <a href=""> parihasakreddy.231cs239@nitk.edu.in</a>
 
  >Member-2: R Sairam, 231CS245, <a href=""> sairam.231cs245@nitk.edu.in </a>
  
  >Member-3: Rishi Ramesh, 231CS248,<a href=""> rishiramesh.231cs248@nitk.edu.in </a>
</details>
<!-- Second Section -->

## Abstract
<details>
  <summary>Detail</summary>

  ### Motivation
In many real-time systems, such as seat allocation in transportation or event management, it is crucial to ensure that resource allocation is done promptly and fairly, prioritizing individuals based on predefined criteria. A priority-based allocation system ensures that individuals with higher importance—such as urgent needs, loyalty status, or special permissions—are given preference when resources, like seats, are limited.

A hardware-based solution for priority-based seat allocation ensures faster decision-making and enhances reliability in dynamic and time-sensitive environments. This system can be vital when delays or inefficient resource management could lead to dissatisfaction, safety risks, or lost opportunities.

---
  
  ### Problem Statement
Managing waiting lists based on priority is essential in critical resource allocation environments like healthcare and transportation. Conventional first-come, first-served methods neglect urgency, leading to inefficiencies. This project proposes a digital system for automated seat assignment that prioritizes requests, ensuring timely service and optimal resource utilization.

---

  ### Features
- **Real-Time Priority Assignment**: Assign real-time seats based on priority levels.
- **Hardware-Based Implementation**: Utilizes digital circuits for efficient processing.
- **Dynamic Request Handling**: Adapts to changing request priorities effectively.
- **Scalability and Adaptability**: Designed to accommodate varying system demands.
</details>

## Functional Block Diagram
<details>
  <summary>Detail</summary>
  
  ![Functional Block Diagram](https://github.com/sai-147/S2_T12/blob/main/Snapshots/DDS%20Block%20Diagram.png?raw=true)

</details>

<!-- Third Section -->
## Working
<details>
  <summary>Detail</summary>

**Description:** <br>

The system has 7 decimal inputs and several control switches (candidate, clear, clock, load, store, enable). We select 1-7 candidates via switches (D1-D7), store the selected candidate using the store button, and load the number of candidates into a down counter with the load and clock switches. Tokens are calculated based on the counter value.

After disabling the candidate switch, score inputs for each candidate (using switches D1-D4) are stored in registers based on their tokens. The scores are then sent to a comparator, where the top 3 candidates are selected using the Bitonic sorting algorithm. In the case of ties, priority is given to the lower token value, and their token values are displayed.

---

The following components were used in the design:

- **Switches (D1 to D7)**: These switches take input from candidates. The score switches (D1 to D4) are particularly used for score calculation.
- **Registers**: Registers store the candidates' scores and token values.
- **Down Counter**: This component counts down from the number of candidates (ranging from 1 to 7) to 0, determining the token values.
- **Comparator**: The Bitonic sorting algorithm compares the candidates' scores to rank them.
- **Clock, Load, Store, Clear, Enable Switches**: These control the input/output processes, clock signals, and data storage.
- **Bitonic Sorter**: A hardware-based comparator for sorting scores and determining the top 3 candidates based on their scores.
- **MUX (Multiplexer)**: This digital switch selects one of several input signals and forwards it to the output for comparison.
- **Subtractor**: It calculates the difference between two binary numbers, assisting in score comparison.
- **Bit Extender**: Extends the bit-width of input data to match the desired format for processing.

---

![Score Calculation Truth Table](https://github.com/sai-147/S2_T12/blob/main/Snapshots/Score%20Calculation_Truth%20Table.png?raw=true) <br>
_Figure 1: Truth Table for Score Calculation_

The simplified boolean expressions for the score calculation switches when the score switch is `1` are as follows:
- **B3** = D3 D4 + D1 D2 D4
- **B2** = D3 D'4 + D'1 D'3 D4 + D'2 D'3 D4 + D1 D2 D'4
- **B1** = D'1 D2 + D2 D3 + D1 D'2 D'3
- **B0** = D'1 D'3 + D1 D3

---

![Down Counter Truth Table](https://github.com/sai-147/S2_T12/blob/main/Snapshots/Down%20Counter_Truth%20Table.png?raw=true) <br>
_Figure 2: 3-Bit Down Counter (7 to 0)_

</details>


<!-- Fourth Section -->
## Logisim Circuit Diagram
<details>
  <summary>Detail</summary>

  ### Main Circuit
  ![Main Circuit](https://github.com/sai-147/S2_T12/blob/main/Snapshots/main%20Ckt.png?raw=true) <br>
  
  ### Counter Circuit
  ![Token Counter Circuit](https://github.com/sai-147/S2_T12/blob/main/Snapshots/Counter.png?raw=true)


  ### Score Calculator Circuit
  ![Score Calculator](https://github.com/sai-147/S2_T12/blob/main/Snapshots/score%20calculator.png?raw=true)

  ### Register Circuit
  > Storing score and token for each candidate in the Registers <br>

  ![Register](https://github.com/sai-147/S2_T12/blob/main/Snapshots/Register8.png?raw=true)

  ### Bitonic Comparator (1) Circuit
  ![BN1](https://github.com/sai-147/S2_T12/blob/main/Snapshots/BN%201.png?raw=true)

  ### Bitonic Comparator (2) Circuit
  ![BN2](https://github.com/sai-147/S2_T12/blob/main/Snapshots/BN%202.png?raw=true)

  ### Sorting Circuit
  ![Comparator](https://github.com/sai-147/S2_T12/blob/main/Snapshots/comparator.png?raw=true)
  
  </details>

<!-- Fifth Section -->
## Verilog Code
<details>
  <summary>Detail</summary>

  ### Gate-level modeling

  <details>
  <summary>Detail</summary>

```Verilog
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
```
</details>

  ### Behavioural modeling
  <details>
  <summary>Detail</summary>
	  
  #### Main module
  ```Verilog
//Team: S2-T12
//Team members:
//Parihasa K Reddy 231CS239
//R Sairam 231CS245
//Rishi Ramesh 231CS248 
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

```
#### Score module
```Verilog
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
```
#### Token module
```Verilog
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
```
#### Sort module
```Verilog
module sort_last_4_bits (
    input wire [7:0] num0,
    input wire [7:0] num1,
    input wire [7:0] num2,
    input wire [7:0] num3,
    input wire [7:0] num4,
    input wire [7:0] num5,
    input wire [7:0] num6,
    input wire [7:0] num7,
    output reg [7:0] sorted0,
    output reg [7:0] sorted1,
    output reg [7:0] sorted2,
    output reg [7:0] sorted3,
    output reg [7:0] sorted4,
    output reg [7:0] sorted5,
    output reg [7:0] sorted6,
    output reg [7:0] sorted7
);

    reg [7:0] sorted [0:7];
    integer i, j;

    // Combinational logic for sorting based on last 4 bits
    always @(*) begin
        // Initialize sorted array with input values
        sorted[0] = num0;
        sorted[1] = num1;
        sorted[2] = num2;
        sorted[3] = num3;
        sorted[4] = num4;
        sorted[5] = num5;
        sorted[6] = num6;
        sorted[7] = num7;

        // Bubble sort on the last 4 bits and, if equal, compare first 4 bits
        for (i = 0; i < 7; i = i + 1) begin
            for (j = 0; j < 7 - i; j = j + 1) begin
                if (sorted[j][3:0] > sorted[j + 1][3:0]) begin
                    // Swap if last 4 bits of j are greater than j+1
                    {sorted[j], sorted[j + 1]} = {sorted[j + 1], sorted[j]};
                end else if (sorted[j][3:0] == sorted[j + 1][3:0]) begin
                    // If last 4 bits are equal, compare first 4 bits
                    if (sorted[j][7:4] < sorted[j + 1][7:4]) begin
                        // Swap if the first 4 bits of j are smaller than j+1
                        {sorted[j], sorted[j + 1]} = {sorted[j + 1], sorted[j]};
                    end
                end
            end
        end

        // Assign sorted results to individual outputs
        sorted0 = sorted[0];
        sorted1 = sorted[1];
        sorted2 = sorted[2];
        sorted3 = sorted[3];
        sorted4 = sorted[4];
        sorted5 = sorted[5];
        sorted6 = sorted[6];
        sorted7 = sorted[7];
    end

endmodule

```
</details>

  ### Testbench
  <details>
  <summary>Detail</summary>
	  
  ```Verilog
module main_tb;

    reg [3:0]n;
    reg [3:0] c1, c2, c3, c4, c5, c6, c7;
    wire [3:0] r1, r2, r3;
    
    main test(
        .n(n),
        .c1(c1),
        .c2(c2),
        .c3(c3),
        .c4(c4),
        .c5(c5),
        .c6(c6),
        .c7(c7),
        .r1(r1),
        .r2(r2),
        .r3(r3)
    );

    initial begin
        n = 4'b0111;  // Set n to an initial value

        // Setting up input values
        c1 = 4'b1111;  // Corrected here
        c2 = 4'b0011;  
        c3 = 4'b0111;  
        c4 = 4'b1111;
        c5 = 4'b0111;
        c6 = 4'b0100;
        c7 = 4'b0111;

        #10;  

        // Displaying outputs
        $monitor("SEAT1: %d, SEAT2: %d, SEAT3:%d  ", r1,r2,r3);
        
        // Ending simulation
        $finish;
    end 
endmodule
```
</details>

### Testcase
  <details>
  <summary>Detail</summary>
	  
  CASE 1 <br>
  > Input <br>
	![Input 1](https://github.com/sai-147/S2_T12/blob/main/Snapshots/input_1.png?raw=true) <br>
  > Output <br>
  	![Output 1](https://github.com/sai-147/S2_T12/blob/main/Snapshots/output%201.png?raw=true) <br>

   ---

  CASE 2 <br>
   > Input <br>
  	![Input 2](https://github.com/sai-147/S2_T12/blob/main/Snapshots/input%202.png?raw=true) <br>
   > Output <br>
   	![Output 2](https://github.com/sai-147/S2_T12/blob/main/Snapshots/output%202.png?raw=true) <br>
  </details>

</details>

## References
<details>
  <summary>Detail</summary>

  - Verilog Basics <br>
	[https://www.chipverify.com/verilog/verilog-tutorial](https://www.chipverify.com/verilog/verilog-tutorial)

  - Digital System Design: Bitonic Sorter <br>
	[https://digitalsystemdesign.in/bitonic-sorter/](https://digitalsystemdesign.in/bitonic-sorter/)

  - Priority-Based Scheduling in Embedded Systems Design  
	[https://library.fiveable.me/key-terms/embedded-systems-design/priority-based-scheduling](https://library.fiveable.me/key-terms/embedded-systems-design/priority-based-scheduling)

  - Digital Design With An Introduction To The VHDL  
	[https://drive.google.com/file/d/0B3zMDnkiDz0MNVc4d040VE9qWGM/edit?resourcekey=0--PxnK4Y1ikmWLs4giZydXg](https://drive.google.com/file/d/0B3zMDnkiDz0MNVc4d040VE9qWGM/edit?resourcekey=0--PxnK4Y1ikmWLs4giZydXg)

</details>


</details>
