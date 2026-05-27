# Mealy Zero Detector in VHDL

## Overview

This project implements a **Mealy Zero Detector** using VHDL.

The design is based on a Mealy finite state machine (FSM), where the output depends on both the current state and the current input signal.

The project was designed and simulated using:

- Intel Quartus Prime Lite 15.1
- VHDL
- Functional Simulation

The project includes:

- Mealy Zero Detector module
- VHDL testbench
- RTL/Netlist synthesis
- Functional simulation

---

# Project Structure

```text
├── Mealy_Zero_Detector_vhdl.vhd
├── Mealy_Zero_Detector_vhdl_tb.vhd
└── README.md
```

---

# Module Description

The detector uses four states:

| State | Description |
|---|---|
| S0 | Initial state |
| S1 | Intermediate state |
| S2 | Detection state |
| S3 | Transition state |

The FSM transitions according to the input signal `x_in`.

The output `y_out` is generated based on:

- Current state
- Current input

which represents the behavior of a Mealy machine.

---

# Design Features

- Mealy finite state machine (FSM)
- Positive edge-triggered operation
- Asynchronous active-low reset
- Behavioral VHDL implementation
- Enumerated state type
- Functional verification through simulation

---

# State Transition Logic

The next-state logic is implemented using:

```vhdl
case state is
```

with conditional transitions depending on the value of `x_in`.

---

# Output Logic

The output is generated combinationally:

```vhdl
process(state, x_in)
```

The output depends on both:

- Current FSM state
- Current input signal

which is the defining characteristic of a Mealy FSM.

---

# Simulation Information

## Clock

- Clock period: 10 ns

## Total Simulation Time

- Approximately 200 ns

## Simulation Conditions

The simulation verifies:

- State transitions
- Reset operation
- Input pattern response
- Output generation
- FSM stability

---

# Functional Verification

The simulation waveform confirms:

- Correct state transitions
- Proper asynchronous reset behavior
- Correct Mealy output generation
- Stable FSM operation during clock transitions

The RTL schematic verifies the FSM structure and combinational output logic implementation.
