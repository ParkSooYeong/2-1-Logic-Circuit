# JK Flip-Flop in Verilog

## Overview

This project implements a **JK Flip-Flop** in Verilog HDL.

The design was created and simulated using:

- Intel Quartus Prime Lite 15.1
- Verilog HDL
- Functional Simulation

The project includes:

- JK Flip-Flop module
- Testbench
- RTL/Netlist synthesis
- Functional simulation

---

# Project Structure

```text
├── JK_Flip_Flop_2.v
├── JK_Flip_Flop_2_tb.v
└── README.md
```

---

# Module Description

The JK Flip-Flop operates on the positive edge of the clock signal.

The module supports the standard JK Flip-Flop operations:

| J | K | Operation |
|---|---|---|
| 0 | 0 | Hold |
| 0 | 1 | Reset |
| 1 | 0 | Set |
| 1 | 1 | Toggle |

The complementary output `Q_b` is generated using:

```verilog
assign Q_b = ~Q;
```

---

# Design Features

- Positive edge-triggered JK Flip-Flop
- Complementary output support (`Q_b`)
- Behavioral Verilog implementation
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

The waveform also confirms that:

```text
Q_b = ~Q
```

throughout the simulation.
