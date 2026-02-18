# 4-bit Binary Adder (VHDL)

## 📌 Project Overview

This project implements a **4-bit binary adder with carry-in and carry-out** using VHDL (Dataflow modeling style).  
The design was synthesized and verified using Intel Quartus Prime 15.1 Lite Edition.

The adder performs the following operation:

Result = A + B + C_in

Where:
- A : 4-bit input  
- B : 4-bit input  
- C_in : Carry input (1-bit)  
- sum : 4-bit result output  
- C_out : Carry output (1-bit)  

---

## 📂 File Structure

binary_adder_vhdl.vhd      -- Main VHDL design file  
binary_adder_vhdl_tb.vhd   -- Testbench file  
README.md                  -- Project documentation  

---

## 🏗 Design Description

### Entity Declaration

    library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

    entity binary_adder_vhdl is
        port (
            A, B  : in  std_logic_vector(3 downto 0);
            C_in  : in  std_logic;
            sum   : out std_logic_vector(3 downto 0);
            C_out : out std_logic
        );
    end binary_adder_vhdl;

### Architecture (Dataflow)

The implementation uses the IEEE numeric_std library for unsigned arithmetic operations.

To correctly handle carry propagation, inputs are extended to 5 bits before addition.

    architecture Dataflow of binary_adder_vhdl is
        signal temp : unsigned(4 downto 0);
    begin
        temp <= unsigned('0' & A) +
                unsigned('0' & B) +
                (4 downto 1 => '0', 0 => C_in);

        sum   <= std_logic_vector(temp(3 downto 0));
        C_out <= temp(4);
    end Dataflow;

### 🔎 Key Design Features

- Uses numeric_std (recommended IEEE standard library)
- Proper type conversion using unsigned
- Explicit carry handling with 5-bit intermediate signal
- Fully synthesizable
- Compatible with VHDL-93 (Quartus 15.1)

---

## 🔧 Synthesis Information

Tool: Intel Quartus Prime 15.1 Lite Edition  
Modeling Style: Dataflow  
Result: Successful synthesis  
Compilation Status: No errors or warnings  

### RTL Viewer Result

The RTL schematic confirms:

- Internal 5-bit adder structure
- Correct bit-width extension for carry handling
- Carry-out extracted from MSB (temp(4))

The synthesized hardware matches the intended arithmetic operation.

---

## 🧪 Functional Simulation

Simulation was performed using the testbench file.

### Verified Test Cases

| A    | B    | C_in | sum  | C_out |
|------|------|------|------|--------|
| 0000 | 0000 | 0    | 0000 | 0      |
| 0101 | 0011 | 0    | 1000 | 0      |
| 1111 | 0001 | 0    | 0000 | 1      |
| 1010 | 0101 | 0    | 1111 | 0      |
| 1111 | 1111 | 0    | 1110 | 1      |

### Simulation Result

- Output waveform matches expected arithmetic results
- Carry-out correctly asserts on overflow
- No undefined (U) or high-impedance (Z) states observed
- Functional behavior verified

---

## 📐 Hardware Structure Summary

The synthesized circuit contains:

- 5-bit internal unsigned adder
- Carry extraction logic
- Proper signal type conversion logic
- Clean combinational structure (no latches or registers inferred)

---

## 🎯 Conclusion

This project successfully demonstrates:

- 4-bit binary addition with carry input/output
- Proper use of numeric_std for arithmetic operations
- Safe and synthesizable type conversion
- Verified functional correctness via simulation
- Successful RTL synthesis in Quartus

The design is fully synthesizable and hardware-ready.

