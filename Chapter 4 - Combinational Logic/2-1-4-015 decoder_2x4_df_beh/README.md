# decoder_2x4_df_beh

## Overview

`decoder_2x4_df_beh` is a 2-to-4 line decoder implemented in Verilog using Behavioral modeling style.  
The circuit takes two input signals (`A`, `B`) and one enable signal (`enable`) and generates four output lines (`D[0:3]`).

This design uses active-low output logic and an active-low enable signal.

---

## Functional Description

The decoder operates as follows:

- When `enable = 0` → one output line becomes LOW (0), others remain HIGH (1)
- When `enable = 1` → all outputs remain HIGH (1)

This means:

- Outputs are **active-low**
- Enable is **active-low**

---

## Logic Expression

Each output is defined as:

```
D[0] = !((!A) && (!B) && (!enable))
D[1] = !((!A) &&  B  && (!enable))
D[2] = !( A  && (!B) && (!enable))
D[3] = !( A  &&  B  && (!enable))
```

---

## Verilog Implementation

```verilog
module decoder_2x4_df_beh(
    input  A, B, enable,
    output reg [0:3] D
);

    always @(*) begin
        D[0] = !((!A) && (!B) && (!enable));
        D[1] = !((!A) &&  B  && (!enable));
        D[2] = !( A  && (!B) && (!enable));
        D[3] = !( A  &&  B  && (!enable));
    end

endmodule
```

---

## Truth Table (Active-Low Output)

| enable | A | B | D[0] | D[1] | D[2] | D[3] |
|--------|---|---|------|------|------|------|
| 0 | 0 | 0 | 0 | 1 | 1 | 1 |
| 0 | 0 | 1 | 1 | 0 | 1 | 1 |
| 0 | 1 | 0 | 1 | 1 | 0 | 1 |
| 0 | 1 | 1 | 1 | 1 | 1 | 0 |
| 1 | X | X | 1 | 1 | 1 | 1 |

(X = don't care)

---

## Simulation Description

The testbench verifies all 8 possible input combinations:

- A = 0 or 1
- B = 0 or 1
- enable = 0 or 1

Simulation confirms:

- When enable = 0 → only one output goes LOW
- When enable = 1 → all outputs remain HIGH
- No undefined (X) states observed
- Pure combinational logic (no clock dependency)

---

## Synthesis Characteristics

- Fully combinational logic
- No latches inferred
- No clock signal required
- Minimal logic resource usage
- Verified with Quartus Prime 15.1 Lite

---

## Project Structure

```
decoder_2x4_df_beh/
├── decoder_2x4_df_beh.v
├── decoder_2x4_df_beh_tb.v
└── README.md
```

---

## Notes

- Output bus declared as `[0:3]`
- Active-low design
- Suitable for FPGA and ASIC synthesis
- Behavioral modeling using `always @(*)`

---

## Author

Project: decoder_2x4_df_beh  
Date: February 28, 2026  
Revision: Behavioral Implementation  
