# 🖥️ MIPS-Based Digital Logic and Processor Simulator

A comprehensive **Computer Architecture & Logic Design** project that simulates the complete hierarchy of a processor—from fundamental logic gates to a functional Mini CPU—using **MIPS Assembly Language**.

The project demonstrates how digital logic circuits can be implemented entirely in software while following the same hierarchical approach used in real processor design. It progressively builds increasingly complex components, beginning with Boolean logic gates and culminating in a simplified processor capable of executing instructions through a Fetch–Decode–Execute cycle.

---

## 📖 Project Overview

This simulator is divided into four implementation phases:

- ✅ Phase 1 – Logic Gate Simulation
- ✅ Phase 2 – Half & Full Adder Circuits
- ✅ Phase 3 – 8-bit Arithmetic Logic Unit (ALU)
- ✅ Phase 4 – Mini CPU Simulator

The project was developed as part of the **Computer Architecture & Logic Design Lab (CEL-220)** course.

---

# 🚀 Features

## 🔹 Phase 1 – Logic Gate Simulation

- AND Gate
- OR Gate
- NOT Gate
- Complete Truth Table Generation
- Boolean Logic Verification

---

## 🔹 Phase 2 – Adder Circuits

- Half Adder
- Full Adder
- Carry Propagation Logic
- Truth Table Verification

---

## 🔹 Phase 3 – 8-bit Arithmetic Logic Unit (ALU)

Supported Operations:

- ➕ Addition (ADD)
- ➖ Subtraction (SUB)
- 🔗 Bitwise AND
- 🔀 Bitwise OR

Generated Flags:

- Zero Flag
- Negative Flag

---

## 🔹 Phase 4 – Mini CPU

Implemented Components:

- 4 General Purpose Registers (R0–R3)
- R0 Hardwired to Zero
- 256-byte Data Memory
- Instruction Memory
- Program Counter (PC)
- Fetch–Decode–Execute Cycle
- Register File
- Memory Read/Write Operations

### Supported Instructions

| Opcode | Instruction | Description |
|---------|------------|-------------|
| 0 | ADD | Addition |
| 1 | SUB | Subtraction |
| 2 | AND | Bitwise AND |
| 3 | OR | Bitwise OR |
| 4 | LOAD | Load from Memory |
| 5 | STORE | Store to Memory |
| 7 | HALT | Stop Execution |

---

# 🏗️ System Architecture

```
           Logic Gates
               │
               ▼
      Half & Full Adders
               │
               ▼
         8-bit ALU
               │
               ▼
          Mini CPU
               │
    ┌──────────┼──────────┐
    │          │          │
Register   Data Memory  Control Unit
  File          │
                │
        Instruction Memory
```

---

# 🧠 Demonstration Program

The Mini CPU executes the following instruction sequence:

```assembly
LOAD  R1, [0x10]
LOAD  R2, [0x11]
ADD   R3, R1, R2
STORE [0x12], R3
HALT
```

### Example Execution

```
Memory[0x10] = 7
Memory[0x11] = 5

↓

LOAD Values into Registers

↓

ADD R1 + R2

↓

Result = 12

↓

STORE Result to Memory

↓

Memory[0x12] = 12
```

---

# 📂 Project Structure

```
📦 MIPS-Based-Digital-Logic-and-Processor-Simulator
│
├── Project Proposal.pdf
├── Project Report.pdf
├── MIPS_Processor_Simulator.asm
├── README.md
│
└── screenshots
    ├── phase1-output.png
    ├── phase2-output.png
    ├── phase3-output.png
    └── phase4-output.png
```

---

# ⚙️ Technologies Used

- MIPS Assembly Language
- MARS MIPS Simulator
- Computer Architecture Concepts
- Digital Logic Design

---

# ▶️ How to Run

## 1️⃣ Install MARS Simulator

Download and install the **MARS MIPS Simulator**.

---

## 2️⃣ Clone the Repository

```bash
git clone https://github.com/your-username/MIPS-Based-Digital-Logic-and-Processor-Simulator.git
```

Or simply download the ZIP file from GitHub.

---

## 3️⃣ Open the Project

Open

```
MIPS_Processor_Simulator.asm
```

inside the MARS Simulator.

---

## 4️⃣ Assemble

Click

```
Assemble
```

---

## 5️⃣ Run

Click

```
Run
```

The simulator will automatically execute all four phases.

---

# 📸 Program Output

Below are screenshots showing the execution of the simulator.

## Complete Output

<p align="center">
  <img src="screenshots/output.png" alt="Complete Program Output" width="900">
</p>

---

## Phase 1 – Logic Gate Verification

<p align="center">
  <img src="screenshots/phase1-output.png" alt="Phase 1 Output" width="900">
</p>

---

## Phase 2 – Adder Verification

<p align="center">
  <img src="screenshots/phase2-output.png" alt="Phase 2 Output" width="900">
</p>

---

## Phase 3 – 8-bit ALU Testing

<p align="center">
  <img src="screenshots/phase3-output.png" alt="Phase 3 Output" width="900">
</p>

---

## Phase 4 – Mini CPU Execution

<p align="center">
  <img src="screenshots/phase4-output.png" alt="Phase 4 Output" width="900">
</p>

---

# 📋 Expected Output

The simulator displays:

- ✅ AND Gate Truth Table
- ✅ OR Gate Truth Table
- ✅ NOT Gate Truth Table
- ✅ Half Adder Truth Table
- ✅ Full Adder Truth Table
- ✅ ALU Test Cases
- ✅ Zero & Negative Flags
- ✅ Register File State
- ✅ Data Memory Contents
- ✅ CPU Execution Trace
- ✅ HALT Message

---

# 🎯 Learning Outcomes

This project demonstrates practical implementation of:

- MIPS Assembly Programming
- Digital Logic Design
- Boolean Algebra
- Combinational Circuits
- Half & Full Adders
- Arithmetic Logic Unit (ALU)
- Register File Design
- Memory Organization
- Processor Architecture
- Instruction Set Architecture (ISA)
- Fetch–Decode–Execute Cycle
- Computer Organization Concepts

---

# 📖 References

- Computer Organization and Design – Patterson & Hennessy
- Computer Organization and Architecture – William Stallings
- MIPS32 Architecture Documentation
- MARS MIPS Simulator Documentation

---

# 📜 License

This project was developed for **educational purposes** as part of the **Computer Architecture & Logic Design Lab (CEL-220)** course.

Feel free to use this project for learning and academic reference.
