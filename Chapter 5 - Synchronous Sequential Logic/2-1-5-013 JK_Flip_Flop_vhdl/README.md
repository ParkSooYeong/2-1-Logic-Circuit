# JK Flip-Flop using D Flip-Flop (VHDL)

## Overview

This project implements a **JK Flip-Flop** in VHDL using a **D Flip-Flop** as the internal storage element.

The design was created and simulated using:

- Intel Quartus Prime Lite 15.1
- VHDL
- Functional Simulation

The project includes:

- D Flip-Flop module
- JK Flip-Flop module
- Testbench
- RTL/Netlist synthesis
- Functional simulation

---

# Project Structure

```text
├── JK_Flip_Flop_vhdl.vhd
├── JK_Flip_Flop_vhdl_tb.vhd
└── README.md
```

---

# JK Flip-Flop Logic

The JK Flip-Flop was implemented using the following next-state equation:

```text
Q(next) = JQ' + K'Q
```

This logic is connected to the input of the D Flip-Flop.

---

# D Flip-Flop Features

- Positive edge-triggered
- Asynchronous reset
- Behavioral VHDL implementation

---

# Simulation Information

## Clock

- Clock period: 10 ns

## Total Simulation Time

- 160 ns

## Test Cases

| J | K | Operation |
|---|---|---|
| 0 | 0 | Hold |
| 0 | 1 | Reset |
| 1 | 0 | Set |
| 1 | 1 | Toggle |

---

# Functional Verification

The simulation waveform verifies the expected JK Flip-Flop behavior:

- Hold operation when `J=0` and `K=0`
- Reset operation when `J=0` and `K=1`
- Set operation when `J=1` and `K=0`
- Toggle operation when `J=1` and `K=1`
