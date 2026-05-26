# Mealy Zero Detector in Verilog

## Overview

This project implements a **Mealy Zero Detector** using Verilog HDL.

The detector is designed as a finite state machine (FSM) with Mealy machine characteristics, where the output depends on both the current state and the input signal.

The design was created and simulated using:

- Intel Quartus Prime Lite 15.1
- Verilog HDL
- Functional Simulation

The project includes:

- Mealy Zero Detector module
- Testbench
- RTL/Netlist synthesis
- Functional simulation

---

# Project Structure

```text
├── Mealy_Zero_Detector.v
├── Mealy_Zero_Detector_tb.v
└── README.md
```

---

# Module Description

The design uses a 2-bit state register with four states:

| State | Binary |
|---|---|
| S0 | 00 |
| S1 | 01 |
| S2 | 10 |
| S3 | 11 |

The FSM transitions according to the input signal `x_in`.

The output `y_out` is generated based on:

- Current state
- Current input value

which is the characteristic behavior of a Mealy machine.

---

# Design Features

- Mealy finite state machine (FSM)
- Positive edge-triggered state transition
- Asynchronous active-low reset
- 2-bit state encoding
- Behavioral Verilog implementation
- Functional verification through simulation

---

# State Transition Logic

The next-state logic is implemented using:

```verilog
case (state)
```

with conditional transitions depending on `x_in`.

---

# Output Logic

The output logic is defined as:

```verilog
always @ (state or x_in)
```

The detector generates output depending on both the current state and the current input signal.

---

# Simulation Information

## Clock

- Clock period: 10 ns

## Total Simulation Time

- 200 ns

## Input Conditions

The simulation includes:

- Multiple input transitions
- Active-low reset operation
- State transition verification
- Output response verification

---

# Functional Verification

The simulation waveform verifies:

- Correct FSM state transitions
- Proper asynchronous reset behavior
- Correct Mealy output generation
- Stable operation during clock transitions

The synthesized RTL schematic confirms the FSM structure and output logic implementation.
