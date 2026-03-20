# mux_4x1_beh (4-to-1 Multiplexer, Behavioral - Verilog)

## 📌 Overview
This project implements a **4-to-1 multiplexer** using **behavioral modeling in Verilog**.  
The multiplexer selects one of four input signals (`in_0`, `in_1`, `in_2`, `in_3`) based on a 2-bit select signal (`select`) and routes it to the output (`m_out`).

---

## 🧠 Design Description

### ✔️ Module Features
- **4 input lines**: `in_0`, `in_1`, `in_2`, `in_3`
- **2-bit select line**: `select[1:0]`
- **1 output**: `m_out`
- Implemented using **case statement (behavioral modeling)**

---

## 🔧 Verilog Design Code

```verilog
// Behavioral description of four-to-one line multiplexer

module mux_4x1_beh
(
    input in_0, in_1, in_2, in_3,
    input [1:0] select,
    output reg m_out
);

always @ (in_0, in_1, in_2, in_3, select)
begin
    case(select)
        2'b00 : m_out <= in_0;
        2'b01 : m_out <= in_1;
        2'b10 : m_out <= in_2;
        2'b11 : m_out <= in_3;
    endcase
end

endmodule
```

---

## 🧪 Testbench Code

```verilog
`timescale 1ns/1ps

module mux_4x1_beh_tb;

    reg in_0, in_1, in_2, in_3;
    reg [1:0] select;
    wire m_out;

    // DUT instantiation
    mux_4x1_beh uut (
        .in_0(in_0),
        .in_1(in_1),
        .in_2(in_2),
        .in_3(in_3),
        .select(select),
        .m_out(m_out)
    );

    initial begin
        // Initialize inputs
        in_0 = 0; in_1 = 1; in_2 = 0; in_3 = 1;

        // Apply select values
        select = 2'b00; #20;
        select = 2'b01; #20;
        select = 2'b10; #20;
        select = 2'b11; #20;

        // Change inputs and repeat
        in_0 = 1; in_1 = 0; in_2 = 1; in_3 = 0;

        select = 2'b00; #20;
        select = 2'b01; #20;
        select = 2'b10; #20;
        select = 2'b11; #20;

        $stop;
    end

endmodule
```

---

## 📊 Simulation Result Analysis

### ✔️ Functional Verification
- `select = 00` → `m_out = in_0`
- `select = 01` → `m_out = in_1`
- `select = 10` → `m_out = in_2`
- `select = 11` → `m_out = in_3`

### ✔️ Waveform Interpretation
- Output correctly follows selected input
- When inputs change, output reflects updated value based on `select`
- No glitches observed → stable combinational logic

---

## 🖼️ Output Visualization

### 🔹 Schematic Diagram
- Shows a single multiplexer block (`Mux0`)
- Inputs grouped as `DATA[3..0]`
- Select line as `SEL[1..0]`
- Output labeled `m_out`

### 🔹 Simulation Waveform
- `select` cycles through `00 → 01 → 10 → 11`
- `m_out` switches accordingly to each input
- Behavior matches expected multiplexer logic

---

## 🚀 Key Takeaways
- Demonstrates **behavioral modeling using case statement**
- Clean and scalable approach for multiplexers
- Easily extendable to higher input sizes (e.g., 8x1, 16x1)
- Confirms correct synthesis and simulation in Quartus

---

## 📁 Project Info
- **Project Name**: mux_4x1_beh  
- **Tool**: Quartus Prime Lite 15.1  
- **Date**: March 20, 2026  

---

## ✅ Conclusion
The 4x1 multiplexer is successfully implemented and verified.  
Both schematic and waveform confirm correct functionality, making this a solid reference for **combinational logic design using Verilog behavioral modeling**.
