# 🖥️ MIPS-Based Digital Logic and Processor Simulator

A comprehensive **Computer Architecture & Logic Design** project that simulates the complete hierarchy of a processor—from basic logic gates to a functional Mini CPU—using **MIPS Assembly Language**.

This project demonstrates how digital logic circuits can be implemented entirely in software while following the same hierarchical approach used in real processor design.

---

## 📖 Project Overview

This simulator progressively builds a processor through four implementation phases:

- ✅ Phase 1 – Logic Gates
- ✅ Phase 2 – Half & Full Adders
- ✅ Phase 3 – 8-bit Arithmetic Logic Unit (ALU)
- ✅ Phase 4 – Mini CPU Simulator

The project was developed as part of the **Computer Architecture & Logic Design Lab (CEL-220)** course.

---

# 🚀 Features

### Phase 1 – Logic Gate Simulation
- AND Gate
- OR Gate
- NOT Gate
- Complete Truth Table Generation

### Phase 2 – Adder Circuits
- Half Adder
- Full Adder
- Carry Propagation Logic
- Truth Table Verification

### Phase 3 – 8-bit ALU
Supports:

- Addition (ADD)
- Subtraction (SUB)
- Bitwise AND
- Bitwise OR

Flag Generation:

- Zero Flag
- Negative Flag

---

### Phase 4 – Mini CPU

The Mini CPU includes:

- 4 General Purpose Registers (R0–R3)
- R0 hardwired to zero
- 256-byte Data Memory
- Instruction Memory
- Program Counter
- Fetch-Decode-Execute Cycle

Supported Instructions:

| Opcode | Instruction |
|---------|------------|
| 0 | ADD |
| 1 | SUB |
| 2 | AND |
| 3 | OR |
| 4 | LOAD |
| 5 | STORE |
| 7 | HALT |

---

# 🏗️ System Architecture

```
Logic Gates
      │
      ▼
Half Adder / Full Adder
      │
      ▼
8-bit ALU
      │
      ▼
Mini CPU
      │
      ├── Register File
      ├── Data Memory
      ├── Instruction Memory
      └── Control Unit
```

---

# 🧠 Demonstration Program

The Mini CPU executes the following program:

```
LOAD  R1, [0x10]
LOAD  R2, [0x11]
ADD   R3, R1, R2
STORE [0x12], R3
HALT
```

Example:

```
Memory[0x10] = 7
Memory[0x11] = 5

↓

R3 = 12

↓

Memory[0x12] = 12
```

---

# 📂 Project Structure

```
.
├── Project Proposal.pdf
├── Project Report.pdf
├── MIPS_Processor_Simulator.asm
└── README.md
```

---

# ⚙️ Technologies Used

- MIPS Assembly Language
- MARS Simulator
- Computer Architecture Concepts
- Digital Logic Design

---

# ▶️ How to Run

### 1. Install MARS Simulator

Download the MARS MIPS Simulator.

### 2. Open the Assembly File

Open:

```
MIPS_Processor_Simulator.asm
```

### 3. Assemble

Click:

```
Assemble
```

### 4. Run

Click:

```
Run
```

The program will execute all four phases automatically.

---

# 📋 Expected Output

The simulator prints:

- Logic Gate Truth Tables
- Half Adder Truth Table
- Full Adder Truth Table
- ALU Test Results
- Zero & Negative Flags
- Register File Status
- Memory Contents
- CPU Execution Trace
- HALT Message

---

# 🎯 Learning Outcomes

This project demonstrates:

- Digital Logic Design
- Boolean Algebra
- Combinational Circuits
- Processor Architecture
- Instruction Set Architecture (ISA)
- Register File Design
- Memory Organization
- ALU Design
- Fetch-Decode-Execute Cycle
- MIPS Assembly Programming

---


# 📖 References

- Computer Organization and Design – Patterson & Hennessy
- Computer Organization and Architecture – William Stallings
- MIPS32 Architecture Documentation
- MARS MIPS Simulator Documentation

---

# 📜 License

This project was developed for **educational purposes** as part of the Computer Architecture & Logic Design Lab course.

---

## ⭐ If you found this project useful, consider giving it a star!
