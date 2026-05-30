# Moore Model FSM in Verilog

## Overview

This project implements a **Moore Finite State Machine (FSM)** using Verilog HDL.

The FSM consists of four states (`S0`, `S1`, `S2`, `S3`) and transitions between states according to the input signal `x_in`. The output is determined solely by the current state, which is the defining characteristic of a Moore machine.

The project was designed and verified using:

- Intel Quartus Prime Lite 15.1
- Verilog HDL
- Functional Simulation

The project includes:

- Moore FSM module
- Verilog testbench
- RTL synthesis
- Functional simulation

---

# Project Structure

```text
├── Moore_Model.v
├── Moore_Model_tb.v
└── README.md
```

---

# Module Description

The FSM uses four states encoded as 2-bit values.

| State | Binary Code |
|---------|------------|
| S0 | 00 |
| S1 | 01 |
| S2 | 10 |
| S3 | 11 |

State transitions are controlled by the input signal `x_in`.

The output is directly assigned to the current state:

```verilog
assign y_out = state;
```

Therefore:

| State | y_out |
|---------|--------|
| S0 | 00 |
| S1 | 01 |
| S2 | 10 |
| S3 | 11 |

---

# Design Features

- Moore finite state machine
- Four-state architecture
- Positive-edge triggered state transitions
- Asynchronous active-low reset
- State-encoded output
- Behavioral Verilog implementation
- Functional verification through simulation

---

# State Transition Logic

The FSM transitions according to the following rules:

| Current State | x_in = 0 | x_in = 1 |
|---------------|----------|----------|
| S0 | S1 | S0 |
| S1 | S2 | S3 |
| S2 | S3 | S2 |
| S3 | S0 | S3 |

---

# Reset Behavior

The FSM uses an asynchronous active-low reset:

```verilog
always @(posedge clock or negedge reset)
```

When:

```verilog
reset = 0
```

the state is immediately initialized to:

```verilog
S0
```

---

# Simulation Information

## Clock

- Clock period: 10 ns

## Total Simulation Time

- Approximately 200 ns

## Simulation Conditions

The simulation verifies:

- State transitions
- Active-low reset operation
- Output state encoding
- FSM stability
- Response to varying input patterns

---

# Functional Verification

Simulation results confirm:

- Correct state transitions according to the FSM design
- Proper asynchronous reset functionality
- Accurate state encoding on the output bus
- Stable operation under continuous clocking

The RTL schematic confirms successful synthesis of the Moore state machine and output logic.
