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
  > In many real-time systems, such as seat allocation in transportation or event management, it is crucial to ensure that resource allocation is done promptly and fairly, prioritizing individuals based on predefined criteria. A priority-based allocation system ensures that individuals with higher importance—such as those with urgent needs, loyalty status, or special permissions—are given preference when resources, like seats, are limited.
  > A hardware-based solution for priority-based seat allocation not only ensures faster decision-making but also enhances reliability in dynamic and time-sensitive environments. This system can be vital in situations where delays or inefficient resource management could lead to dissatisfaction, safety risks, or lost opportunities.
  
  ### Problem Statement
  > In critical resource allocation environments like healthcare and transportation, managing waiting lists based on priority is essential. Conventional first-come, first-served methods neglect urgency, leading to inefficiencies. This project proposes a digital system for automated seat assignment that prioritizes requests, ensuring timely service and optimal resource utilization.
  ### Features
  > - **Real-Time Priority Assignment**: Assigns seats based on priority levels in real-time.
  > - **Hardware-Based Implementation**: Utilizes digital circuits for efficient processing.
  > - **Dynamic Request Handling**: Adapts to changing request priorities effectively.
  > - **Scalability and Adaptability**: Designed to accommodate varying system demands.
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
There are 7 inputs in decimal numbers along with candidate, clear, clock, load, store, and enable switches. We take input from a number of candidates ranging from 1 to 7 (using switches D1 to D7) by applying the candidate switch and storing it in a register using the store button. We put the number of candidates into the down counter using the load and clock switches. We simultaneously calculate the tokens based on the counter value.

Disable the candidate switch and take inputs for score calculation using switches D1 to D4 for each candidate and store them in the corresponding register-based token generated. After calculating and storing the scores of each candidate, we send the values of registers to the comparator (using the Bitonic sorting algorithm). The top 3 candidates with the highest scores are selected; if there are ties, priority is given to the lesser value of the token, and their token values are displayed in order.

---

The following components were used in the design:

- **Switches (D1 to D7)**: These switches are used to take input from candidates. The score switches (D1 to D4) are particularly used for score calculation.
- **Registers**: Registers store the candidates' scores and token values.
- **Down Counter**: This component counts down from the number of candidates (ranging from 1 to 7) to 0, determining the token values.
- **Comparator**: The Bitonic sorting algorithm compares the candidates' scores to rank them.
- **Clock, Load, Store, Clear, Enable Switches**: These control the input/output processes, clock signals, and data storage.
- **Bitonic Sorter**: A hardware-based comparator for sorting scores and determining the top 3 candidates based on their scores.
- **MUX (Multiplexer)**: This is a digital switch that selects one of several input signals and forwards it to the output for comparison.
- **Subtractor**: It calculates the difference between two binary numbers, assisting in score comparison.
- **Bit Extender**: Extends the bit-width of input data to match the desired format for processing.

**Process Overview**:
1. Candidates input their values using switches D1 to D7.
2. The number of candidates is loaded into the down counter using the `load` and `clock` switches.
3. Scores are input using switches D1 to D4 and stored in corresponding registers.
4. The Bitonic sorting algorithm compares scores to identify the top 3 candidates, breaking ties based on token values.
5. The results are displayed, prioritizing candidates with higher scores or, in the event of a tie, those with lower token values.

---

![Score Calculation Truth Table](Score_Calculation.png)
_Figure: Truth Table for Score Calculation_

The simplified boolean expressions for the score calculation switches when the score switch is `1` are as follows:
- **B3** = D3 D4 + D1 D2 D4
- **B2** = D3 D'4 + D'1 D'3 D4 + D'2 D'3 D4 + D1 D2 D'4
- **B1** = D'1 D2 + D2 D3 + D1 D'2 D'3
- **B0** = D'1 D'3 + D1 D3

---

![3-Bit Down Counter](3bit_down_counter.png)
_Figure: 3-Bit Down Counter (7 to 0)_

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

  > Neatly update the Verilog code in code style only.
</details>

## References
<details>
  <summary>Detail</summary>

  - Verilog Basics <br>
	[https://www.chipverify.com/verilog/verilog-tutorial](https://www.chipverify.com/verilog/verilog-tutorial)

  - Digital System Design: Bitonic Sorter
	[https://digitalsystemdesign.in/bitonic-sorter/](https://digitalsystemdesign.in/bitonic-sorter/)

  - Priority-Based Scheduling in Embedded Systems Design  
	[https://library.fiveable.me/key-terms/embedded-systems-design/priority-based-scheduling](https://library.fiveable.me/key-terms/embedded-systems-design/priority-based-scheduling)

  - Digital Design With An Introduction To The VHDL  
	[https://drive.google.com/file/d/0B3zMDnkiDz0MNVc4d040VE9qWGM/edit?resourcekey=0--PxnK4Y1ikmWLs4giZydXg](https://drive.google.com/file/d/0B3zMDnkiDz0MNVc4d040VE9qWGM/edit?resourcekey=0--PxnK4Y1ikmWLs4giZydXg)

</details>


</details>
