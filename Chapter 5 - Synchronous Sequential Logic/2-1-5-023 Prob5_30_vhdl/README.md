# Prob5_30 (VHDL)

## Overview

This project implements a simple sequential circuit in VHDL using two cascaded D Flip-Flops and combinational logic.

The circuit first registers the result of the logical OR operation between inputs `A` and `B`. The registered value is then combined with input `C` through an AND operation, and the result is stored in a second register.

Since both registers are updated on the same rising clock edge, the second register uses the **previous clock cycle's value** of `E`, creating a one-clock-cycle pipeline delay between `E` and `Q`.

---

# Theory

Sequential logic circuits differ from combinational logic by incorporating memory elements such as flip-flops. Their outputs depend on both the current inputs and previously stored values.

A D Flip-Flop samples its input only on the active clock edge and stores that value until the next clock event.

When multiple registers are updated within the same clocked process using signal assignments (`<=`) in VHDL, all assignments occur simultaneously after the clock edge. Therefore, one register cannot immediately use another register's newly updated value during the same clock cycle.

For this design:

- The first register stores the result of `A OR B`.
- The second register stores the result of `E AND C`, where `E` is the value stored during the previous clock cycle.

This behavior demonstrates the timing characteristics of synchronous sequential circuits and simple pipelined data paths.

---

# Logic Equations

The circuit is described by the following equations:

```text
E(next) = A OR B

Q(next) = E(current) AND C
```

where:

- `E(current)` is the value stored before the current rising clock edge.
- `E(next)` becomes available after the current clock edge.

---

# Design Description

### Inputs

- `A`
- `B`
- `C`
- `clk`

### Outputs

- `E` : Registered output of the OR operation
- `Q` : Registered output of the AND operation

The circuit consists of two sequential stages:

1. Register the OR result of `A` and `B`.
2. Register the AND result between the stored value of `E` and input `C`.

Because both registers are clocked simultaneously, `Q` always reflects the previous value of `E`.

---

# Behavioral Implementation

The behavioral model uses two internal signals:

```vhdl
signal E_reg : std_logic;
signal Q_reg : std_logic;
```

On every rising edge of the clock:

```text
E_reg ← A OR B
Q_reg ← E_reg AND C
```

The outputs are continuously assigned as:

```vhdl
E <= E_reg;
Q <= Q_reg;
```

This implementation accurately models the timing behavior of two cascaded D Flip-Flops.

---

# Synthesized Circuit

The synthesized RTL schematic consists of:

- One OR gate
- One AND gate
- Two edge-triggered D Flip-Flops

The first flip-flop stores the output of the OR gate.

Its registered output is then connected to the AND gate together with input `C`, and the second flip-flop stores the resulting value.

The RTL schematic clearly illustrates a two-stage synchronous pipeline in which data propagates through successive register stages.

---

# Simulation Verification

The simulation verifies the following behaviors:

- Correct registration of the OR operation (`A OR B`) into `E`.
- `E` updates only on rising clock edges.
- `Q` updates only on rising clock edges.
- `Q` is generated using the previously stored value of `E`.
- Input changes occurring between clock edges do not immediately affect the outputs.
- The expected one-clock-cycle delay between `E` and `Q` is clearly observed.

The waveform confirms that both registered outputs change synchronously with the clock and that the sequential timing behavior matches the intended VHDL implementation.

---

# Result

The sequential circuit was successfully implemented using VHDL behavioral modeling.

RTL synthesis confirms that the design consists of two cascaded D Flip-Flops connected by simple combinational logic. Simulation results verify the correct operation of the synchronous pipeline, demonstrating proper clocked storage, logical computation, and the expected one-clock-cycle delay between the registered signals `E` and `Q`.
