# JK Flip-Flop (Verilog)

## Overview

This project implements a **JK Flip-Flop** using:

- Combinational logic
- A custom D Flip-Flop module (`My_DFF`)

The JK Flip-Flop is one of the most important sequential logic circuits and extends the functionality of the SR Flip-Flop by eliminating the invalid state.

An asynchronous active-high reset (`rst`) is included.

---

# Theory

The characteristic equation of a JK Flip-Flop is:

```text
Q(next) = J·Q' + K'·Q
```

Where:

| J | K | Operation |
|---|---|---|
| 0 | 0 | Hold |
| 0 | 1 | Reset |
| 1 | 0 | Set |
| 1 | 1 | Toggle |

This design implements the JK Flip-Flop by converting it into a D Flip-Flop input equation.

---

# Verilog Source Code

## JK_Flip_Flop.v

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


module JK_Flip_Flop (
    input J,
    input K,
    input clk,
    input rst,
    output Q
);

    wire JK;

    // JK characteristic equation
    assign JK = (J & ~Q) | (~K & Q);

    My_DFF M0 (
        .Q(Q),
        .D(JK),
        .clk(clk),
        .rst(rst)
    );

endmodule
```

---

# Testbench

## JK_Flip_Flop_tb.v

```verilog
`timescale 1ns/1ps

module JK_Flip_Flop_tb;

    reg J;
    reg K;
    reg clk;
    reg rst;

    wire Q;

    // DUT
    JK_Flip_Flop uut (
        .J(J),
        .K(K),
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

        // Initial state
        J = 0;
        K = 0;
        rst = 1;

        #10;
        rst = 0;

        // Hold
        J = 0;
        K = 0;
        #20;

        // Reset
        J = 0;
        K = 1;
        #20;

        // Set
        J = 1;
        K = 0;
        #20;

        // Toggle
        J = 1;
        K = 1;
        #40;

        // Hold again
        J = 0;
        K = 0;
        #20;

        // Reset again
        J = 0;
        K = 1;
        #20;

        // Set again
        J = 1;
        K = 0;
        #20;

        $stop;
    end

endmodule
```

---

# RTL Schematic

The synthesized RTL schematic consists of:

- Two AND gates
- One OR gate
- One D Flip-Flop
- Feedback path from output `Q`

The combinational logic generates the D input according to the JK characteristic equation.

---

# Simulation Result

Simulation verifies the following operations:

| J | K | Result |
|---|---|---|
| 0 | 0 | Hold |
| 0 | 1 | Reset |
| 1 | 0 | Set |
| 1 | 1 | Toggle |

The waveform confirms that:

- Reset initializes `Q = 0`
- Toggle mode changes output on every positive clock edge
- Hold mode preserves the previous state

---

# Timing Behavior

## Reset

When:

```text
rst = 1
```

the output immediately resets:

```text
Q = 0
```

regardless of clock.

---

## Positive Edge Triggering

The D Flip-Flop updates output on:

```text
posedge clk
```

---

## Toggle Operation

When:

```text
J = 1
K = 1
```

the output toggles:

```text
0 → 1 → 0 → 1 ...
```

at every positive clock edge.

---

# Tools Used

- Quartus Prime Lite 15.1
- ModelSim-Altera
- Verilog HDL

---

# File Structure

```text
JK_Flip_Flop/
├── JK_Flip_Flop.v
├── JK_Flip_Flop_tb.v
├── simulation/
└── README.md
```
