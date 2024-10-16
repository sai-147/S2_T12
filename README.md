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

  > Explain how your model works with the help of a functional table (compulsory) followed by the flowchart. 

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

  - Verilog Basics
	[https://www.chipverify.com/verilog/verilog-tutorial](https://www.chipverify.com/verilog/verilog-tutorial)

  - Digital System Design: Bitonic Sorter
	[https://digitalsystemdesign.in/bitonic-sorter/](https://digitalsystemdesign.in/bitonic-sorter/)

  - Priority-Based Scheduling in Embedded Systems Design  
	[https://library.fiveable.me/key-terms/embedded-systems-design/priority-based-scheduling](https://library.fiveable.me/key-terms/embedded-systems-design/priority-based-scheduling)

  - Digital Design With An Introduction To The VHDL  
	[https://drive.google.com/file/d/0B3zMDnkiDz0MNVc4d040VE9qWGM/edit?resourcekey=0--PxnK4Y1ikmWLs4giZydXg](https://drive.google.com/file/d/0B3zMDnkiDz0MNVc4d040VE9qWGM/edit?resourcekey=0--PxnK4Y1ikmWLs4giZydXg)

</details>


</details>
