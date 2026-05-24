# JK Flip-Flop in VHDL

## Overview

This project implements a **JK Flip-Flop** in VHDL using a behavioral case-statement approach.

The design was created and simulated using:

- Intel Quartus Prime Lite 15.1
- VHDL
- Functional Simulation

The project includes:

- JK Flip-Flop module
- Testbench
- RTL/Netlist synthesis
- Functional simulation

---

# Project Structure

```text
├── JK_Flip_Flop_vhdl_2.vhd
├── JK_Flip_Flop_vhdl_2_tb.vhd
└── README.md
```

---

# Module Description

The JK Flip-Flop operates on the positive edge of the clock signal and supports asynchronous reset functionality.

The design uses a `case` statement to implement the JK Flip-Flop behavior.

---

# JK Flip-Flop Operations

| J | K | Operation |
|---|---|---|
| 0 | 0 | Hold |
| 0 | 1 | Reset |
| 1 | 0 | Set |
| 1 | 1 | Toggle |

The complementary output is generated using:

```vhdl
Q_b <= not Q;
```

---

# Design Features

- Positive edge-triggered JK Flip-Flop
- Asynchronous reset input
- Complementary output (`Q_b`)
- Behavioral VHDL implementation
- Case-statement based design
- Functional verification through simulation

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

The waveform also confirms that the complementary output behaves correctly:

```text
Q_b = not Q
```

throughout the simulation.
