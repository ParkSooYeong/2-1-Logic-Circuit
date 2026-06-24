# Moore Model FSM (Behavioral and Structural VHDL)

## Overview

This project implements a four-state Moore Finite State Machine (FSM) using VHDL.

Two different implementations are provided:

- Behavioral FSM implementation
- Structural FSM implementation using T Flip-Flops

Both designs perform the same state transitions and generate the same output. The project demonstrates how a Moore FSM can be implemented either directly through state-machine description or by constructing the state machine from flip-flops and combinational logic.

---

# Theory

A Finite State Machine (FSM) is a sequential circuit whose behavior is determined by its current state and input signals.

A Moore FSM generates outputs that depend only on the current state. Unlike a Mealy FSM, input changes do not directly affect the output until a state transition occurs.

General characteristics of a Moore FSM:

- Output depends only on the current state.
- Outputs change only after state transitions.
- Stable and predictable output behavior.
- Commonly used in digital control systems.

In this project, the FSM contains four states and advances through the state sequence when the input `x_in` is asserted.

---

# State Definition

| State | Output (`y_out`) |
|---------|---------|
| S0 | 0 |
| S1 | 0 |
| S2 | 0 |
| S3 | 1 |

The output is asserted only when the FSM reaches state `S3`.

---

# State Transition Table

| Current State | x_in = 0 | x_in = 1 |
|---------------|----------|----------|
| S0 | S0 | S1 |
| S1 | S1 | S2 |
| S2 | S2 | S3 |
| S3 | S3 | S0 |

When `x_in` remains low, the FSM stays in its current state.

When `x_in` is high, the FSM advances through the sequence:

```text
S0 → S1 → S2 → S3 → S0
```

---

# Behavioral Implementation

The behavioral model uses an enumerated state type to represent the FSM states.

A state register stores the current state and is updated on the rising edge of the clock.

An active-low asynchronous reset initializes the FSM to state `S0`.

The output logic is implemented as:

```vhdl
y_out <= '1' when state = S3 else '0';
```

which ensures that the output depends solely on the current state.

---

# Structural Implementation

The structural model implements the same FSM using two T Flip-Flops.

The state is represented by two state bits:

```text
A = Most Significant Bit (MSB)
B = Least Significant Bit (LSB)
```

The excitation equations for the T Flip-Flops are:

```vhdl
TA = x_in and B
TB = x_in
```

The output equation is:

```vhdl
y_out = A and B
```

which produces a logic high only when the state corresponds to `S3`.

This implementation demonstrates how a state machine can be synthesized from lower-level sequential building blocks.

---

# Synthesized Circuit

The synthesized circuit consists of:

- State storage elements
- Clocked state-transition logic
- Active-low reset circuitry
- Output decoding logic

The behavioral implementation is synthesized into a finite-state machine structure, while the structural implementation is synthesized from interconnected T Flip-Flops and combinational logic.

The synthesized RTL schematic confirms that the FSM transitions are controlled by the input signal and that the output is generated from the state information.

---

# Simulation Verification

The simulation verifies the following behaviors:

- Correct initialization after reset
- Proper operation of the active-low reset signal
- State hold behavior when `x_in = 0`
- State advancement when `x_in = 1`
- Correct output assertion only in state `S3`
- Functional equivalence between behavioral and structural implementations

The waveform shows that:

- `t_y_out_1` (behavioral model output) and `t_y_out_2` (structural model output) remain identical throughout the simulation.
- State bits `A` and `B` follow the expected state sequence.
- Reset correctly returns the FSM to its initial state.
- Output transitions occur only when the FSM enters or leaves state `S3`.

These results confirm that both implementations realize the same Moore FSM behavior.

---

# Result

The Moore FSM was successfully implemented using both behavioral and structural VHDL design methodologies.

Synthesis results confirm the correct hardware realization of the state machine, while simulation results verify proper state transitions, reset functionality, and output generation.

The behavioral and structural implementations produce identical outputs, demonstrating that both approaches correctly implement the same four-state Moore FSM.
