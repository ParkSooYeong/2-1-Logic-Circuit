# T Flip-Flop (Verilog)

## Overview

This project implements a **T Flip-Flop** using a custom D Flip-Flop module in Verilog HDL.

A T (Toggle) Flip-Flop changes its output state whenever:

- `T = 1`
- A positive clock edge occurs

When:

- `T = 0`

the output holds its previous value.

An asynchronous active-high reset (`rst`) is also included.

---

# Theory

The T Flip-Flop can be implemented using a D Flip-Flop with the equation:

```text
D = Q ⊕ T
```

Where:

| T | Current Q | Next Q |
|---|---|---|
| 0 | 0 | 0 |
| 0 | 1 | 1 |
| 1 | 0 | 1 |
| 1 | 1 | 0 |

This means:

- `T = 0` → Hold
- `T = 1` → Toggle

---

# Verilog Source Code

## T_Flip_Flop.v

```verilog
module My_DFF (
    output reg Q,
    input D,
    input clk,
    input rst
);

    always @(posedge clk or posedge rst) begin
        if (rst)
            Q <= 1'b0;
        else
            Q <= D;
    end

endmodule


module T_Flip_Flop (
    input T,
    input clk,
    input rst,
    output Q
);

    wire DT;

    assign DT = Q ^ T;

    My_DFF TF1 (
        .Q(Q),
        .D(DT),
        .clk(clk),
        .rst(rst)
    );

endmodule
```

---

# Testbench

## T_Flip_Flop_tb.v

```verilog
`timescale 1ns/1ps

module T_Flip_Flop_tb;

    reg T;
    reg clk;
    reg rst;

    wire Q;

    // DUT
    T_Flip_Flop uut (
        .T(T),
        .clk(clk),
        .rst(rst),
        .Q(Q)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Stimulus
    initial begin

        // Initial values
        T = 0;
        rst = 1;

        #10;
        rst = 0;

        // Hold state
        T = 0;
        #20;

        // Toggle mode
        T = 1;
        #40;

        // Hold again
        T = 0;
        #20;

        // Toggle again
        T = 1;
        #40;

        // Reset test
        rst = 1;
        #10;

        rst = 0;
        T = 1;
        #20;

        $stop;
    end

endmodule
```

---

# Simulation Result

Simulation confirms the following behavior:

- `rst = 1`
  - Output `Q` resets to `0`

- `T = 0`
  - Output `Q` holds its previous state

- `T = 1`
  - Output `Q` toggles at every positive clock edge

---

# RTL Schematic

The synthesized RTL schematic consists of:

- XOR gate
- D Flip-Flop
- Feedback path from `Q` to XOR input

This structure correctly implements a T Flip-Flop.

---

# Timing Diagram Summary

| Condition | Behavior |
|---|---|
| rst = 1 | Q reset to 0 |
| T = 0 | Hold state |
| T = 1 | Toggle on clock edge |

---

# Tools Used

- Quartus Prime Lite 15.1
- ModelSim-Altera
- Verilog HDL
