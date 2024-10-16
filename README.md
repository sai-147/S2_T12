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
  ![Main Circuit](https://raw.githubusercontent.com/sai-147/S2_T12/main/Snapshots/main.png) <br>
  
  ### Counter Circuit
  ![Token Counter Circuit](https://github.com/sai-147/S2_T12/blob/main/Snapshots/Counter.png?raw=true)


  ### Score Calculator Circuit
  ![Score Calculator](https://github.com/sai-147/S2_T12/blob/main/Snapshots/score%20calculator.png?raw=true)

  ### Register Circuit
  > Storing score and token for each candidate in the Registers <br>

  ![Register](https://github.com/sai-147/S2_T12/blob/main/Snapshots/Register.png?raw=true)

  ### Bitonic Comparator (1) Circuit
  ![BN1](https://github.com/sai-147/S2_T12/blob/main/Snapshots/BN1.png?raw=true)

  ### Bitonic Comparator (2) Circuit
  ![BN2](https://github.com/sai-147/S2_T12/blob/main/Snapshots/BN2.png?raw=true)

  ### Sorting Circuit
  ![Comparator](https://github.com/sai-147/S2_T12/blob/main/Snapshots/comparator.png?raw=true)
  
  </details>

<!-- Fifth Section -->
## Verilog Code
<details>
  <summary>Detail</summary>

  ### Gate-level modeling

  ```Verilog
  module Priority_Seat_Allocation (
      input [6:0] candidate,      // 7 candidate inputs
      input [3:0] scores,         // Score inputs for each candidate
      input clk,                  // Clock signal
      input load,                 // Load signal
      input store,                // Store signal
      input clear,                // Clear signal
      output reg [6:0] tokens,    // Output tokens
      output reg [3:0] selected   // Selected candidate based on priority
  );

  reg [3:0] candidate_scores [0:6]; // Array to hold scores for candidates

  always @(posedge clk) begin
      if (clear) begin
          tokens <= 7'b0; // Clear tokens
          selected <= 4'b0; // Clear selected candidate
      end
      if (load) begin
          candidate_scores[candidate] <= scores; // Load scores for candidates
      end
      if (store) begin
          // Logic to calculate tokens based on loaded scores
          // (example logic)
          tokens <= tokens + 1; // Update tokens
      end
  end

  always @(*) begin
      // Comparator logic for determining selected candidate based on scores
      // Implement bitonic sort or another selection logic here
      // For example:
      selected = (candidate_scores[0] > candidate_scores[1]) ? 0 : 1; // Simple comparison for demonstration
  end
  endmodule


  
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
