# Prob5_30

## Overview

This project implements a simple sequential logic circuit in Verilog HDL consisting of two cascaded D Flip-Flops and combinational logic.

The first stage registers the result of the logical OR operation between inputs `A` and `B`. The second stage registers the logical AND operation between the registered output `E` and input `C`.

Because both registers are updated on the same rising clock edge using non-blocking assignments, the output `Q` is generated using the **previous clock cycle's value of `E`**, introducing a one-clock-cycle pipeline delay.

---

# Theory

Sequential logic circuits store intermediate values using memory elements such as flip-flops. Unlike combinational circuits, their outputs depend not only on the current inputs but also on previously stored values.

A D Flip-Flop captures its input value on the rising edge of the clock and holds that value until the next clock event.

When multiple registers are updated within the same clocked process using non-blocking assignments (`<=`), every register is updated simultaneously after the clock edge. Consequently, a register cannot use another register's newly updated value during the same clock cycle.

In this design:

- The first register stores the result of `A OR B`.
- The second register computes `E AND C` using the **previously stored value of `E`**.

This behavior forms a simple two-stage sequential pipeline.

---

# Logic Equations

The circuit performs the following operations:

```text
E(next) = A OR B

Q(next) = E(current) AND C
```

where:

- `E(current)` is the value stored before the current clock edge.
- `E(next)` becomes available after the clock edge.

---

# Design Description

### Inputs

- `A`
- `B`
- `C`
- `clk`

### Outputs

- `E` : Registered output of `A OR B`
- `Q` : Registered output of `E AND C`

The output `Q` is delayed by one clock cycle because it uses the previously registered value of `E`.

---

# Circuit Operation

The synthesized circuit consists of:

- One OR gate
- One AND gate
- Two edge-triggered D Flip-Flops

The first D Flip-Flop stores the result of the OR gate.

The second D Flip-Flop stores the result of the AND gate, whose inputs are the registered value of `E` and input `C`.

This structure demonstrates a sequential data path in which data propagates through multiple register stages.

---

# Synthesized Circuit

The synthesized RTL schematic clearly shows two pipeline stages.

The first stage registers the output of the OR gate (`A OR B`).

The registered signal `E` is then fed into the AND gate together with input `C`, and the result is captured by the second D Flip-Flop to produce output `Q`.

The feedback path from the first register to the second combinational logic confirms that `Q` depends on the previously stored value of `E`, rather than the newly computed value during the same clock cycle.

---

# Simulation Verification

The simulation verifies the following behaviors:

- The OR operation correctly generates the registered signal `E`.
- The output `E` changes only on the rising edge of the clock.
- The output `Q` changes only on the rising edge of the clock.
- `Q` is generated using the previous clock value of `E`.
- Changes in inputs `A`, `B`, and `C` affect the outputs only after clock synchronization.

The waveform clearly demonstrates the one-clock-cycle delay between `E` and `Q`, confirming the expected behavior of non-blocking assignments in sequential logic.

---

# Result

The sequential circuit was successfully implemented and verified.

The synthesized circuit correctly realizes two cascaded D Flip-Flops with intermediate combinational logic, and the simulation confirms that the registered output `Q` is produced from the previously stored value of `E`, illustrating the timing characteristics of synchronous sequential circuits.
