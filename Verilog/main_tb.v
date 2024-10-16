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
