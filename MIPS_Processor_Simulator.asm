############################################################
# MIPS-BASED DIGITAL LOGIC AND PROCESSOR SIMULATOR v1.0
# CAD LAB PROJECT - BSE 3B
#
# PHASE 1: Logic Gates (AND, OR, NOT)
# PHASE 2: Adders (Half, Full)
# PHASE 3: 8-bit ALU (ADD, SUB, AND, OR) with flags
# PHASE 4: Mini CPU:
#           - 4-register register file (R0-R3, R0 read-only)
#           - Data memory (byte-addressed)
#           - Instruction memory (simple word-encoded ISA)
#           - Instructions: ADD, SUB, AND, OR, LOAD, STORE, HALT
#
# Assembler: MARS / QtSpim
############################################################

.data

############################################################
# BANNERS / PHASE HEADINGS
############################################################
banner:
    .asciiz "================================================================================\nMIPS-BASED DIGITAL LOGIC AND PROCESSOR SIMULATOR v1.0\n================================================================================\n\n"

phase1:
    .asciiz "==================== PHASE 1: GATE VERIFICATION ====================\n"
phase2:
    .asciiz "\n================ PHASE 2: ADDER VERIFICATION ==================\n"
phase3:
    .asciiz "\n=================== PHASE 3: 8-BIT ALU TESTING ==================\n"
phase4:
    .asciiz "\n===================== PHASE 4: MINI CPU EXECUTION ====================\n"

newline:   .asciiz "\n"
sep_line:  .asciiz "----------------------------------------------------------------\n"

############################################################
# GATE / ADDER TITLES
############################################################
and_title: .asciiz "\nAND Gate Truth Table (A & B):\nA B | OUT\n------------\n"
or_title:  .asciiz "\nOR Gate Truth Table (A | B):\nA B | OUT\n------------\n"
not_title: .asciiz "\nNOT Gate Truth Table (~A):\nA | OUT\n---------\n"

ha_title:  .asciiz "\nHalf Adder Truth Table:\nA B | SUM CARRY\n-------------------\n"
fa_title:  .asciiz "\nFull Adder Truth Table (A,B,Cin):\nA B Cin | SUM Cout\n-----------------------\n"

alu_title: .asciiz "\nALU Tests (8-bit, operations: ADD, SUB, AND, OR)\n"

text_A:    .asciiz "A = "
text_B:    .asciiz ", B = "
text_Cin:  .asciiz ", Cin = "
text_sum:  .asciiz " -> Sum = "
text_carry:.asciiz ", Carry = "
text_cout: .asciiz ", Cout = "
text_res:  .asciiz "Result = "
text_zero: .asciiz ", Zero = "
text_neg:  .asciiz ", Negative = "
text_op:   .asciiz "Operation: "

# Operation names
op_add: .asciiz "ADD\n"
op_sub: .asciiz "SUB\n"
op_and: .asciiz "AND\n"
op_or:  .asciiz "OR\n"

############################################################
# MINI CPU STRINGS
############################################################
cpu_title:
    .asciiz "\nMini CPU executing program: LOAD -> LOAD -> ADD -> STORE -> HALT\n"
cpu_pc_label:
    .asciiz "\n[CPU] PC = "
cpu_instr_label:
    .asciiz "  Opcode = "
cpu_reg_title:
    .asciiz "[CPU] Register File State (Simulated):\n"
cpu_mem_title:
    .asciiz "\n[CPU] Data Memory [0x10..0x12]: Input1, Input2, Result\n"
text_R0: .asciiz "R0 = "
text_R1: .asciiz "  R1 = "
text_R2: .asciiz "  R2 = "
text_R3: .asciiz "  R3 = "

text_mem_val: .asciiz "Mem[0x"
hex10: .asciiz "10] = "
hex11: .asciiz "11] = "
hex12: .asciiz "12] = "

halt_msg: .asciiz "HALT encountered. Stopping CPU.\n"

############################################################
# SIMULATED CPU STATE
############################################################

# 4-register register file for simulated CPU (R0-R3)
# R0 is treated as hardwired 0 by convention (writes ignored)
regfile:
    .word 0, 0, 0, 0

# Data memory (byte-addressed). We'll store 8-bit values at offsets.
data_mem:
    .space 256         # 256 bytes

# Instruction memory (word-organized)
# Each instruction = 4 words: [opcode, rd, rs, rt_or_imm]
#
# opcodes:
#   0 = ADD  (rd = reg[rs] + reg[rt])
#   1 = SUB  (rd = reg[rs] - reg[rt])
#   2 = AND  (rd = reg[rs] & reg[rt])
#   3 = OR   (rd = reg[rs] | reg[rt])
#   4 = LOAD (rd = Mem[imm])
#   5 = STORE(Mem[imm] = reg[rs])
#   7 = HALT
#
# Demo program:
#   LOAD R1, [0x10]       # Input1 = 7
#   LOAD R2, [0x11]       # Input2 = 5
#   ADD  R3, R1, R2       # R3 = 12
#   STORE [0x12], R3      # Result stored at 0x12
#   HALT
instr_mem:
    # instr 0: LOAD R1, [0x10]
    .word 4, 1, 0, 0x10
    # instr 1: LOAD R2, [0x11]
    .word 4, 2, 0, 0x11
    # instr 2: ADD R3, R1, R2
    .word 0, 3, 1, 2
    # instr 3: STORE [0x12], R3
    .word 5, 0, 3, 0x12
    # instr 4: HALT
    .word 7, 0, 0, 0

# Simulated Program Counter (instruction index, not byte address)
simPC:
    .word 0

.text
.globl main

############################################################
# main
############################################################
main:
    # Print banner
    li   $v0, 4
    la   $a0, banner
    syscall

    ########################################################
    # PHASE 1: GATES
    ########################################################
    li   $v0, 4
    la   $a0, phase1
    syscall

    jal  phase1_gates

    ########################################################
    # PHASE 2: ADDERS
    ########################################################
    li   $v0, 4
    la   $a0, phase2
    syscall

    jal  phase2_adders

    ########################################################
    # PHASE 3: 8-BIT ALU
    ########################################################
    li   $v0, 4
    la   $a0, phase3
    syscall

    jal  phase3_alu

    ########################################################
    # PHASE 4: MINI CPU
    ########################################################
    li   $v0, 4
    la   $a0, phase4
    syscall

    jal  phase4_cpu

    # Exit
    li   $v0, 4
    la   $a0, newline
    syscall

    li   $v0, 10
    syscall


############################################################
# ============  PHASE 1: GATE VERIFICATION  ================
############################################################
phase1_gates:
    addi $sp, $sp, -4
    sw   $ra, 0($sp)

    # AND Gate
    li   $v0, 4
    la   $a0, and_title
    syscall
    jal  gate_and_truth

    # OR Gate
    li   $v0, 4
    la   $a0, or_title
    syscall
    jal  gate_or_truth

    # NOT Gate
    li   $v0, 4
    la   $a0, not_title
    syscall
    jal  gate_not_truth

    lw   $ra, 0($sp)
    addi $sp, $sp, 4
    jr   $ra


# AND truth table: A,B in {0,1}
gate_and_truth:
    li  $t0, 0       # A
and_outer_loop:
    ble $t0, 1, and_inner_setup
    jr  $ra

and_inner_setup:
    li  $t1, 0       # B
and_inner_loop:
    ble $t1, 1, and_compute
    addi $t0, $t0, 1
    j   and_outer_loop

and_compute:
    and $t2, $t0, $t1

    # A
    li  $v0, 1
    move $a0, $t0
    syscall
    # space
    li  $v0, 11
    li  $a0, 32
    syscall
    # B
    li  $v0, 1
    move $a0, $t1
    syscall
    # " | "
    li  $v0, 11
    li  $a0, 32
    syscall
    li  $v0, 11
    li  $a0, 124
    syscall
    li  $v0, 11
    li  $a0, 32
    syscall
    # OUT
    li  $v0, 1
    move $a0, $t2
    syscall
    # newline
    li  $v0, 4
    la  $a0, newline
    syscall

    addi $t1, $t1, 1
    j    and_inner_loop


# OR truth table: A,B in {0,1}
gate_or_truth:
    li  $t0, 0
or_outer_loop:
    ble $t0, 1, or_inner_setup
    jr  $ra

or_inner_setup:
    li  $t1, 0
or_inner_loop:
    ble $t1, 1, or_compute
    addi $t0, $t0, 1
    j   or_outer_loop

or_compute:
    or  $t2, $t0, $t1

    # A
    li  $v0, 1
    move $a0, $t0
    syscall
    # space
    li  $v0, 11
    li  $a0, 32
    syscall
    # B
    li  $v0, 1
    move $a0, $t1
    syscall
    # " | "
    li  $v0, 11
    li  $a0, 32
    syscall
    li  $v0, 11
    li  $a0, 124
    syscall
    li  $v0, 11
    li  $a0, 32
    syscall
    # OUT
    li  $v0, 1
    move $a0, $t2
    syscall
    # newline
    li  $v0, 4
    la  $a0, newline
    syscall

    addi $t1, $t1, 1
    j    or_inner_loop


# NOT truth table: A in {0,1}, OUT = 1 - A
gate_not_truth:
    li  $t0, 0
not_loop:
    ble $t0, 1, not_compute
    jr  $ra

not_compute:
    li  $t1, 1
    sub $t2, $t1, $t0  # t2 = 1 - A

    # A
    li  $v0, 1
    move $a0, $t0
    syscall
    # " | "
    li  $v0, 11
    li  $a0, 32
    syscall
    li  $v0, 11
    li  $a0, 124
    syscall
    li  $v0, 11
    li  $a0, 32
    syscall
    # OUT
    li  $v0, 1
    move $a0, $t2
    syscall
    # newline
    li  $v0, 4
    la  $a0, newline
    syscall

    addi $t0, $t0, 1
    j    not_loop


############################################################
# ============  PHASE 2: ADDER VERIFICATION  ===============
############################################################
phase2_adders:
    addi $sp, $sp, -4
    sw   $ra, 0($sp)

    # Half Adder
    li   $v0, 4
    la   $a0, ha_title
    syscall
    jal  half_adder_truth

    # Full Adder
    li   $v0, 4
    la   $a0, fa_title
    syscall
    jal  full_adder_truth

    lw   $ra, 0($sp)
    addi $sp, $sp, 4
    jr   $ra


# Half adder truth table
half_adder_truth:
    li  $t0, 0
ha_outer:
    ble $t0, 1, ha_inner_setup
    jr  $ra

ha_inner_setup:
    li  $t1, 0
ha_inner:
    ble $t1, 1, ha_compute
    addi $t0, $t0, 1
    j    ha_outer

ha_compute:
    xor $t2, $t0, $t1   # sum
    and $t3, $t0, $t1   # carry

    # A
    li  $v0, 1
    move $a0, $t0
    syscall
    li  $v0, 11
    li  $a0, 32
    syscall

    # B
    li  $v0, 1
    move $a0, $t1
    syscall

    # " | "
    li  $v0, 11
    li  $a0, 32
    syscall
    li  $v0, 11
    li  $a0, 124
    syscall
    li  $v0, 11
    li  $a0, 32
    syscall

    # SUM
    li  $v0, 1
    move $a0, $t2
    syscall
    li  $v0, 11
    li  $a0, 32
    syscall
    # CARRY
    li  $v0, 1
    move $a0, $t3
    syscall

    li  $v0, 4
    la  $a0, newline
    syscall

    addi $t1, $t1, 1
    j    ha_inner


# Full adder truth table (A,B,Cin)
full_adder_truth:
    li  $t0, 0      # A
fa_outerA:
    ble $t0, 1, fa_outerB_setup
    jr  $ra

fa_outerB_setup:
    li  $t1, 0      # B
fa_outerB:
    ble $t1, 1, fa_innerCin_setup
    addi $t0, $t0, 1
    j    fa_outerA

fa_innerCin_setup:
    li  $t2, 0      # Cin
fa_innerCin:
    ble $t2, 1, fa_compute
    addi $t1, $t1, 1
    j    fa_outerB

fa_compute:
    # sum = A XOR B XOR Cin
    xor $t3, $t0, $t1   # A^B
    xor $t4, $t3, $t2   # sum

    # Cout = (A&B) OR (Cin & (A^B))
    and $t5, $t0, $t1
    and $t6, $t2, $t3
    or  $t7, $t5, $t6    # Cout

    # print A B Cin | SUM Cout
    # A
    li  $v0, 1
    move $a0, $t0
    syscall
    li  $v0, 11
    li  $a0, 32
    syscall

    # B
    li  $v0, 1
    move $a0, $t1
    syscall
    li  $v0, 11
    li  $a0, 32
    syscall

    # Cin
    li  $v0, 1
    move $a0, $t2
    syscall

    # " | "
    li  $v0, 11
    li  $a0, 32
    syscall
    li  $v0, 11
    li  $a0, 124
    syscall
    li  $v0, 11
    li  $a0, 32
    syscall

    # SUM
    li  $v0, 1
    move $a0, $t4
    syscall
    li  $v0, 11
    li  $a0, 32
    syscall

    # Cout
    li  $v0, 1
    move $a0, $t7
    syscall

    li  $v0, 4
    la  $a0, newline
    syscall

    addi $t2, $t2, 1
    j    fa_innerCin


############################################################
# ============  PHASE 3: 8-BIT ALU TESTING  ================
############################################################
phase3_alu:
    addi $sp, $sp, -4
    sw   $ra, 0($sp)

    li   $v0, 4
    la   $a0, alu_title
    syscall

    # Test 1: A=5, B=3, op=ADD
    li   $t0, 5
    li   $t1, 3
    li   $t2, 0     # ADD
    jal  alu_test_case

    # Test 2: A=7, B=10, op=SUB
    li   $t0, 7
    li   $t1, 10
    li   $t2, 1     # SUB
    jal  alu_test_case

    # Test 3: A=240, B=170, op=AND
    li   $t0, 240
    li   $t1, 170
    li   $t2, 2     # AND
    jal  alu_test_case

    # Test 4: A=240, B=15, op=OR
    li   $t0, 240
    li   $t1, 15
    li   $t2, 3     # OR
    jal  alu_test_case

    lw   $ra, 0($sp)
    addi $sp, $sp, 4
    jr   $ra


# alu_test_case
# Inputs:
#   $t0 = A
#   $t1 = B
#   $t2 = op (0=ADD,1=SUB,2=AND,3=OR)
alu_test_case:
    addi $sp, $sp, -8
    sw   $ra, 4($sp)
    sw   $s0, 0($sp)

    move $a0, $t0
    move $a1, $t1
    move $a2, $t2
    jal  alu_8bit        # returns result in $v0, flags in $v1

    move $s0, $v0        # result
    move $t3, $v1        # flags

    # Print operation name
    li   $v0, 4
    la   $a0, text_op
    syscall

    beq  $t2, 0, print_op_add
    beq  $t2, 1, print_op_sub
    beq  $t2, 2, print_op_and
    beq  $t2, 3, print_op_or
    j    after_op_name

print_op_add:
    li   $v0, 4
    la   $a0, op_add
    syscall
    j    after_op_name

print_op_sub:
    li   $v0, 4
    la   $a0, op_sub
    syscall
    j    after_op_name

print_op_and:
    li   $v0, 4
    la   $a0, op_and
    syscall
    j    after_op_name

print_op_or:
    li   $v0, 4
    la   $a0, op_or
    syscall

after_op_name:
    # A
    li   $v0, 4
    la   $a0, text_A
    syscall
    li   $v0, 1
    move $a0, $t0
    syscall

    # B
    li   $v0, 4
    la   $a0, text_B
    syscall
    li   $v0, 1
    move $a0, $t1
    syscall

    # Result
    li   $v0, 4
    la   $a0, text_res
    syscall
    li   $v0, 1
    move $a0, $s0
    syscall

    # Extract flags
    andi $t4, $t3, 1      # Zero
    srl  $t5, $t3, 1
    andi $t5, $t5, 1      # Negative

    li   $v0, 4
    la   $a0, text_zero
    syscall
    li   $v0, 1
    move $a0, $t4
    syscall

    li   $v0, 4
    la   $a0, text_neg
    syscall
    li   $v0, 1
    move $a0, $t5
    syscall

    li   $v0, 4
    la   $a0, newline
    syscall

    lw   $s0, 0($sp)
    lw   $ra, 4($sp)
    addi $sp, $sp, 8
    jr   $ra


# alu_8bit
# Inputs:
#   $a0 = A
#   $a1 = B
#   $a2 = op (0=ADD,1=SUB,2=AND,3=OR)
# Outputs:
#   $v0 = result (0..255)
#   $v1 = flags (bit0=Zero, bit1=Negative)
alu_8bit:
    andi $t0, $a0, 0xFF   # A
    andi $t1, $a1, 0xFF   # B
    li   $t2, 0           # result
    li   $t3, 0           # flags

    beq  $a2, 0, alu_add
    beq  $a2, 1, alu_sub
    beq  $a2, 2, alu_and
    beq  $a2, 3, alu_or
    j    alu_end_op

alu_add:
    addu $t2, $t0, $t1
    andi $t2, $t2, 0xFF
    j    alu_end_op

alu_sub:
    subu $t2, $t0, $t1
    andi $t2, $t2, 0xFF
    j    alu_end_op

alu_and:
    and  $t2, $t0, $t1
    andi $t2, $t2, 0xFF
    j    alu_end_op

alu_or:
    or   $t2, $t0, $t1
    andi $t2, $t2, 0xFF

alu_end_op:
    # Zero flag
    beq  $t2, $zero, alu_set_zero
    j    alu_skip_zero
alu_set_zero:
    ori  $t3, $t3, 1
alu_skip_zero:

    # Negative flag = bit7
    srl  $t4, $t2, 7
    andi $t4, $t4, 1
    beq  $t4, $zero, alu_skip_neg
    ori  $t3, $t3, 2
alu_skip_neg:

    move $v0, $t2
    move $v1, $t3
    jr   $ra


############################################################
# ============  PHASE 4: MINI CPU EXECUTION  ==============
############################################################
phase4_cpu:
    addi $sp, $sp, -4
    sw   $ra, 0($sp)

    # Print title
    li   $v0, 4
    la   $a0, cpu_title
    syscall

    # Initialize register file and data memory
    jal  cpu_init

    # Run CPU program
    jal  cpu_run

    # Print final memory state
    jal  cpu_print_final_mem

    lw   $ra, 0($sp)
    addi $sp, $sp, 4
    jr   $ra


# cpu_init
# - Clears regfile
# - Initializes data_mem[0x10] = 7, [0x11] = 5, [0x12] = 0
# - simPC = 0
cpu_init:
    # Clear regfile
    la   $t0, regfile
    li   $t1, 0
    sw   $t1, 0($t0)
    sw   $t1, 4($t0)
    sw   $t1, 8($t0)
    sw   $t1, 12($t0)

    # Initialize data memory
    la   $t2, data_mem
    li   $t3, 7
    sb   $t3, 0x10($t2)   # [0x10] = 7
    li   $t3, 5
    sb   $t3, 0x11($t2)   # [0x11] = 5
    li   $t3, 0
    sb   $t3, 0x12($t2)   # [0x12] = 0

    # simPC = 0
    la   $t4, simPC
    sw   $zero, 0($t4)

    jr   $ra


# cpu_run
# Fetch-decode-execute loop over instr_mem
cpu_run:
    addi $sp, $sp, -4
    sw   $ra, 0($sp)

cpu_loop:
    # Load simPC
    la   $t0, simPC
    lw   $t1, 0($t0)       # t1 = PC (instruction index)

    # Compute address of instruction: base + PC * 16
    la   $t2, instr_mem
    sll  $t3, $t1, 4       # *16 (4 words * 4 bytes)
    add  $t2, $t2, $t3

    lw   $t4, 0($t2)       # opcode
    lw   $t5, 4($t2)       # rd
    lw   $t6, 8($t2)       # rs
    lw   $t7, 12($t2)      # rt_or_imm

    # Print PC and opcode
    li   $v0, 4
    la   $a0, cpu_pc_label
    syscall
    li   $v0, 1
    move $a0, $t1
    syscall

    li   $v0, 4
    la   $a0, cpu_instr_label
    syscall
    li   $v0, 1
    move $a0, $t4
    syscall

    li   $v0, 4
    la   $a0, newline
    syscall

    # HALT?
    li   $t8, 7
    beq  $t4, $t8, cpu_halt

    # Decode and execute
    beq  $t4, 0, cpu_do_add
    beq  $t4, 1, cpu_do_sub
    beq  $t4, 2, cpu_do_and
    beq  $t4, 3, cpu_do_or
    beq  $t4, 4, cpu_do_load
    beq  $t4, 5, cpu_do_store
    j    cpu_after_exec

# ADD rd = reg[rs] + reg[rt]
cpu_do_add:
    # Read rs
    move $a0, $t6
    jal  reg_read
    move $s0, $v0       # val_rs

    # Read rt (in t7)
    move $a0, $t7
    jal  reg_read
    move $s1, $v0       # val_rt

    # Call ALU with op=0 (ADD)
    move $a0, $s0
    move $a1, $s1
    li   $a2, 0
    jal  alu_8bit
    move $s2, $v0       # result

    # Write rd
    move $a0, $t5
    move $a1, $s2
    jal  reg_write
    j    cpu_after_exec

# SUB rd = reg[rs] - reg[rt]
cpu_do_sub:
    move $a0, $t6
    jal  reg_read
    move $s0, $v0
    move $a0, $t7
    jal  reg_read
    move $s1, $v0

    li   $a2, 1         # SUB
    move $a0, $s0
    move $a1, $s1
    jal  alu_8bit
    move $s2, $v0

    move $a0, $t5
    move $a1, $s2
    jal  reg_write
    j    cpu_after_exec

# AND rd = reg[rs] & reg[rt]
cpu_do_and:
    move $a0, $t6
    jal  reg_read
    move $s0, $v0
    move $a0, $t7
    jal  reg_read
    move $s1, $v0

    li   $a2, 2         # AND
    move $a0, $s0
    move $a1, $s1
    jal  alu_8bit
    move $s2, $v0

    move $a0, $t5
    move $a1, $s2
    jal  reg_write
    j    cpu_after_exec

# OR rd = reg[rs] | reg[rt]
cpu_do_or:
    move $a0, $t6
    jal  reg_read
    move $s0, $v0
    move $a0, $t7
    jal  reg_read
    move $s1, $v0

    li   $a2, 3         # OR
    move $a0, $s0
    move $a1, $s1
    jal  alu_8bit
    move $s2, $v0

    move $a0, $t5
    move $a1, $s2
    jal  reg_write
    j    cpu_after_exec

# LOAD rd, [imm]
cpu_do_load:
    la   $t9, data_mem
    add  $t9, $t9, $t7   # address = data_mem + imm
    lb   $s0, 0($t9)

    move $a0, $t5       # rd
    move $a1, $s0
    jal  reg_write
    j    cpu_after_exec

# STORE [imm], rs
cpu_do_store:
    la   $t9, data_mem
    add  $t9, $t9, $t7   # address = data_mem + imm
    move $a0, $t6       # rs index
    jal  reg_read
    move $s0, $v0
    sb   $s0, 0($t9)
    j    cpu_after_exec

cpu_after_exec:
    # Print register file state
    jal  cpu_print_regfile

    # PC++
    la   $t0, simPC
    lw   $t1, 0($t0)
    addi $t1, $t1, 1
    sw   $t1, 0($t0)

    j    cpu_loop

cpu_halt:
    # HALT encountered
    li   $v0, 4
    la   $a0, newline
    syscall

    li   $v0, 4
    la   $a0, halt_msg
    syscall

    lw   $ra, 0($sp)
    addi $sp, $sp, 4
    jr   $ra


# reg_read(index) -> $v0
reg_read:
    # $a0 = index
    la   $t0, regfile
    sll  $t1, $a0, 2     # index * 4
    add  $t0, $t0, $t1
    lw   $v0, 0($t0)
    jr   $ra


# reg_write(index, value)
# If index == 0, ignore (R0 read-only by convention)
reg_write:
    beq  $a0, $zero, reg_write_return

    la   $t0, regfile
    sll  $t1, $a0, 2
    add  $t0, $t0, $t1
    sw   $a1, 0($t0)

reg_write_return:
    jr   $ra


# Print simulated register file
cpu_print_regfile:
    addi $sp, $sp, -4
    sw   $ra, 0($sp)

    li   $v0, 4
    la   $a0, cpu_reg_title
    syscall

    la   $t0, regfile
    lw   $t1, 0($t0)   # R0
    lw   $t2, 4($t0)   # R1
    lw   $t3, 8($t0)   # R2
    lw   $t4, 12($t0)  # R3

    # R0
    li   $v0, 4
    la   $a0, text_R0
    syscall
    li   $v0, 1
    move $a0, $t1
    syscall

    # R1
    li   $v0, 4
    la   $a0, text_R1
    syscall
    li   $v0, 1
    move $a0, $t2
    syscall

    # R2
    li   $v0, 4
    la   $a0, text_R2
    syscall
    li   $v0, 1
    move $a0, $t3
    syscall

    # R3
    li   $v0, 4
    la   $a0, text_R3
    syscall
    li   $v0, 1
    move $a0, $t4
    syscall

    li   $v0, 4
    la   $a0, newline
    syscall

    lw   $ra, 0($sp)
    addi $sp, $sp, 4
    jr   $ra


# Print final memory state for addresses 0x10,0x11,0x12
cpu_print_final_mem:
    addi $sp, $sp, -4
    sw   $ra, 0($sp)

    li   $v0, 4
    la   $a0, cpu_mem_title
    syscall

    la   $t0, data_mem

    # Mem[0x10]
    lb   $t1, 0x10($t0)
    li   $v0, 4
    la   $a0, text_mem_val
    syscall
    li   $v0, 4
    la   $a0, hex10
    syscall
    li   $v0, 1
    move $a0, $t1
    syscall
    li   $v0, 4
    la   $a0, newline
    syscall

    # Mem[0x11]
    lb   $t2, 0x11($t0)
    li   $v0, 4
    la   $a0, text_mem_val
    syscall
    li   $v0, 4
    la   $a0, hex11
    syscall
    li   $v0, 1
    move $a0, $t2
    syscall
    li   $v0, 4
    la   $a0, newline
    syscall

    # Mem[0x12]
    lb   $t3, 0x12($t0)
    li   $v0, 4
    la   $a0, text_mem_val
    syscall
    li   $v0, 4
    la   $a0, hex12
    syscall
    li   $v0, 1
    move $a0, $t3
    syscall
    li   $v0, 4
    la   $a0, newline
    syscall

    lw   $ra, 0($sp)
    addi $sp, $sp, 4
    jr   $ra