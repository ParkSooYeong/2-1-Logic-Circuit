# Prob5_51

## Overview

This project implements a **4-state synchronous Moore Finite State Machine (FSM)** in Verilog.

The FSM transitions between four states (`S0`–`S3`) according to the input signal `x_in`. Since this is a **Moore machine**, the output depends only on the current state and is completely independent of the current input value.

The simulation verifies correct state transitions, asynchronous reset behavior, and Moore-type output generation.

---

# Theory

## Moore Finite State Machine

A Moore FSM is a sequential circuit whose output depends only on its present state.

The operation of a Moore machine consists of two parts:

1. **State Register**
   - Stores the current state.
   - Updates only on the rising edge of the clock.
   - Returns to the initial state when reset is asserted.

2. **Next-State Logic**
   - Determines the next state from the current state and the input.

Unlike a Mealy machine, the output is generated only from the current state.

Mathematically,

```
Next State = f(Current State, Input)

Output = g(Current State)
```

Because the output changes only after a state transition, Moore machines generally provide more stable outputs than Mealy machines.

---

## State Diagram

State transitions are defined as follows.

| Current State | x_in = 0 | x_in = 1 | Output |
|--------------|----------|----------|--------|
| S0 | S0 | S1 | 0 |
| S1 | S1 | S2 | 0 |
| S2 | S2 | S3 | 1 |
| S3 | S3 | S0 | 1 |

The output is asserted whenever the FSM is in **S2** or **S3**.

---

# Verilog Implementation

The design consists of two functional blocks.

## 1. State Register

The state register stores the current state.

- Positive-edge triggered clock
- Active-low asynchronous reset
- Loads the next state every clock cycle

```verilog
always @(posedge clk, negedge reset)
```

When `reset` becomes low, the FSM immediately returns to `S0`.

---

## 2. Next-State and Output Logic

A combinational block determines both

- the next state
- the Moore output

using the current state and the input signal.

```verilog
always @(state, x_in)
```

The output is determined solely by the current state.

```
S0 → y_out = 0
S1 → y_out = 0
S2 → y_out = 1
S3 → y_out = 1
```

---

# Circuit Description

The synthesized circuit contains:

- One state register
- Combinational next-state logic
- Moore output logic

The state register updates on every rising clock edge, while the combinational logic continuously computes the next state and output.

Because the output depends only on the registered state, output transitions occur only after clock-triggered state updates.

---

# Simulation

The testbench applies:

- Clock generation
- Active-low asynchronous reset
- Multiple input transitions
- State transition verification

Simulation confirms that:

- The FSM initializes to **S0** after reset.
- State transitions follow the specified transition table.
- The output remains low in **S0** and **S1**.
- The output becomes high in **S2** and **S3**.
- The output changes only after state transitions, demonstrating correct Moore FSM behavior.

---

# Simulation Result

The waveform verifies the expected operation.

- Reset correctly initializes the FSM.
- Consecutive `x_in = 1` inputs advance the state through `S0 → S1 → S2 → S3`.
- When the FSM enters **S2** and **S3**, `y_out` becomes high.
- Additional `x_in = 1` transitions return the FSM to **S0**, causing the output to return low.
- Holding `x_in = 0` keeps the FSM in its current state according to the transition table.
- Output transitions occur only after clock-triggered state updates, confirming Moore machine characteristics.

The simulation matches the designed state transition behavior and verifies the correctness of the implementation.

---