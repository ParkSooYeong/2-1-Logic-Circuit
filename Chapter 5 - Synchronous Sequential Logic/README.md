# D Flip-Flop with Negative-Edge Trigger and Active-Low Reset (Verilog)

## Overview
This project implements a **negative-edge-triggered D Flip-Flop** with an **active-low asynchronous reset** using Verilog HDL.

The flip-flop updates its output `Q` on the **falling edge** of the clock signal.  
When the reset signal is asserted low (`reset = 0`), the output is immediately cleared regardless of the clock state.

---

## Features
- Verilog HDL implementation
- Negative-edge-triggered operation
- Active-low asynchronous reset
- Behavioral modeling using `always` block
- Functional simulation and waveform verification

---

## Verilog Module

```verilog
module D_Flip_Flop_3 (
    input D,
    input clock,
    input reset,
    output reg Q
);

always @ (negedge clock or negedge reset) begin
    if (!reset)
        Q <= 1'b0;
    else
        Q <= D;
end

endmodule
```

---

## Description

### Inputs
| Signal | Description |
|--------|-------------|
| `D` | Data input |
| `clock` | Clock input |
| `reset` | Active-low asynchronous reset |

### Output
| Signal | Description |
|--------|-------------|
| `Q` | Flip-flop output |

---

## Operation

### Reset Behavior
- When `reset = 0`
  - `Q` is immediately cleared to `0`
  - Independent of the clock

### Normal Operation
- When `reset = 1`
  - `Q` captures the value of `D`
  - Trigger occurs on the **falling edge** (`negedge`) of `clock`

---

## Timing Behavior

| Clock Edge | Reset | D | Q |
|------------|------|---|---|
| Falling Edge | 1 | 0 | 0 |
| Falling Edge | 1 | 1 | 1 |
| Any Time | 0 | X | 0 |

---

## Simulation Waveform

The simulation waveform verifies:

- Output changes only on the falling edge of the clock
- Reset clears the output asynchronously
- Output follows input `D` after reset is released

### Observed Behavior
1. `reset` is initially asserted low → `Q = 0`
2. After reset release, `Q` captures `D` at each falling clock edge
3. When reset becomes low again, `Q` immediately returns to `0`

---

## Tools Used
- Verilog HDL
- Intel Quartus Prime
- ModelSim

---

## Applications
- Sequential logic circuits
- Registers
- Counters
- Finite State Machines (FSM)
- Digital storage elements
