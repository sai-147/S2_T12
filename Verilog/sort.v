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
